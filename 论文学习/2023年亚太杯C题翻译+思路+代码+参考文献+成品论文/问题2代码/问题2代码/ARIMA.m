clc;
clear;

a = xlsread('发展数据.xlsx', 1, 'B2:B13');
% a = xlsread('发展数据.xlsx', 1, 'C2:C13');
% a = xlsread('发展数据.xlsx', 1, 'D2:D13');


a = nonzeros(a'); % 转置非零元素，移除0
figure;
plot(2011:1:2022,a, 'LineWidth', 1.5);
title('原始时间序列');
xlabel('时间');
ylabel('值');

% 计算并绘制时间序列的自相关图
figure;
autocorr(a);
title('原始时间序列的自相关图');

% 计算并绘制时间序列的偏自相关图
figure;
parcorr(a);
title('原始时间序列的偏自相关图');

% 计算时间序列的自相关和偏自相关
r11 = autocorr(a); % 序列a的自相关
r12 = parcorr(a); % 序列a的偏自相关

% 对时间序列数据进行一阶差分
da = diff(a); % 一阶差分
% da = diff(da)
% 绘制一阶差分后时间序列图

% 计算差分后序列的自相关和偏自相关
r21 = autocorr(da); % 序列da的自相关
r22 = parcorr(da); % 序列da的偏自相关

% 获取差分后序列的长度
n = length(da);
k = 0; % 初始化计数器

% 循环遍历不同的AR和MA阶数组合
for i = 0:3
    for j = 0:3
        if i == 0 && j == 0
            continue; % 如果AR和MA的阶数都是0，则跳过
        elseif i == 0
            ToEstMd = arima('MALags', 1:j, 'Constant', 0); % 仅有MA部分
        elseif j == 0
            ToEstMd = arima('ARLags', 1:i, 'Constant', 0); % 仅有AR部分
        else
            ToEstMd = arima('ARLags', 1:i, 'MALags', 1:j, 'Constant', 0); % 同时有AR和MA部分
        end
        k = k + 1; % 更新计数器
        R(k) = i; % 保存AR阶数
        M(k) = j; % 保存MA阶数
        [EstMd, EstParamCov, logL, info] = estimate(ToEstMd, da); % 估计ARIMA模型
        numParams = sum(any(EstParamCov)); % 计算参数的数量
        [aic(k), bic(k)] = aicbic(logL, numParams, n); % 计算AIC和BIC
    end
end

[Rgrid, Mgrid] = meshgrid(0:3, 0:3);

% 调整AIC和BIC的值以匹配网格尺寸，用nan填充不合法的组合（即R=0和M=0）
aic_grid = nan(size(Rgrid));
bic_grid = nan(size(Mgrid));
for idx = 1:length(R)
    aic_grid(R(idx)+1, M(idx)+1) = aic(idx);
    bic_grid(R(idx)+1, M(idx)+1) = bic(idx);
end

% 绘制AIC热力图
figure;
heatmap(0:3, 0:3, aic_grid);
title('AIC热力图');
xlabel('MA阶数');
ylabel('AR阶数');

% 绘制BIC热力图
figure;
heatmap(0:3, 0:3, bic_grid);
title('BIC热力图');
xlabel('MA阶数');
ylabel('AR阶数');


% 打印AR阶数、MA阶数、AIC和BIC的对应值
fprintf('R, M, AIC, BIC的对应值如下:\n');
check = [R', M', aic', bic']; % 创建结果矩阵
disp(check); % 显示结果

% 请求用户输入AR和MA的阶数
r = input('请输入AR阶数R = ');
m = input('请输入MA阶数M = ');

% 根据用户指定的AR和MA阶数，构建ARIMA模型
ToEstMd = arima('ARLags', 1:r, 'MALags', 1:m, 'Constant', 0);

% 估计模型参数
[EstMd, EstParamCov, logL, info] = estimate(ToEstMd, da);

% 使用估计的模型进行预测，预测未来10个值
dx_Forecast = forecast(EstMd, 10, 'Y0', da);

% 将预测的差分值累加回原始序列的最后一个值，得到实际的预测值
x_Forecast = a(end) + cumsum(dx_Forecast); % 累加预测值以获得原始序列的预测
% 绘制原始数据和预测数据的对比图
figure;
hold on;
plot(1:length(a), a, 'LineWidth', 1.5); % 绘制原始数据
plot(length(a)+1:length(a)+10, x_Forecast, 'r', 'LineWidth', 1.5); % 绘制预测数据
title('ARIMA模型预测结果');
xlabel('时间');
ylabel('值');
legend('原始数据', '预测数据');
hold off;
