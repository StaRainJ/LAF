% clc;
clear;
close all;
% addpath(genpath('./InputData/'))
% addpath('./PFFMdata/')

img1=imread('church1.jpg');
img2=imread('church2.jpg');
load('church.mat');  




%%
if exist('img1')
    Ia=img1;
    Ib=img2;
end

if size(Ia,3)==1
    Ia = repmat(Ia,[1,1,3]);
end
if size(Ib,3)==1
    Ib = repmat(Ib,[1,1,3]);
end

[wa,ha,~] = size(Ia);
[wb,hb,~] = size(Ib);
maxw = max(wa,wb);maxh = max(ha,hb);
Ib(wb+1:maxw, :,:) = 0;
Ia(wa+1:maxw, :,:) = 0;

%% parameters setting
Lambda   = [0.8 0.2 0.1 0.05,0.05]; 
Itr   = 5;
tau = 0.8;
%% threshold using norm
% Tao   = [0.5 0.1 0.1 0.25,0.15]; 
% Itr   = 1;
% histogram(distV,50)
% graythresh(distV)
% visulation=1;
%% data pre-processing
tic
V=Y-X;
data = [X,V];
% data = [Y,-V];
N = size(X,1);

data(:,1:2) = (mapminmax(data(:,1:2)', 0.01, 0.99))';

data(:,3:4) = data(:,3:4)./ (max(abs(data(:,3:4)))+0.00001);
Vnew=data(:,3:4);


%% remove repetitive samples
ind0 = false(N,1);
ind0(CorrectIndex) = true;
[idxUnique,ID_Bin] = removeRepeat(X,Y);

%% remove isolated samples
% Smin = 3;
% [S,DD,idx00]=DataPreProcess(data,ID_Bin,Smin);
% ind1=(ID_Bin&idx00);
% ind1 = ones(N,1);
ind1 = ID_Bin;

% if visulation
% figure(11)
% plot(1:N,S,'r*'); hold on;
% plot(CorrectIndex,S(CorrectIndex),'b*'); 
% title('S-density w.r.t super cell');
% hold off;
% end

%% Progressive filtering
for i=1:Itr
    
lambda=Lambda(i);

nc = min( max(round(sqrt(length(ind1))),15),30);
nk= round(nc./6)*2-1;

kernel = GenerateKernel(nk,1);
%%
%
[Lxy, meanV,countMatches, ~] = DataGrid(data, nc, ind1);

[mainV,Doc,CP] = MyFilter(meanV,kernel,countMatches,nc);

[dev,distV,Dos] = CostCalculate(Vnew,mainV,Lxy);

ind1 = (dev<lambda);%&ID_Bin;
P=ind1;
%%
sigma2 = sum(P.*Dos)./sum(P)./2;

gamma = sum(P)/N;

a=16;
[P, E] = get_P (Dos, sigma2 ,gamma, a);
ind1=(P>tau)&ID_Bin;
end
%% determine final inliers

idx=find(P>tau); ind =idx;

time = toc;

%% plot results

figure
[FP,FN] = plot_matches(Ia, Ib, X, Y, idx, CorrectIndex);
plot_4c(Ia, Ib, X, Y, idx, CorrectIndex);

%% show evaluation results
[inlier_num,inlierRate,Precision_rate,Recall_rate] = evaluatePR(X,CorrectIndex,idx);
disp('*****************************')
fprintf('N:%2.0f IR: %2.4f \n',N,inlierRate);
fprintf('Pre: %2.4f \n',Precision_rate);
fprintf('Rec: %2.4f \n',Recall_rate);
fprintf('Fscore: %2.4f \n',2*Precision_rate*Recall_rate/(Recall_rate+Precision_rate));
fprintf('Time cost: %2.4f ms \n',time*1000);
disp('*****************************')
