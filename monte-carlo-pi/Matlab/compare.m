
parpool(128)

darts = 1024
throws = 1E7

[piS, timeS] = calculatePi(darts,throws)
[piP, timeP] = calculatePiPar(darts,throws)

speedUp = timeS/timeP
