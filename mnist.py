# baseline cnn model for mnist
import os
import sys
from numpy import mean
from numpy import std
from models import define_model
import tensorflow as tf
from matplotlib import pyplot as plt
from sklearn.model_selection import KFold
from tensorflow.keras.datasets import mnist
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Conv2D
from tensorflow.keras.layers import MaxPooling2D
from tensorflow.keras.layers import Dense
from tensorflow.keras.layers import Flatten
from tensorflow.keras.optimizers import SGD
from tensorflow.keras.callbacks import EarlyStopping

#mirrored_strategy = tf.distribute.MirroredStrategy()

modelNumber = int(sys.argv[1])

## ONLY USE When not in Container
## Maximum number of threads to use for OpenMP parallel regions.
#os.environ["OMP_NUM_THREADS"] = str(16)
## Without setting below 2 environment variables, it didn't work for me. Thanks to @cjw85
#os.environ["TF_NUM_INTRAOP_THREADS"] = str(8)
#tf.config.threading.set_intra_op_parallelism_threads(8)
#os.environ["TF_NUM_INTEROP_THREADS"] = str(16)
#tf.config.threading.set_inter_op_parallelism_threads(16) 
#tf.config.set_soft_device_placement(enabled)

# load train and test dataset
def load_dataset():
	# load dataset
	(trainX, trainY), (testX, testY) = mnist.load_data()
	# reshape dataset to have a single channel
	trainX = trainX.reshape((trainX.shape[0], 28, 28, 1))
	testX = testX.reshape((testX.shape[0], 28, 28, 1))
	# one hot encode target values
	trainY = to_categorical(trainY)
	testY = to_categorical(testY)
	return trainX, trainY, testX, testY
 
# scale pixels
def prep_pixels(train, test):
	# convert from integers to floats
	train_norm = train.astype('float32')
	test_norm = test.astype('float32')
	# normalize to range 0-1
	train_norm = train_norm / 255.0
	test_norm = test_norm / 255.0
	# return normalized images
	return train_norm, test_norm

# evaluate a model using k-fold cross-validation
def evaluate_model(dataX, dataY, vb, n_folds, eps):
	bsz = 32
	scores, histories = list(), list()
	# set up early stopping
	es = EarlyStopping(monitor='val_accuracy', mode='min', verbose=1, patience=2)
	# show model
	model = define_model(modelNumber)
	model.summary()
    # prepare cross validation
	kfold = KFold(n_folds, shuffle=True, random_state=1)
	# enumerate splits
	for train_ix, test_ix in kfold.split(dataX):
		# define model
		model = define_model(modelNumber)
		# select rows for train and test
		trainX, trainY, testX, testY = dataX[train_ix], dataY[train_ix], dataX[test_ix], dataY[test_ix]
		# fit model
		history = model.fit(trainX, trainY, epochs=eps, batch_size=bsz, \
                        validation_data=(testX, testY), verbose=vb, callbacks=[es])
		# evaluate model
		_, acc = model.evaluate(testX, testY, verbose=vb)
		print('> %.3f' % (acc * 100.0))
		# stores scores
		scores.append(acc)
		histories.append(history)
	return scores, histories
 
# plot diagnostic learning curves
def summarize_diagnostics(histories):
	for i in range(len(histories)):
		# plot loss
		plt.subplot(2, 1, 1)
		plt.title('Cross Entropy Loss')
		plt.plot(histories[i].history['loss'], color='blue', label='train')
		plt.plot(histories[i].history['val_loss'], color='orange', label='test')
		# plot accuracy
		plt.subplot(2, 1, 2)
		plt.title('Classification Accuracy')
		plt.plot(histories[i].history['accuracy'], color='blue', label='train')
		plt.plot(histories[i].history['val_accuracy'], color='orange', label='test')
	plt.savefig('loss.png')
 
# summarize model performance
def summarize_performance(scores):
	# print summary
	print('Accuracy: mean=%.3f std=%.3f, n=%d' % (mean(scores)*100, std(scores)*100, len(scores)))
	# box and whisker plots of results
	#plt.boxplot(scores)
	#plt.savefig('boxplot.png')
 
# run the test harness for evaluating a model
def run_test_harness():
	# load dataset
	trainX, trainY, testX, testY = load_dataset()
	# prepare pixel data
	trainX, testX = prep_pixels(trainX, testX)
	# evaluate model
	scores, histories = evaluate_model(trainX, trainY, 1, 10, 20)
	# learning curves
	#summarize_diagnostics(histories)
	# summarize estimated performance
	summarize_performance(scores)
 
# entry point, run the test harness
run_test_harness()
