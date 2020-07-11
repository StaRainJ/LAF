function [Lxy,meanV,countMatches,STD]=DataGrid(data,num ,ind1)
%% divid the input data into num^2 cells via grid method
% each element in data is ranged from 0 to 1
interval=1/num;
Lxy=floor(data(:,1:2)./interval)+1;
% label=(Lxy(:,1)-1).*num+Lxy(:,2);
N=size(data,1);
meanV = zeros(num, num, 2);
density = zeros(num, num);
DOS = ones(N, 1);
STD = ones(num, num);
countMatches = density;
h=0.8;
for i = 1:num
    for j = 1:num
        temp1 = (Lxy(:,1) == i & Lxy(:,2) == j & ind1==1 );% & ind0==1
        temp2 = sum(temp1);
        countMatches(i, j) = temp2;
        if countMatches(i, j) ~=0
        meanV(i, j, 1:2) = mean(data(temp1,3:4),1);   
%         STD(i, j) = sum(std(data(temp1,3:4),0,1)); 
%         DOS(temp1)=DosEstimation(data(temp1,3:4),data(temp1,3:4),h);           
        else 
            meanV(i, j, 1:2)=[0,0];
        end
    end
end
% density = countMatches.*num.*num./N; %% grid and calculate the density only based inliers  %sum(ind1)
N=sum(ind1);
STD =(countMatches - N./(num)^2)  ./   sqrt(1/(num)^2 * (1-1/(num)^2) * N);
STD = STD.*logical(countMatches);
% density=density./max(density(:));
