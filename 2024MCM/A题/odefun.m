function dydt = odefun(t, y)
    epsl = 0.005; % 环境影响因子
    Ez = 0.001; % 环境阻力因子
    Nm = 500; % 最大环境容纳量
    dydt = 1/exp(1)*log(y)/y*(exp(-epsl*t)-1)*(1-y/(Nm-Ez*t))*y;
end