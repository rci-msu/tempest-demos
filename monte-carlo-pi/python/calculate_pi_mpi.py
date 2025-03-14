import random
import math
import numpy as np
from mpi4py import MPI 

# MPI Variables
comm = MPI.COMM_WORLD
size = comm.Get_size()
rank = comm.Get_rank()

ndarts = 8192 # number of darts
nthrows = 10_000_000 # number of throws
throws_per_task = math.ceil(nthrows / size) # for each task throw this much
nsamples = throws_per_task * size * ndarts # total  

def throw_darts(run):
    darts = np.random.rand(ndarts,2) # Make a random matrix with ndarts by 2 
    radi = np.sum(np.square(darts), axis=1) # square each element of matrix 
    hits = np.sum(radi < 1) # count the daarts in the circle
    return hits

hits = np.zeros(throws_per_task, dtype=int) # have place to save all throws

for i in range(throws_per_task):
    hits[i] = throw_darts(rank)

sendbuf = np.sum(hits) # send the sum of all the hits

recvbuf = None # do not make recivee buffer
if rank ==0:
    recvbuf = np.empty(size, dtype=int)  # have a place to save all the messages

comm.Gather(sendbuf, recvbuf, root=0) # save all the messages from everyone

if rank == 0: # only needs to be ran on 0
    total = sum(recvbuf)
    my_pi = 4.0 * total/ nsamples 
    diff = math.pi - my_pi
    print("Samples= {0:.1f}, my_pi= {1:2.10f}, diff={2:2.10f}".format(nsamples, my_pi, diff))
    print()
