clear
clc
tic
time = [13 15 20
    10  20  18
    20  16  15
    8   10  6
    9   14  13 
    19  20  14  
    11  16  12  
    16  9   18
    15  12  7
    13  7   9];
v = [42;48;50;23;25;35;38;40;34;30];

price = zeros(1023,1);
idea = cell(1023,1);
for i = 1:1023
    m = dec2bin(i) - '0';
    len = 10 - length(m);
    m = [zeros(1,len),m]; % 补前导0
    id = find(m==1); %选择的零件编号
    rank = perms(id); % 穷举顺序
    mint = 10000; minid =0 ;
    for r=1:size(rank,1)
        tr = rank(r,:);% 当前的顺序
        time_per = zeros(length(tr),3);% 记录此排列中各个零件分别在三个加工阶段结束的最早时间
        time_per(1,1) = time(tr(1),1);
        time_per(1,2) = time_per(1,1) + time(tr(1),2);
        time_per(1,3) = time_per(1,2) + time(tr(1),3);
        for k = 2:length(tr)
            time_per(k,1) = time_per(k-1,1) + time(tr(k),1);
            for j = 2:3
                time_per(k,j) = max(time_per(k,j-1),time_per(k-1,j)) + time(tr(k),j);
            end
        end
        if time_per(end,end) < mint
            minid = r;  % 更新是第几个排列
            mint = time_per(end,end);   % 更新最小时间
        end
    end
    % 如果最小时间符合条件则记录改零件组总价值以及排列顺序
    if mint<=90
        price(i) = sum(v(id));
        idea{i} = rank(minid,:);
    end
end
toc
[maxv,maxp] = max(price);
maxv
idea{maxp}
                
    
    
    
    
    