% �����˱��ض���FSM���������ݺ�����
% Ȼ������ɢ������һ���õ�״̬�ռ��ʾ
%% 
clear all,clc
omigan = 9420 ;  % FSM��г��Ƶ��
yita = 0.7 ;  % FSM�������

% FSM�������ݺ���
num = [omigan^2];
den = [1 2*omigan*yita omigan^2];
display('�������ݺ����ǣ�')
csys = tf(num,den)

% FSM��ɢ���ݺ���
ts = 0.0004 
display('��ɢ���ݺ����ǣ�')
dsys = c2d(csys,ts,'zoh')

% FSM״̬�ռ��ʾ
numz = dsys.num{1};
denz= dsys.den{1};
display('״̬�ռ�ϵ���ǣ�')
A = [0 1;-denz(3) -denz(2)]
B = [0;1]
C = [numz(3) numz(2)]
D = 0

