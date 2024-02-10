close;clear;clc
%参数初始化
n = 250;
chushiqianfuzhe = 5;
% 邻居采用 8邻居式

% 0 ：代表易感者
% 1 ：代表潜伏者
% 2 ：代表患病者
% 3 ：代表免疫者
% 4 ：代表死亡者
% 5 :  代表虚拟值

p01 = 0.1;  %潜伏者传染给易感者的概率
p02 = 0.2;  %患病者传染给易感者的概率
p10 = 0.005; %免疫率
p24 = 0.001; %死亡率
p20 = 0.04; %对患病者治愈率 人工影响
p_10 = 0.06; %对潜伏者治愈率
k = 1; %患病系数 越大越说明病毒前期蛰伏越长

present = 5*ones(n+2);%周期性
present(2:n+1,2:n+1) = 0;%第2到n+1行，第2到n+1列代表易感染着；
while chushiqianfuzhe ~= sum(sum(present(2:n+1,2:n+1)))%初始潜伏者人数不等于易感染着人数；
   present(floor(n*rand),floor(n*rand)) = 1;%floor向下取整,这个点为潜伏着；
end
%潜伏者时间序列
T = zeros(n+2);

for i = 1:10000
    J  = 5*ones(n+2);
    to_qianfuzhe = zeros(n+2);
    
    for r = 2:n+1
        for q = 2:n+1
            %以下为易感者
            if present(r,q) == 0                          % 判断是否为易感染着；
                J(r,q) = 0;                               %易感染着全部变为潜伏者
            elseif present(r,q) == 1                      %判断是否为潜伏着
                temp = exp(-k*(12 - T(r,q))/T(r,q));      %该公式代表病毒前期潜伏时长
                % 自我影响
                if temp > rand                    %变为病患者
                    J(r,q) = 2;
                elseif rand < p10                 %变为免疫者
                    J(r,q) = 3; 
                elseif rand <  p_10               %变为易感者
                    J(r,q) = 0;  
                else 
                    J(r,q) = 1;                   %仍然为潜伏着
                end
                % 影响邻居
                if present(r-1,q-1) == 0  %判断左下方邻居是否为易感者
                    if rand < p01         %潜伏着以p01概率传染给易感者
                        to_qianfuzhe(r-1,q-1) = 1;%易感者变成了潜伏着
                    end
                end
                if present(r-1,q) == 0%判断下邻居是否为易感者
                    if rand < p01%潜伏着以p01概率传染给易感者
                        to_qianfuzhe(r-1,q) = 1;%易感者变成了潜伏着
                    end
                end
                if present(r-1,q+1) == 0%判断左上方邻居是否为易感者
                    if rand < p01%潜伏着以p01概率传染给易感者
                        to_qianfuzhe(r-1,q+1) = 1;%易感者变成了潜伏着
                    end
                end
                if present(r,q+1) == 0%判断右邻居是否为易感者
                    if rand < p01%潜伏着以p01概率传染给易感者
                        to_qianfuzhe(r,q+1) = 1;%易感者变成了潜伏着
                    end
                end
                if present(r+1,q+1) == 0%判断右上方邻居是否为易感者
                    if rand < p01%潜伏着以p01概率传染给易感者
                        to_qianfuzhe(r+1,q+1) = 1;%易感者变成了潜伏着
                    end
                end
                if present(r+1,q) == 0%判断上邻居是否为易感者
                    if rand < p01%潜伏着以p01概率传染给易感者
                        to_qianfuzhe(r+1,q) = 1;%易感者变成了潜伏着
                    end
                end
                if present(r+1,q-1) == 0%判断右下方邻居是否为易感者
                    if rand < p01 %潜伏着以p01概率传染给易感者
                        to_qianfuzhe(r+1,q-1) = 1;%易感者变成了潜伏着
                    end
                end    
                if present(r,q-1) == 0%判断他的左邻居位置为易感者
                    if rand < p01 %潜伏着传染给易感者
                        to_qianfuzhe(r,q-1) = 1;%易感者变成了潜伏着
                    end
                end
                
          elseif present(r,q) == 2 % 判断是否为患病者
              % 自我影响
                if p24 > rand                  %患病者以p02概率变为死亡者
                    J(r,q) = 4;    %患病者变成了死亡者
                elseif p20 > rand          %患病者以p20概率变为易感者
                    J(r,q) = 0;%患病者变成了易感者
                else
                    J(r,q) = 2;%否则为患病者
                end
                    
                %影响邻居
                if present(r-1,q-1) == 0%判断左下方邻居是否为易感者
                    if rand < p02%患病者以p02概率传染给易感者
                        to_qianfuzhe(r-1,q-1) = 1;%易感者变为潜伏者
                    end
                end
                if present(r-1,q) == 0%判断下邻居是否为易感者
                    if rand < p02%患病者以p02概率传染给易感者
                        to_qianfuzhe(r-1,q) = 1;%易感者变为潜伏者
                    end
                end
                if present(r-1,q+1) == 0%判断左上方邻居是否为易感者
                    if rand < p02%患病者以p02概率传染给易感者
                        ro_qianfuzhe(r-1,q+1) = 1;%易感者变为潜伏者
                    end
                end
                if present(r,q+1) == 0%判断右邻居是否为易感者
                    if rand < p02%患病者以p02概率传染给易感者
                        to_qianfuzhe(r,q+1) = 1;%易感者变为潜伏者
                    end
                end
                if present(r+1,q+1) == 0%判断右上方邻居是否为易感者
                    if rand < p02%患病者以p02概率传染给易感者
                        to_qianfuzhe(r+1,q+1) = 1;%易感者变为潜伏者
                    end
                end
                if present(r+1,q) == 0%判断上邻居是否为易感者
                    if rand < p02%患病者以p02概率传染给易感者
                        to_qianfuzhe(r+1,q) = 1;%易感者变为潜伏者
                    end
                end
                if present(r+1,q-1) == 0%判断左上方邻居是否为易感者
                    if rand < p02 %患病者以p02概率传染给易感者
                        to_qianfuzhe(r+1,q-1) = 1;%易感者变为潜伏者
                    end
                end
                if present(r,q-1) == 0%判断下邻居是否为易感者
                    if rand < p02%患病者以p02概率传染给易感者
                        to_qianfuzhe(r,q-1) = 1;%易感者变为潜伏者
                    end
                end
                    
            %以下为免疫者
            elseif present(r,q) == 3%判断是否为免疫者
                J(r,q) = 3;%患病者变为免疫者
            %以下为死亡者
            elseif present(r,q) == 4%判断是否为死亡者
                J(r,q) = 4;%患病者变为死亡者
            end
        end
    end
    % 此处T为0-N矩阵 N代表 仅为上一次潜伏者并且这一次也为潜伏者的潜伏者时间
    
    
    %易感者转变为潜伏着
    J(present == 0 & to_qianfuzhe) =  1;
    % 更新病毒潜伏时间
    T(find(T ~= 0)) = T(find(T ~= 0)) + 1; 
    T(present == 0 & to_qianfuzhe) = 1; %上一次不为潜伏者，这次变为潜伏者的潜伏者时间
    present = J; %更新present矩阵
    
    % 以下为输出结果
    R = zeros(n);
    G = zeros(n);
    B = zeros(n);
    yiganzhe(i) = sum(sum(J == 0));
    qianfuzhe(i) = sum(sum(J == 1));
    huanbingzhe(i) = sum(sum(J == 2));
    mianyizhe(i) = sum(sum(J == 3));
    siwangzhe(i) = sum(sum(J  == 4));
    for r = 1:n
        for q = 1:n 
            if J(r+1,q+1) == 0
                B(r,q) = 1;
            elseif J(r+1,q+1) == 1
                R(r,q) = 160/255;
                G(r,q) = 32/255;
                B(r,q) = 240/255;
            elseif J(r+1,q+1) == 2
                R(r,q) = 1;
            elseif J(r+1,q+1) == 3
                G(r,q) = 1;
            end
      end
    end
  figure(1);
  image(cat(3,R,G,B));
  drawnow
  figure(2);
  subplot(321),temp = plot(qianfuzhe,'-');set(temp,'color',[160/255 32/255 240/255]),
  title(['时间: ',num2str(i),' 潜伏者']);
  subplot(322),plot(huanbingzhe,'r-'),title(['时间: ',num2str(i),' 患病者']);
  subplot(323),plot(mianyizhe,'g-'),title(['时间: ',num2str(i),' 免疫者']);
  subplot(324),plot(siwangzhe,'k-'),title(['时间: ',num2str(i),' 死亡者']);
  subplot(313),plot(yiganzhe,'b-'),title(['时间: ',num2str(i),' 易感者']);
  pause(0.001);
end
