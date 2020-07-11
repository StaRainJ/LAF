function  [X, normal] =norm2(x)
% NORM2 nomalizes the data so that it has zero means and unit covariance

x = double(x);

n=size(x,1);

normal.xm=mean(x);

x=x-repmat(normal.xm,n,1);

normal.xscale=sqrt(sum(sum(x.^2,2))/n);

X=x/normal.xscale;
