clc,clear
% 参数初始化
lam = 0.4;      % 日接触率，题中若没给出需要自己查资料，后面同理
mu = 0.1;     % 日治愈率
I = 0.4;
S = 0.5;
 
% ode45是一个通用型ODE求解器
tspan = [0:1:50];     % 变量t范围0到50
y0 = [I S];     % 传递模型参数，SIR相加等于一求两个即可得出第三个

[t,y] = ode45(@(t,y)SIRfunc(t,y,lam,mu), tspan, y0);  %注意ode45的语法
% 求解返回的y中，第一列是第一个方程组的解，第二列是第二个微分方程的解
r = 1-y(:,1)-y(:,2);   % 移出者的比例 
 
%画图
plot(t,y(:,1),t,y(:,2),t,r,'k','LineWidth',2);
legend('患病:i(t)','易感染者:s(t)','移除者:r(t)','Location','Best'); 
ylabel('占人口比例%');
xlabel('时间t');
title('SIR模型(ode)');