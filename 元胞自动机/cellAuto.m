clc
clear
n=200;
Se=zeros(n);
z=zeros(n);
Se(n/2-2:n/2+2,n/2-2:n/2+2)=1;
% Ch=imagesc(Se)
Ch=imagesc(cat(3,Se,z,z));
axis square;
Sd=zeros(n+2);  %边界
while(1)
    Sd(2:n+1,2:n+1)=Se;
    % 上下左右邻居和
    sum=Sd(1:n,2:n+1)+Sd(3:n+2,2:n+1)+Sd(2:n+1,1:n)+Sd(2:n+1,3:n+2);
    % 和为奇数则元胞为1，和为偶数则元胞为0
    Se=mod(sum,2);
    set(Ch,'cdata',cat(3,Se,z,z))
    pause(0.03)
end
    