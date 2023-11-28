clc,clear
% 输入数据
X = xlsread('问题四数据.xlsx',  'A2:A13');
Y =  xlsread('问题四数据.xlsx',  'B2:B13');

% 绘制散点图
scatter(X, Y, 'filled');
title('中国新能源汽车出口数据');
xlabel('年份');
ylabel('出口量（万辆）');
grid on;

% 显示图例
legend('数据点');

% 调整图的外观
set(gca, 'FontSize', 12);
