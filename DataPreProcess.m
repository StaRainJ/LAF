function [S,DD,idx00]=DataPreProcess(data,indBin,Smin)
%% divid the input data into num^2 cells via grid method
%indBin is binary index of unrepeated sample
% S is sparse score
% DD is the number of support sample in  the divided super cell;
% 
% tic
data(:,3:4) = data(:,3:4)./ (max(abs(data(:,3:4)))+0.00001);
numGrid = 5;
N = length(indBin);
idx = zeros(N,1);
interval = 1/numGrid;
Lxykl=floor(data(:,1:2)./interval)+1;
Lxykl(:,3:4)=floor(0.5.*(data(:,3:4)+1)./interval)+1;
% label=(Lxy(:,1)-1).*num+Lxy(:,2);


for i=1:numGrid
    for j=1:numGrid
        for k=1:numGrid
            for l=1:numGrid
        temp1 = (Lxykl(:,1) == i & Lxykl(:,2) == j & Lxykl(:,3) ==k & Lxykl(:,4) == l & indBin==1 );% & ind0==1
        temp2 = sum(temp1);
        CT(i,j,k,l)=temp2;        
            end
        end
    end
end

for i=1:N
    TT(i)=CT(Lxykl(i,1),Lxykl(i,2),Lxykl(i,3),Lxykl(i,4));
end
    
% CT()
% temp=pdist2(Lxykl,Lxykl);
% temp(~ind1,:)=1;
% DD=sum(logical(temp==0));
%%
% DD = TT;
% tt=logical(CT);
% CC = CT(tt);
% Nc0 = sum(tt(:)); %% the grid number 
% AveN = mean(CC);
% StdN = std(CC);
% S = (DD'-AveN)./StdN;
% idx00=(S>1 & DD'>1);%4.5
%%
DD = TT;
Nnew = sum(indBin); %the sample number

f = 1/numGrid;
S=(DD'-Nnew*f^4)./ sqrt(f^4*(1-f^4)*Nnew);
idx00=(S>Smin & DD'>1);%4.5
