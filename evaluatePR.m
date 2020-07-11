function [inlier_num,inlierRate,precision_rate,Recall_rate]=evaluatePR(X,CorrectIndex,ind)
 N=size(X,1);
inlier_num = length(CorrectIndex);
% outlier_num= N-inlier_num;
inlierRate = inlier_num./N;

Correct_num=sum(double(ismember(ind,CorrectIndex)));
% Error_num=length(ind)-Correct_num;
% unRecall_num=length(CorrectIndex)-Correct_num;
precision_rate=Correct_num/length(ind);
Recall_rate=Correct_num/length(CorrectIndex);
if Recall_rate==0
    precision_rate=inlierRate;
    Recall_rate=1;
end
