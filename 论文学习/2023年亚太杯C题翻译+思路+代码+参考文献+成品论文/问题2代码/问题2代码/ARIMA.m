clc;
clear;

a = xlsread('��չ����.xlsx', 1, 'B2:B13');
% a = xlsread('��չ����.xlsx', 1, 'C2:C13');
% a = xlsread('��չ����.xlsx', 1, 'D2:D13');


a = nonzeros(a'); % ת�÷���Ԫ�أ��Ƴ�0
figure;
plot(2011:1:2022,a, 'LineWidth', 1.5);
title('ԭʼʱ������');
xlabel('ʱ��');
ylabel('ֵ');

% ���㲢����ʱ�����е������ͼ
figure;
autocorr(a);
title('ԭʼʱ�����е������ͼ');

% ���㲢����ʱ�����е�ƫ�����ͼ
figure;
parcorr(a);
title('ԭʼʱ�����е�ƫ�����ͼ');

% ����ʱ�����е�����غ�ƫ�����
r11 = autocorr(a); % ����a�������
r12 = parcorr(a); % ����a��ƫ�����

% ��ʱ���������ݽ���һ�ײ��
da = diff(a); % һ�ײ��
% da = diff(da)
% ����һ�ײ�ֺ�ʱ������ͼ

% �����ֺ����е�����غ�ƫ�����
r21 = autocorr(da); % ����da�������
r22 = parcorr(da); % ����da��ƫ�����

% ��ȡ��ֺ����еĳ���
n = length(da);
k = 0; % ��ʼ��������

% ѭ��������ͬ��AR��MA�������
for i = 0:3
    for j = 0:3
        if i == 0 && j == 0
            continue; % ���AR��MA�Ľ�������0��������
        elseif i == 0
            ToEstMd = arima('MALags', 1:j, 'Constant', 0); % ����MA����
        elseif j == 0
            ToEstMd = arima('ARLags', 1:i, 'Constant', 0); % ����AR����
        else
            ToEstMd = arima('ARLags', 1:i, 'MALags', 1:j, 'Constant', 0); % ͬʱ��AR��MA����
        end
        k = k + 1; % ���¼�����
        R(k) = i; % ����AR����
        M(k) = j; % ����MA����
        [EstMd, EstParamCov, logL, info] = estimate(ToEstMd, da); % ����ARIMAģ��
        numParams = sum(any(EstParamCov)); % �������������
        [aic(k), bic(k)] = aicbic(logL, numParams, n); % ����AIC��BIC
    end
end

[Rgrid, Mgrid] = meshgrid(0:3, 0:3);

% ����AIC��BIC��ֵ��ƥ������ߴ磬��nan��䲻�Ϸ�����ϣ���R=0��M=0��
aic_grid = nan(size(Rgrid));
bic_grid = nan(size(Mgrid));
for idx = 1:length(R)
    aic_grid(R(idx)+1, M(idx)+1) = aic(idx);
    bic_grid(R(idx)+1, M(idx)+1) = bic(idx);
end

% ����AIC����ͼ
figure;
heatmap(0:3, 0:3, aic_grid);
title('AIC����ͼ');
xlabel('MA����');
ylabel('AR����');

% ����BIC����ͼ
figure;
heatmap(0:3, 0:3, bic_grid);
title('BIC����ͼ');
xlabel('MA����');
ylabel('AR����');


% ��ӡAR������MA������AIC��BIC�Ķ�Ӧֵ
fprintf('R, M, AIC, BIC�Ķ�Ӧֵ����:\n');
check = [R', M', aic', bic']; % �����������
disp(check); % ��ʾ���

% �����û�����AR��MA�Ľ���
r = input('������AR����R = ');
m = input('������MA����M = ');

% �����û�ָ����AR��MA����������ARIMAģ��
ToEstMd = arima('ARLags', 1:r, 'MALags', 1:m, 'Constant', 0);

% ����ģ�Ͳ���
[EstMd, EstParamCov, logL, info] = estimate(ToEstMd, da);

% ʹ�ù��Ƶ�ģ�ͽ���Ԥ�⣬Ԥ��δ��10��ֵ
dx_Forecast = forecast(EstMd, 10, 'Y0', da);

% ��Ԥ��Ĳ��ֵ�ۼӻ�ԭʼ���е����һ��ֵ���õ�ʵ�ʵ�Ԥ��ֵ
x_Forecast = a(end) + cumsum(dx_Forecast); % �ۼ�Ԥ��ֵ�Ի��ԭʼ���е�Ԥ��
% ����ԭʼ���ݺ�Ԥ�����ݵĶԱ�ͼ
figure;
hold on;
plot(1:length(a), a, 'LineWidth', 1.5); % ����ԭʼ����
plot(length(a)+1:length(a)+10, x_Forecast, 'r', 'LineWidth', 1.5); % ����Ԥ������
title('ARIMAģ��Ԥ����');
xlabel('ʱ��');
ylabel('ֵ');
legend('ԭʼ����', 'Ԥ������');
hold off;
