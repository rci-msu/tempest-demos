import random
import math

ndarts = 8192 # number of darts to per throw
nthrows = 1_000_000 # number of throws
nsamples = nthrows * ndarts # total number of darts thrown

def throw_darts(run):
    hits = 0 # start with no hits
    for i in range(int(ndarts)):
        x = random.random()
        y = random.random()
        if (x ** 2 + y ** 2) < 1.0: # if the dart is in the circle
            hits += 1
    return hits

def monte_carlo_pi():
    hits = 0
    for i in range(nthrows):
        hits += throw_darts(i)
    return 4.0 * hits / nsamples # pi is 4 time the ratio 


my_pi = monte_carlo_pi()
diff = math.pi - my_pi
print("Samples= {0:.1f}, my_pi= {1:2.10f}, diff={2:2.10f}".format(nsamples, my_pi, diff))
print()
