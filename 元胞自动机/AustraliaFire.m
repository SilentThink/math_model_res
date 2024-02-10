clc
clear
n=300;
Plight=5e-6; Pgrowth = 1e-3;        %定义闪电和生长的概率
UL = [n,1:n-1];DR = [2:n,1];        %定义上左,下右邻居
veg=zeros(n,n);                     %初始化表示森林的矩阵
imh = image(cat(3,veg,veg,veg));    %可视化森林矩阵
% veg 空地0 着火1 树2


while(1)
    % 周围四个邻居和(周期型边缘邻居)
    sum=(veg(UL,:)==1)+(veg(:,UL)==1)+(veg(:,DR)==1)+(veg(DR,:)==1);
    % 根据规则更新森林矩阵
    veg = 2*(veg==2) - ((veg==2) & (sum>0 | (rand(n,n)<Plight))) + 2*((veg==0) &rand(n,n)<Pgrowth);
    set(imh,'cdata',cat(3,(veg==1),(veg==2),zeros(n)));
    % pause(0.03)
    drawnow
end
    