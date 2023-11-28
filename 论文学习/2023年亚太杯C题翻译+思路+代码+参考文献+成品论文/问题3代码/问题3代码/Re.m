x=xlsread('全球汽车销量数据集改.xlsx',  'F2:F13')
y=xlsread('全球汽车销量数据集改.xlsx',  'G2:G13')
X = [ones(12, 1), x]; % 构建线性回归的自变量矩阵
[b, bint, r, rint, stats] = regress(y, X)% 进行多元线性回归分析
