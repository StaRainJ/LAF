function [idxUnique,ID_Bin] = removeRepeat(X,Y)
CC = UniqueSearch(X);
EE = UniqueSearch(Y);
ID_Bin = (CC&EE);
idxUnique=find(ID_Bin==1);

function indNew = UniqueSearch(X)
ind0 = false(size(X,1),1);
[aa,bb] = sortrows(X,1);
cc0=logical(sum(abs(diff(aa)),2));
cc1 = [true;cc0];
cc2 = [cc0;true];
idx=cc1&cc2;
ind0(bb(idx))= true;
indNew=ind0;