import math
import numpy as np

ndarts = 8192 # number of darts to per throw
nthrows = 10_000_000 # number of throws
nsamples = nthrows * ndarts # total number of darts thrown

def throw_darts(run):
    darts = np.random.rand(ndarts,2) # Make a random matrix with ndarts by 2 
    radi = np.sum(np.square(darts), axis=1) # square each element of matrix 
    hits = np.sum(radi < 1) # count the daarts in the circle
    return hits

def monte_carlo_pi():
    hits = 0
    for i in range(nthrows):
        hits += throw_darts(i)
    return 4.0 * hits / nsamples # pi is 4 time the ratio 


my_pi = monte_carlo_pi()
diff = math.pi - my_pi
print("Samples= {0:.1f}, my_pi= {1:2.10f}, diff={2:2.10f}".format(nsamples, my_pi,diff))
print()
