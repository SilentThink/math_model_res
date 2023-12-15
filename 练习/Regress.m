clc,clear;
% 1. 读取数据
output = readmatrix('output.xlsx');

% 2. 提取历届亚运会的奖牌数据
years = output(1:18, 1); % 前18行是年份
x = years; 
X = [ones(18,1) x];
Z = zeros(19,46);
Z(1:18,:) = output;
Z(19,1) = 2023;
for i = 2:46
    Y = output(1:18, i); 
    [b,bint,r,rint,stats]=regress(Y,X);
    Z(19,i)=b(1)+b(2)*Z(19,1) ;
end

% 预测结果归一化
sum_predict = sum(Z(19,2:end));

for i = 2:46
    Z(19,i)=Z(19,i)/sum_predict;
end
% 4. 保存结果到 predict.xlsx
xlswrite('predict.xlsx', Z, 'Sheet1');


