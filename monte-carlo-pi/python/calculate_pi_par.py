import random
import math
import numpy as np
from multiprocessing import Pool

procs = 32 # number of cpus
ndarts = 8192 # number of darts
nthrows = 10_000_000 # number of throws
nsamples = nthrows * ndarts # total  

def throw_darts(run):
    darts = np.random.rand(ndarts,2) # Make a random matrix with ndarts by 2 
    radi = np.sum(np.square(darts), axis=1) # square each element of matrix 
    hits = np.sum(radi < 1) # count the daarts in the circle
    return hits

def monte_carlo_pi_pool():
    hits = 0
    with Pool(procs) as p: # throw many darts at once
        a = p.map(throw_darts,range(nthrows) ) # returns a list of hits
    hits = sum(a) # sum up all hits
    return 4.0 * hits / nsamples 

my_pi = monte_carlo_pi_pool()
diff = math.pi - my_pi
print("Samples= {0:.1f}, my_pi= {1:2.10f}, diff={2:2.10f}".format(nsamples, my_pi, diff))
print()
