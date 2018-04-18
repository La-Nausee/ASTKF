% function: convert SOS format to [num;den]and K
clear all,clc % empty the workspace

load('Filter/filterOutPams.mat') % load filter output parameters
[numz,denz]=sos2tf(SOS);   % convert SOS format to transfer
K=cumprod(G); 
k=K(end); % �Ŵ�ϵ��

% ��ɢ���ݺ��� 
dsys = tf(numz*k,denz,0.0004); % �˲������ݺ���,��������0.004s
display('Filter discrete transfer funtion is :')
display(dsys)

% ��ɢת��Ϊ�������ݺ��� (if needed)
%scsys = d2c( dsys,'tustin' ); % ����˫���Ա任ת��Ϊ��������
%[num,den] = tfdata( scsys,'v' );% ���s�����ķ��Ӻͷ�ĸ
% %bode(tf(num,den)) % �˲�����bodeͼ