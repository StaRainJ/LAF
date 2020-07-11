function [P, E]=get_P(Dos, sigma2 ,gamma, a)
% GET_P estimates the posterior probability and part of the energy.

D = 2;
temp1 = exp(-Dos/(2*sigma2));
temp2 = (2*pi*sigma2)^(D/2)*(1-gamma)/(gamma*a);
P=temp1./(temp1+temp2);
E=P'*Dos/(2*sigma2)+sum(P)*log(sigma2)*D/2;