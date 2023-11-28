clc,clear
x=xlsread('问题四数据.xlsx',  'E2:E12')
y=xlsread('问题四数据.xlsx',  'F2:F12')
X = [ones(11, 1), x]; % 构建线性回归的自变量矩阵
[b, bint, r, rint, stats] = regress(y, X)% 进行多元线性回归分析
