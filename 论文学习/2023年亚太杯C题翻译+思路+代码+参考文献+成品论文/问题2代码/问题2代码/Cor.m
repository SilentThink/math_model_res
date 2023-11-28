clc,clear
X = xlsread('数据表.xlsx', 1, 'B2:G13');
Y = xlsread('数据表.xlsx', 1, 'H2:H13');
R = corr([X Y]);  % 这里会得到一个7x7的矩阵，包含了自变量和因变量之间的相关系数

% 只取出自变量和因变量之间的相关系数
R_Y = R(end,1:end-1);  % 这是一个1x6的向量，包含了每个自变量和因变量之间的相关系数

% 绘制条形图
figure;  % 新建一个图像窗口
bar(R_Y);  % 绘制条形图
title('Correlation between Variables and Y');  % 设置图像标题
xlabel('Variable Index');  % 设置x轴标签
ylabel('Correlation Coefficient');  % 设置y轴标签
