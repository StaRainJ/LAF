function indexPFFM = PFFMfun(X,Y)

Nk = [11; 7; 9; 9;9  ;9;7];
GridNum   = [20 20 20,25,30,   30, 30];
Tao   = [0.08 0.2 0.1 0.05,0.035,   0.035,0.035]; 
Itr   =5;
%% data pre-processing
V=Y-X;
data = [X,V];
N = size(X,1);
data(:,1:2) = (mapminmax(data(:,1:2)', 0.001, 0.999))';% 数据归一化
data(:,3:4) = data(:,3:4)./ (max(abs(data(:,3:4)))+0.00001);
Vnew=data(:,3:4);
%% 剔除重复点初始样本 
% ind0 = false(N,1);
% 
% ind0(CorrectIndex) = true;

[idxUnique,ID_Bin] = removeRepeat(X,Y);

ind1=ID_Bin;
% ind1 = ind0;

P = ind1; 
%% iteration Filtering
for i=1:Itr 
num=GridNum(i); tao=Tao(i);  nk=Nk(i);

kernel = GenerateKernel(nk,1);

[Lxy, meanV,countMatches, ~] = DataGrid(data, num, ind1);

[mainV,Doc,CP] = MyFilter(meanV,kernel,countMatches,num);

[dev,distV,Dos] = CostCalculate(Vnew,mainV,Lxy);

% dev  = (mapminmax(dev', 0, 1))';

ind1 = (dev<tao);%&ID_Bin;
ind10=ind1;

P=ind1;
%%

sigma2 = sum(P.*Dos)./sum(P)./2;

gamma = sum(P)/N;

a=10;
[P, E]= get_P (Dos, sigma2 ,gamma, a);
ind1=(P>0.8)&ID_Bin;
%%

end
% indexPFFM=find(dev<tao);
indexPFFM=find(P>0.8);