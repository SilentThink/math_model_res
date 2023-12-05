function [c,ceq] = nonlfun1(x)
    % 注意：这里的c实际上就是非线性不等式约束，ceq实际上就是非线性等式约束
    % 输入值x实际上就是决策变量，由x1和x2组成的一个向量
    % 返回值有两个，一个是非线性不等式约束c，一个是非线性等式约束ceq
    % nonlfun1是函数名称，到时候会被fmincon函数调用, 可以任意取名，但不能和目标函数fun1重名
    % 保存的m文件和函数名称得一致，也要为nonlfun1.m
%     -(x1-1)^2 +x2 >= 0 
   c = [(x(1)-1)^2-x(2)];   % 千万別写成了: (x1-1)^2 -x2
   ceq = [];  % 不存在非线性等式约束，所以用[]表示
end


