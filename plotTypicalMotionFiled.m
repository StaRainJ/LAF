function plotTypicalMotionFiled(data,ind00,ind,num,N,mainV,dev,CorrectIndex,tao)

figure(1),
% data(:,2)=1-data(:,2);
% mainV(:,:,2)=1-mainV(:,:,2);

% ind0=ind1;
plot(data(~ind00,1),data(~ind00,2),'ro');hold on;
plot(data(ind00,1),data(ind00,2),'b*');hold on;
% plot(data(idx,1),data(idx,2),'co');hold on;

[xt, yt] = meshgrid(0:1/num:1,0:1/num:1);
mesh(yt, xt, zeros(size(xt)), 'FaceColor',...
'None', 'LineWidth', 0.3, ...
'EdgeColor', 'm');%»æÖÆÈýÎ¬Íø¸ñÍ¼
h=5;
quiver(reshape(xt(1:end-1,1:end-1)+0.5/num,[num*num,1]), reshape(yt(1:end-1,1:end-1)+0.5/num,[num*num,1]),reshape(mainV(:,:,1)',[num*num,1])./h ,reshape(mainV(:,:,2)',[num*num,1])./h, 0,...
    'Color',[0.1 0.9 0.9],'LineWidth',1.2), hold on

% ind0=((ind-ind00)==0&ind00==0);
% quiver(data(logical(ind0), 1), data(logical(ind0), 2), (data(logical(ind0),3))./h, (data(logical(ind0),4))./h, 0, 'k'), hold on
% ind0=~ind0;
ind0=((ind-ind00)>0);
quiver(data(logical(ind0), 1), data(logical(ind0), 2), (data(logical(ind0),3))./h, (data(logical(ind0),4))./h, 0, 'r'), hold on

ind0=((ind-ind00)<0);
quiver(data(logical(ind0), 1), data(logical(ind0), 2), (data(logical(ind0),3))./h, (data(logical(ind0),4))./h, 0, 'g'), hold on

ind0=((ind-ind00)==0&ind00==1);
quiver(data(logical(ind0), 1), data(logical(ind0), 2), (data(logical(ind0),3))./h, (data(logical(ind0),4))./h, 0, 'b'), hold on


axis equal
axis on
axis([0 1 0 1]);
set(gca,'XTick',-2:1:-1)
set(gca,'YTick',-2:1:-1)
set(gca,'ZTick',-10:1:-9)
hold off;

ind0=ind00;
figure(2)
% dev(find(ind0==1))= max(dev(find(ind0==1)).*(-0.1+dev(find(ind0==1))),0);
% dev(find(ind0==0))= min(dev(find(ind0==0)).*(2-dev(find(ind0==0))),1);
plot(find(ind0==0),dev(~ind0),'ro'); hold on;
plot(CorrectIndex,dev(CorrectIndex),'b*'); hold on;
line([0 ,N],[tao ,tao]);
xlabel('Putative Match Index');
ylabel('Motion Deviation');
title('dev');
% axis([-20 1900 -0.02 1.02]);

hold off;
