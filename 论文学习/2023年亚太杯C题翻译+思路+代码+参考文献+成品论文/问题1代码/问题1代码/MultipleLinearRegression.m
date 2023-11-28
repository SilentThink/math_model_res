clc, clear
% （1）数据输入
x1 = xlsread('数据表.xlsx', 1, 'B2:B13');
x2 = xlsread('数据表.xlsx', 1, 'C2:C13');
x3 = xlsread('数据表.xlsx', 1, 'D2:D13');
x4 = xlsread('数据表.xlsx', 1, 'E2:E13');
y = xlsread('数据表.xlsx', 1, 'H2:H13');
X = [ones(size(x1)),x1,x2,x3,x4]; 
% （2）求结果
[b,bint,r,rint,stats] = regress(y,X);  % 进行多元线性回归分析
% （3）画残差图
rcoplot(r,rint);  % 绘制残差图，用于评估回归模型的拟合情况

% （4）绘制拟合图
y_pred = X * b;  % 计算预测值
figure;          % 创建新图形窗口
plot(y, y_pred, 'bo');  % 绘制实际值和预测值的散点图
hold on;         % 保持图形，以便添加拟合线
plot(y, y, 'r-'); % 绘制45度线，表示完美拟合
xlabel('Actual Values');
ylabel('Predicted Values');
title('Fit Plot');
legend('Predicted vs. Actual', 'Perfect Fit Line');
grid on;         % 添加网格
hold off;        % 释放图形
