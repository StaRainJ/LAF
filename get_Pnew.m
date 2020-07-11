function [P, E]=get_Pnew(Dos, sigma1, sigma2 ,gamma)
% GET_P estimates the posterior probability and part of the energy.

D = 2;
temp1 = exp(-Dos/(2*sigma1));
% temp2 = (2*pi*sigma2)^(D/2)*(1-gamma)/(gamma*a);
temp2 = (2*pi*sigma2)^(D/2)*exp(-Dos/(2*sigma2))*(1-gamma)/(gamma);
P=temp1./(temp1+temp2);
E=P'*Dos/(2*sigma2)+sum(P)*log(sigma2)*D/2;