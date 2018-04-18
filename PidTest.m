% funciton: PID and ASTKF��PID �Ա������е�PID

clear all,clc
close all

global OnlyPid;  % choose whether using Kalman+Pid or just use pid method
OnlyPid = 1 ;
%load('InputSignal/error_input.mat') % load inputSignal<error of CoarseTracking>
load('InputSignal/error_coarse.mat')
open('Model/Pid.mdl')  % open the  model

sim('Pid') ; % begin to execute the simulink model

%% ����figure����Ϊ��ɫ
set(0,'defaultfigurecolor','w'); 

%% ���������
figure('NumberTitle','off','Name','���������');
fix_figure % Set up as standard EPS format
plot(yComp.Time,yComp.Data)
h = legend('\Delta\theta_{C}','\theta_{F}');
set(h,'box','off')
ylabel('\theta/rad','FontSize',12)
xlabel('time/(s)','FontSize',13)
grid off
box off
hold off

%% ���������
figure('NumberTitle','off','Name','���������');
fix_figure % Set up as standard EPS format
plot(error.Time(1:end),error.Data(1:end))
%legend('\Delta\theta_{C}','\theta_{F}')
%ylabel('\Delta\theta_{F}/rad','FontSize',12)
%xlabel('time/(s)','FontSize',13)
grid on
box off
hold off
%ylim([-3,6])

%% ���������
figure('NumberTitle','off','Name','���뾫�������');
fix_figure % Set up as standard EPS format
plot(error.Time(1990:end),error.Data(1990:end))
%legend('\Delta\theta_{C}','\theta_{F}')
ylabel('\Delta\theta_{F}/rad','FontSize',12)
xlabel('time/(s)','FontSize',13)
grid on
box off
hold off
axis([0.7956 10 -15 15])

sorted = sort(abs(error.Data(1990:end)),'descend') ;
display(['������:' num2str(sorted(2))]);
display(['99.9%��Χ:' num2str(max(sorted(23:end)))]);
display(['����:' num2str(var(error.Data(1990:end)))]);
