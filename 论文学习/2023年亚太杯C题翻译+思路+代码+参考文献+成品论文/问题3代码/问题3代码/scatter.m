% 输入数据
traditional_car_sales = xlsread('全球汽车销量数据集改.xlsx',  'B2:B13');
electric_car_sales =  xlsread('全球汽车销量数据集改.xlsx',  'C2:C13');

% 绘制散点图
scatter(electric_car_sales, traditional_car_sales, 'filled');
title('传统能源汽车销量 vs 新能源汽车销量');
xlabel('新能源汽车销量（万辆）');
ylabel('传统能源汽车销量（万辆）');
grid on;

% 添加数据点标签
text(electric_car_sales, traditional_car_sales, num2str((1:numel(electric_car_sales))'), ...
    'VerticalAlignment','bottom', 'HorizontalAlignment','right');

% 显示图例
legend('数据点');

% 调整图的外观
set(gca, 'FontSize', 12);
