% Function : Experiment for the adaptiv and strong tracking Kalman filter
% @figure(1) : ״̬�Ŷ�����ֵ�����ƾ�ֵ����ʵֵ�Աȼ����
% @figure(2) : ״̬�Ŷ�����ֵ����ʵֵ�Ƚϼ����
% @figure(3) : ״̬�Ŷ����Ʒ��� Q
% @figure(4) : ״̬���Ʒ��� P11
% @figure(5) : ״̬���Ʒ��� P22
% @figure(6) : ���������� Kf1
% @figure(7) : ���������� Kf2
% @figure(8) : ǿ���ٽ������� ��
% @figure(9) : ״̬������� x1
% @figure(10) : ״̬������� x2
% @figure(10) : ������� y
% @figure(10) : �������� N

% NOTICE ��set condition = 0
%%
clear all,clc  % empty workspace

global condition % set condition to 0 for fine result  
condition = 0 ;

cv_input = [0,0.1];
open('Model/ObserveKalmanRun.mdl')  % open the kalman model 
sim('ObserveKalmanRun') ; % begin to execute the simulink model
%% ����figure����Ϊ��ɫ
set(0,'defaultfigurecolor','w'); 

%% ״̬�Ŷ�����ֵ����ʵֵ�Ƚϼ����
figure('NumberTitle','off','Name','״̬�Ŷ�����ֵ����ʵֵ�Ƚϼ����');
fix_figure     % ����������fix_figure ��ͼƬ�����˱�׼eps��ʽ����  
plot(bijiao.Time,bijiao.Data(:,1),'-',bijiao.Time,bijiao.Data(:,2),'-.',...
    bijiao.Time,bijiao.Data(:,2)-bijiao.Data(:,1),'--','Linewidth',2)
box off

hlen = legend('״̬�Ŷ�ʵ��ֵ','״̬�Ŷ�����ֵ','����ֵ���',...
    'Location','NorthWest','FontSize',7,'FontWeight','light');
set(hlen,'box','on','Location','NorthWest')
set(hlen,'box','off')

%% ״̬�Ŷ�����ֵ����ʵֵ�Ƚϼ����
figure('NumberTitle','off','Name','״̬�Ŷ�����ֵ����ʵֵ�Ƚϼ����');
fix_figure
plot(bijiao.Time,bijiao.Data(:,1),'-',bijiao.Time,bijiao.Data(:,3),'-.',...
    bijiao.Time,bijiao.Data(:,3)-bijiao.Data(:,1),'--','Linewidth',2)
box off

hlen = legend('״̬�Ŷ�ʵ��ֵ','״̬�Ŷ����ƾ�ֵ','���ƾ�ֵ���',...
    'Location','NorthWest','FontSize',7,'FontWeight','light');
set(hlen,'box','on','Location','NorthWest')
set(hlen,'box','off')

% %label (if needed)
% ylabel('״̬�Ŷ�(\murad)','FontSize',9);
% xlabel('time/(s)','FontSize',9);

%% ״̬�Ŷ����Ʒ��� Q
figure('NumberTitle','off','Name','״̬�Ŷ����Ʒ��� Q');
fix_figure
plot(Q.Time,Q.Data,'k','Linewidth',2)
box off

% %title and label (if needed)
% title('״̬�Ŷ����Ʒ���','FontSize',13);
% z=ylabel(['$$\widehat{Q}/(\mu rad^2$$' ')'],'FontSize',13);
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',13);

%% ״̬���Ʒ��� P11
figure('NumberTitle','off','Name','״̬���Ʒ��� P11');
fix_figure
plot(P11.Time,P11.Data,'k')
set(gca,'xtick',[0:1:5])
axis([0 5 0 2])
box off

% % label (if needed)
% z=ylabel(['$$\widehat{P}(1,1)/(\mu rad^2$$' ')'],'FontSize',13);
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',13);

%% ״̬���Ʒ��� P22
figure('NumberTitle','off','Name','״̬���Ʒ��� P22');
fix_figure
plot(P22.Time,P22.Data,'k')
set(gca,'xtick',[0:1:5])
axis([0 5 0 2])
box off

% % label (if needed)
% z=ylabel(['$$\widehat{P}(2,2)/(\mu rad^2$$' ')'],'FontSize',13);
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',13);

%% ���������� Kf1
figure('NumberTitle','off','Name','���������� Kf1');
fix_figure
plot(k1.Time,k1.Data,'k')
box off

% % label (if needed)
% z=ylabel(['$$\widehat{K}_{f}(1)$$']);
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',13);
% set(gca,'xtick',[0:1:5])
% axis([0 5 0 2])


%% ���������� Kf2
figure('NumberTitle','off','Name','���������� Kf2');
fix_figure
plot(k2.Time,k2.Data,'k')
box off

% %label (if needed)
% z=ylabel(['$$\widehat{K}_{f}(2)$$']);
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',13);
% set(gca,'xtick',[0:1:5])
% axis([0 5 0 2])

%% ǿ���ٽ������� lamda ��
figure('NumberTitle','off','Name','ǿ���ٽ������� ��');
fix_figure
plot(lamda.Time,lamda.Data,'k')
box off

% % label (if needed)
% z=ylabel(['$$\lambda$$'],'FontSize',10);
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',9);

%% ״̬���� x1
figure('NumberTitle','off','Name','״̬���� x1');
fix_figure
plot(x11_cha.Time,x11_cha.Data,'k')
% z=ylabel(['$$\widetilde{\widehat{x}}(1)$$'],'FontSize',13);
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',13);
set(gca,'xtick',[0:1:5])
axis([0 5 -2 2])
box off

%% ״̬���� x2
figure('NumberTitle','off','Name','״̬���� x2');
fix_figure
plot(x22_cha.Time,x22_cha.Data,'k')
% z=ylabel(['$$\widetilde{\widehat{x}}(2)$$'],'FontSize',13);
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',13);
set(gca,'xtick',[0:1:5])
axis([0 5 -2 2])
box off

%% ���������ʵ������Ա�
figure('NumberTitle','off','Name','���������ʵ������Ա�');
fix_figure
plot(yreal.Time,yreal.Data,'b-.',yout.Time,yout.Data,'r--','LineWidth',2)
hlen=legend('���ʵ��ֵ','�������ֵ')
axis([0 5 -502 502])
set(hlen,'box','on','Location','NorthEast')
set(hlen,'box','off')
grid off
box off

%% ����������
figure('NumberTitle','off','Name','����������');
fix_figure
plot(error.Time,error.Data,'k')
axis([0 5 -2.5 2.5])
grid on
box off

% %label (if needed)
% z=ylabel(['$$\widehat{y}/(\mu$$rad)'],'FontSize',13 );
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',13);

%% �������� N
figure('NumberTitle','off','Name','�������� N');
fix_figure
plot(noise.Time,noise.Data,'k')
box off

% % legend and label (if needed)
% legend('�������� ��')
% ylabel('N_{\theta}/rad')
% xlabel('time/(s)')

% save figure to file (if needed) 
% for h=1:12
%    saveas(h,['FigureFiles/figure',num2str(h),'.fig'])
% end