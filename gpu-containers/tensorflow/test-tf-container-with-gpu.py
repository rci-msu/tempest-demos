import tensorflow as tf


print(f"tensorflow version: {tf.__version__}")
print("Num GPUs Available: ", len(tf.config.list_physical_devices("GPU")))

# Check if TensorFlow can access the GPU
physical_devices = tf.config.list_physical_devices('GPU')

if physical_devices:
    print("TensorFlow is using the following GPU(s):")
    for device in physical_devices:
        print(device)
else:
    print("No GPU detected. TensorFlow will use the CPU.")