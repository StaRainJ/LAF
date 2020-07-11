function f2 = DosEstimation(CP,Vnew,h)
%% Dos: density of sample
D = pdist2(CP,Vnew);
temp = exp(-D.^2./(2*h.^2))./sqrt(2*pi);
f2 = sum(temp) ./(size(CP,1)*h);