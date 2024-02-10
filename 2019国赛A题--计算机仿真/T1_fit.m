% 拟合E关于P的方程
clear
clc

data = xlsread("附件3-弹性模量与压力.xlsx",'Sheet1','A2:B402');%P E
x= data(:,1);
y= data(:,2);
plot(x,y);
% coef2 = polyfit(x,y,2);
coef3 = polyfit(x,y,3); % 拟合一元三次方程 系数降幂排序 存于coef3

%% 设置初始参数
C = 0.85; % 流量系数
A = pi*0.7*0.7; %小孔面积
V = pi*5*5*500; %高压油管体积
t_close = 10; %关闸时间
tstep = 0.02; %时间步长

P_pertop = zeros(1,length(0.01:0.01:1));% 每个t_open的目标值
pos2 = 1;

%% 模拟仿真——遍历可能的解
for t_open = 0.01:0.01:1
    P_yb = 160; % 油泵恒压力
    P_yg = 100; % 油管初始压力
    rho_yb = 0.8725; %油泵密度
    rho_yg = 0.85;  %油管密度
    m_yg = rho_yg * V; %起始油管质量
    P_pertime = zeros(1,length(tstep:tstep:4000));% 每个时间结点的压力值
    pos1 = 1;
    
    %迭代时间
    for t = tstep:tstep:4000
        %计算体积（管内油量）变化
        if P_yb > P_yg
            %Q为单位时间流过小孔的燃油量（mm3/ms）C=0.85为流量系数，A为小孔的面积（mm2），delta_P为小孔两边的压力差（MPa），rho为高压侧燃油的密度（mg/mm3）。
            Q_in = getState(t,t_open,t_close)* C*A*sqrt(2*(P_yb-P_yg)/rho_yb)*tstep;
            Q_out = getVpy(t)*tstep;
        else
            Q_in = 0;
            Q_out = getVpy(t) * tstep + getState(t,t_open,t_close)* C*A*sqrt(2*(P_yg-P_yb)/rho_yb)*tstep;
        end
        
        % 计算油管内质量
        m_yg = m_yg+(Q_in-Q_out) * rho_yg;
       
        % 更新密度
        rho_yg = m_yg/V;
        
        %计算压力
        P_yg = rho2P(rho_yg);
        P_pertime(pos1) = P_yg;
        pos1 = pos1+1;
    end 
    P_pertop(pos2) = sum(abs(P_pertime - 100).^2) / length(P_pertime); % 这里改用方差是不是会更好
    pos2 = pos2 + 1;
end

[minv,minp]=min(P_pertop);
t_open = minp /100;

%% 回代 绘图
P_yb = 160; % 油泵恒压力
P_yg = 100; % 油管初始压力
rho_yb = 0.8725; %油泵密度
rho_yg = 0.85;  %油管密度
m_yg = rho_yg * V; %起始油管质量
P_pertime = zeros(1,length(tstep:tstep:4000));% 每个时间结点的压力值
pos1 = 1;

%迭代时间
for t = tstep:tstep:4000
    %计算体积（管内油量）变化
    if P_yb > P_yg
        %Q为单位时间流过小孔的燃油量（mm3/ms）C=0.85为流量系数，A为小孔的面积（mm2），delta_P为小孔两边的压力差（MPa），rho为高压侧燃油的密度（mg/mm3）。
        Q_in = getState(t,t_open,t_close)* C*A*sqrt(2*(P_yb-P_yg)/rho_yb)*tstep;
        Q_out = getVpy(t)*tstep;
    else
        Q_in = 0;
        Q_out = getVpy(t) * tstep + getState(t,t_open,t_close)* C*A*sqrt(2*(P_yg-P_yb)/rho_yb)*tstep;
    end

    % 计算油管内质量
    m_yg = m_yg+(Q_in-Q_out) * rho_yg;

    % 更新密度
    rho_yg = m_yg/V;

    %计算压力
    P_yg = rho2P(rho_yg);
    P_pertime(pos1) = P_yg;
    pos1 = pos1+1;
end 
plot(P_pertime(1:40000));

%% 密度转压力
function P = rho2P(rho)
    P = 17283.9969 * rho^2 - 27109.8125 * rho +10655.7540;
end

%% 单向阀的状态
function flag = getState(t,t_open,t_close)
    % t当前时间 t_open开阀时间 t_close关阀时间
    % 开阀flag=1, 关阀flag=0
    T = t_open + t_close; %周期
    nt = mod(t,T);
    if nt < t_open
        flag=1;
    else
        flag=0; 
    end
end

%% 喷油速率
function v = getVpy(t)
    % 输入时间 t : ms
    % 输出速率 v
    n = floor(t/100);%得到周期数 喷油器每秒工作10次 每次100ms周期
    nt = t-n*100;
    if nt < 0.2
        v=100*nt;
    elseif nt < 2.2
        v = 20;
    elseif nt <2.4
        v=-100*nt + 240;
    else
        v=0;
    end
end