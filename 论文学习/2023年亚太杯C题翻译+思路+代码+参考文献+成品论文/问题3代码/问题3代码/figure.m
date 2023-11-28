clear,clc
% 定义函数
y_hat = @(x) x./(0.0532 + 0.0005*x) + 6400;

% 生成 x 值的范围
x = [0:50:1500]; % 你可能需要根据你的数据范围调整这里的值

% 计算对应的 y 值
y = y_hat(x);

% 绘制图形
plot(x, y, 'LineWidth', 2);
title('Graph of ŷ=x/(0.0532+0.0005x)+6400');
xlabel('x');
ylabel('ŷ');
grid on;
