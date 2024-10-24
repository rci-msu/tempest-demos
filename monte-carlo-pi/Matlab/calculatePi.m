% calculate Pi Dartboard Method
function [myPi,timeEl] = calculatePi(nDarts,nThrows)
tic
darts = zeros(nDarts,2);
count = 0;
for i = 1:nThrows
   darts = rand(nDarts,2);
   polar = darts(:,1).^2 + darts(:,2).^2;
   count = count + sum(polar <=1);
end
total = nDarts * nThrows;
myPi =  4 * count / total;
timeEl = toc;