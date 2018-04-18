%Discrete Kalman filter
%x=Ax+B(u+w(k));
%y=Cx+D+v(k)
function [out]=ObserveKalman(u1,u2,u3)
%% 
%Function��������Ӧǿ����Kalman�˲��㷨
%���� ��״̬�ռ�ϵͳ�����ź�@u1,<u>
%     ��״̬�ռ�ϵͳ����ź�@u2,<yout>
%     ��ʱ���ź�@u3,<clock model>

%��� ���˲�������@out(1),<ye>
%     ��δ�����˲������@out(2),yv>

% Parameters��
% @A,B,C,D ��ϵͳ״̬�ռ�ϵ����% @Q ��״̬�Ŷ����Ʒ������
% @R �������������Ʒ��% @P ��״̬���Ʒ��% @x ��ϵͳ״̬������
% @q ��״̬�Ŷ����ƾ�ֵ %@r �������������ƾ�ֵ % @c_d ������Ӧ�˲���������...
% @lamda ��ǿ���ٽ������� %@ro ��ǿ���ٽ������� @lk ��ǿ������������

%%
persistent A B C D Q R P x q c_d r V count lamda  lamda_0 ro lk

global OnlyPid

yv=u2; % δ�����˲���� ��if needed��

if OnlyPid
   out(1)=yv;  % ynotKalman
else
%%
if u3==0
    
count = 1 ;
ts = 0.0004 ;  % ��������
z = tf('z') ;

oFsm = (1.034*z+0.1)/(z^2+0.1288*z+0.005117); % ��ɢ���ݺ���
Gobject = tf(oFsm,ts);
ss_ob = ss(Gobject) ;

% A=ss_ob.a;B=ss_ob.b;C=ss_ob.c;D=ss_ob.d;
A=[0 1;-0.005117 -0.1288]; % ״̬�ռ�ϵ��
B=[0;1];
C=[0.1 1.034];
D=0;

x=zeros(2,1); % ״̬��ʼ��

c_d = 0.6516; % Sage-Huga��������

q = 0; % �����Ŷ���ֵ��ʼ��
Q= 2; % �����Ŷ������ʼ��
r = 0; % ����������ֵ��ʼ��
R = 6.115; % �������������ʼ��
ro = 0.9; % ǿ����
lk = 20; % ǿ����

P=[0.1,0;0,0.1]; % ״̬���Ʒ����ʼ��

end

%% update Correction factor
rfactor_d = (1-c_d)/(1-power(c_d,count));

count = count +1 ;

% state prediction by step
x_1 = x ;
x_xing = A*x + B*u1 + B*q ;

%output error 
e = yv - C*x_xing - r ; % this x is the x*

%var of state prediciton
P_1 = P ;

%% ǿ���ٲ���


if u3==0
    V = e*e';
else
    V = (ro*V+e*e')/(1+ro);
end

lamda_0=((V-C*B*Q*B'*C'-lk*R))/(C*A*P*A'*C');

%lamda_0=((V_0-lk*R))/(C*A*P*A'*C');

if(lamda_0>=1)
    lamda=lamda_0;
else
    lamda = 1;
end

% End ǿ���ٲ��ֽ��� 

%var of state prediciton
P = lamda*A*P_1*A'+ B*Q*B' ;
% end

%update Calman gain
K = P*C'/(C*P*C'+R);

%update State estimation
x=x_xing+K*e;

%var of state estimation
P_xing = P ;
P=(eye(2)-K*C)*P; % this P can be used as next P(k-1)
 
%output y estimation 
ye=C*x+D;           %Filtered value

%statue disturb 
s_e = (B'*B)\B'*( x - A*x_1 - B*u1) ;

% % %�����Ŷ���ֵ����
% q = (1-rfactor_d)*q + rfactor_d *((B'*B)\B'*( x - A*x_1 - B*u1)) ;
% % %�����Ŷ�������� 
% Q = Q + rfactor_d*((B'*B)\B'*K*(e*e'-C*P_xing*C'-R)*K'*B/(B'*B));
% %Q = (1-rfactor_d)*Q + rfactor_d *((B'*B)\B'*(K*e*e'*K' + P - A*P_1*A')*B/(B'*B));

% �����Ŷ���ֵ����
D_temp = B'*C'/(C*P_xing*C'+R);
q = q + rfactor_d*Q*D_temp*e;
Q = Q + rfactor_d*Q*D_temp*(e*e'-C*P_xing*C'-R)*D_temp'*Q ;

% out vector
out(1)=ye;  % yout

end  % end OnlyPid




