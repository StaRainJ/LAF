function [dev,distV,Dos]=CostCalculate(Vnew,mainV,Lxy,f2,h,gamma)
distV=[]; Dos=[];
for i = 1:size(Vnew,1)
    temp4 = Vnew(i, :);
    temp5 = permute( mainV(Lxy(i, 1), Lxy(i,2), :), [3 2 1] )';
%     L1 = temp4*temp4';
%     L2 = temp5*temp5';
%     C_sita(i) =0.5.*(1- temp4*temp5'./sqrt(L1*L2+0.000001));
%     C_L(i)    =1-exp( -(1- min(L1,L2)/(max(L1,L2)+0.00001)).^2./0.05); 
%     distV(i,:)=C_sita(i).*C_L(i);
%     distV(i,:)=1-exp(-(temp4-temp5)*(temp4-temp5)'./(mean([L1;L2])+0.000001)./1);
     Dos(i,:) = (temp4-temp5)*(temp4-temp5)';
    distV(i,:) = 1-exp(-(temp4-temp5)*(temp4-temp5)'./0.08);
   
%     distV(i,:) = (temp4-temp5)*(temp4-temp5)';
%     distV(i,:) = 1-exp(-(temp4-temp5)*(temp4-temp5)'./L2);
    
    
%     Dos(i,:) = exp(-Doc(Lxy(i, 1), Lxy(i,2)).^2);
%     dev(i,:) =1-exp( -temp4*temp4'.* exp(-Doc(Lxy(i, 1), Lxy(i,2)) ./ (h^2)) ./ (0.8*h^2) );
%      distV(i,:)= 1-exp(-(temp4-temp5)*(temp4-temp5)'./L2./5);
end
%      C_sita = 1-exp(-C_sita'.^2./0.01);
%     distV=C_sita.*C_L';
% distV=0.6.*C_sita'+0.4.*C_L';
%  dev =1-exp((-gamma*distV-(1-gamma).*f2)./(h^2));
dev = distV;