%% ReLabel
%%
% Ҫ��֪CorrectIndex���㷨�������ind=[3,5,9,...];
% �Ƚ�LPM�㷨���������ΪCorrectIndex��Ȼ����RANSAC����ind����CorrectIndex��ind�в�һ�µ�ƥ���ر�ע����
% ע��ÿ��һ��ͼ��Ҫ��������FileName.
%%
close all;
FileName ='./church';

figure(1) ; clf ;
imagesc(cat(2, Ia, Ib)) ;
hold on ;

aa=zeros(size(X,1),1);
aa(CorrectIndex)=1;
GT=aa;
aa=zeros(size(X,1),1);
aa(ind)=1;
T=aa;
temp=T-GT;%0is correct;1 is error; -1 is unrecall
temp1=find(temp==1);
dd=size(Ia,2);
h = line([X(ind,1)';Y(ind,1)'+dd],[X(ind,2)';Y(ind,2)']) ;
set(h,'linewidth', 1, 'color', 'b') ;

delete(h);
for j=1:length(temp1)
    i=temp1(j);
    h=line([X(i,1);Y(i,1)+dd],[X(i,2);Y(i,2)]);
    set(h,'linewidth', 1, 'color', 'r') ;
    GT(i)=input('if initial maching is correct please enter 1:');
    delete(h);
end
temp2=find(temp==-1);
for j=1:length(temp2)
    i=temp2(j);
    h=line([X(i,1);Y(i,1)+dd],[X(i,2);Y(i,2)]);
    set(h,'linewidth', 1, 'color', 'g') ;
    GT(i)=input('if initial maching is wrong please enter 0:');
    delete(h);
end
CorrectIndex=find(GT==1);
save(FileName,'X','Y','CorrectIndex')
close all;