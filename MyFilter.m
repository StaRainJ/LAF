
function [mainV,S,CP]=MyFilter(meanV,kernel,countMatches,num)   
% W=countMatches��
% countMatches(countMatches==1) = countMatches(countMatches==1)-1;
%%
% temp0 = logical(countMatches);% ������Ԫ�ص�����
% 
% temp00 = imfilter(double(temp0).*countMatches, kernel);
% CenT = floor(size(kernel,1)./2)+1;
% TH = kernel(CenT,CenT);
% countMatches(temp00 <= TH) = 0;

%%
temp0 = logical(countMatches);% ������Ԫ�ص�����
temp00 = imfilter(double(temp0).*countMatches, kernel);


%% ������һ������Ӱ��
nk = size(kernel,1);
CT= floor(nk./2)+1;
temp00 = temp00- temp0.*kernel(CT,CT);


%% 
% TP0 = logical(mainV_old(:,:,1));
% TP1 = TP0&(~temp0);
% countMatches = countMatches+double(TP1);
% temp0 = TP0;
% meanV=meanV+mainV_old.*repmat(TP1,[1,1,2]);
%%
temp1 = repmat(temp00 , [1,1,2]); % ��Ϊ�˲�ʱ��Ȩ�ز���

mainV = imfilter(meanV .* repmat(countMatches, [1,1,2]), kernel); % �˲��õ�ÿ�������������


%%  ������һ������Ӱ��
mainV = mainV-meanV.*kernel(CT,CT);


%%
% temp = repmat(temp0, [1,1,2]);
temp = logical(temp1);% 

mainV(temp) = mainV(temp) ./ temp1(temp); % ��ÿ�������������������Ȩ�ز���
%%
meanV1 = mainV(:,:,1);
meanV2 = mainV(:,:,2);
% temp3 = countMatches>max(0.5*mean(countMatches(:)),1);

%%
temp2 = zeros(num, num, 2)-0;

mainV(~temp) = temp2(~temp); %

% Doc = temp1(:,:,1); %  Density of cells
DD= temp1(:,:,1);
N=sum(countMatches(:));
S=(DD-N./(num)^2)./ sqrt(1/(num)^2*(1-1/(num)^2)*N);
% Doc = Doc./mean(Doc(:));
temp3 = S >0;
% temp3 =   countMatches > max(mean(countMatches(:)),1);
CP(:,1) = meanV1(temp3);
CP(:,2) = meanV2(temp3);


