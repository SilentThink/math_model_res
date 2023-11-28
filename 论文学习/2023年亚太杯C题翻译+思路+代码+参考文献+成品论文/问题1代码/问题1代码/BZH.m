% 假设你的数据存储在变量data中
data = xlsread('数据表.xlsx', 1, 'B2:G13');

% 计算每一列的平方和的平方根
norm_factor = sqrt(sum(data.^2));

% 将每一列的数据除以对应的norm_factor
data_norm = bsxfun(@rdivide, data, norm_factor)