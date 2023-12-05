%% �����Թ滮�ĺ���
% [x,fval] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlfun,option)
% x0��ʾ�����ĳ�ʼֵ����������������������ʾ���������д
% A b��ʾ���Բ���ʽԼ��
% Aeq beq ��ʾ���Ե�ʽԼ��
% lb ub ��ʾ���½�Լ��
% fun��ʾĿ�꺯��
% nonlfun��ʾ������Լ���ĺ���
% option ��ʾ�������Թ滮ʹ�õķ���
clear;clc
format long g   %���Խ�Matlab�ļ�������ʾΪһ��ĳ����ָ�ʽ��Ĭ�ϻᱣ����λС������ʹ�ÿ�ѧ��������

%% ����1�����
% max f(x) = x1^2 +x2^2 -x1*x2 -2x1 -5x2
% s.t. -(x1-1)^2 +x2 >= 0 ;  2x1-3x2+6 >= 0
x0 = [0 0];  %�������һ����ʼֵ 
A = [-2 3]; b = 6;
[x,fval] = fmincon(@fun1,x0,A,b,[],[],[],[],@nonlfun1)  % ע�� fun1.m�ļ���nonlfun1.m�ļ��������ڵ�ǰ�ļ���Ŀ¼��
fval = -fval

%% ʹ�������㷨������1���
% MatlabĬ��ʹ�õ��㷨��'interior-point' �ڵ㷨
% ʹ��interior point�㷨 ���ڵ㷨��
option = optimoptions('fmincon','Algorithm','interior-point')
[x,fval] = fmincon(@fun1,x0,A,b,[],[],[],[],@nonlfun1,option)  
fval = -fval
% ʹ��SQP�㷨 �����ж��ι滮����
option = optimoptions('fmincon','Algorithm','sqp')
[x,fval] = fmincon(@fun1,x0,A,b,[],[],[],[],@nonlfun1,option)  
fval = -fval   %�õ�-4.358��ԶԶ�����ڵ㷨�õ���-1,�����ǳ�ʼֵ��Ӱ��
% �ı��ʼֵ����
x0 = [1 1];  %�������һ����ʼֵ 
[x,fval] = fmincon(@fun1,x0,A,b,[],[],[],[],@nonlfun1,option)  % ��СֵΪ-1�����ڵ㷨��ͬ����˵���ڵ㷨����Ӧ��Ҫ�ã�
fval = -fval  

%% ʹ�����ؿ��޵ķ������ҳ�ʼֵ(�Ƽ���
clc,clear;
n=10000000; %���ɵ����������
x1=unifrnd(-100,100,n,1);  % ������[-100,100]֮����ȷֲ����������ɵ�n��1�е���������x1
x2=unifrnd(-100,100,n,1);  % ������[-100,100]֮����ȷֲ����������ɵ�n��1�е���������x2
fmin=+inf; % ��ʼ������f����СֵΪ���������ֻҪ�ҵ�һ������С�����ǾͶ�����£�
for i=1:n
    x = [x1(i), x2(i)];  %����x����, ����ǧ���д���ˣ�x =[x1, x2]
    if ((x(1)-1)^2-x(2)<=0)  & (-2*x1(i)+3*x2(i)-6 <= 0)     % �ж��Ƿ���������
        result = -x(1)^2-x(2)^2 +x(1)*x(2)+2*x(1)+5*x(2) ;  % ������������ͼ��㺯��ֵ
        if  result  < fmin  % ����������ֵС������֮ǰ�����������Сֵ
            fmin = result;  % ��ô�͸����������ֵΪ�µ���Сֵ
            x0 = x;  % ���ҽ���ʱ��x1 x2����Ϊ��ʼֵ
        end
    end
end
disp('���ؿ���ѡȡ�ĳ�ʼֵΪ��'); disp(x0)
A = [-2 3]; b = 6;
[x,fval] = fmincon(@fun1,x0,A,b,[],[],[],[],@nonlfun1)
fval = -fval  
