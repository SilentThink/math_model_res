%%  输入原始数据并做出时间序列图
clear;clc
year =xlsread('发展数据.xlsx', 1, 'A2:A13');
x0 =xlsread('发展数据.xlsx', 1, 'B2:B13');
% x0 =xlsread('发展数据.xlsx', 1, 'C2:C13');
% x0 =xlsread('发展数据.xlsx', 1, 'D2:D13');
% 画出原始数据的时间序列图
figure(1); % 因为我们的图形不止一个，因此要设置编号
plot(year,x0,'o-'); grid on;  % 原式数据的时间序列图
set(gca,'xtick',year(1:1:end))  % 设置x轴横坐标的间隔为1
xlabel('年份');  ylabel('排污总量');  % 给坐标轴加上标签


%% 因为我们要使用GM(1,1)模型，其适用于数据期数较短的非负时间序列
ERROR = 0;  % 建立一个错误指标，一旦出错就指定为1
% 判断是否有负数元素
if sum(x0<0) > 0  % x0<0返回一个逻辑数组(0-1组成)，如果有数据小于0，则所在位置为1，如果原始数据均为非负数，那么这个逻辑数组中全为0，求和后也是0~
    disp('亲，灰色预测的时间序列中不能有负数哦')
    ERROR = 1;
end

% 判断数据量是否太少
n = length(x0);  % 计算原始数据的长度
disp(strcat('原始数据的长度为',num2str(n)))    % strcat()是连接字符串的函数，第一讲学了，可别忘了哦
if n<=3
    disp('亲，数据量太小，我无能为力哦')
    ERROR = 1;
end

% 数据太多时提示可考虑使用其他方法（不报错）
if n>10
    disp('亲，这么多数据量，可以要考虑使用其他的方法哦，例如ARIMA，指数平滑等')
end

% 判断数据是否为列向量，如果输入的是行向量则转置为列向量
if size(x0,1) == 1
    x0 = x0';
end
if size(year,1) == 1
    year = year';
end


%% 对一次累加后的数据进行准指数规律的检验(注意，这个检验有时候即使能通过，也不一定能保证预测结果非常好，例如上面的第三组数据)
if ERROR == 0   % 如果上述错误均没有发生时，才能执行下面的操作步骤
    disp('------------------------------------------------------------')
    disp('准指数规律检验')
    x1 = cumsum(x0);   % 生成1-AGO序列，cumsum是累加函数哦~    注意：1.0e+03 *0.1740的意思是科学计数法,即10^3*0.1740 = 174
    rho = x0(2:end) ./ x1(1:end-1) ;   % 计算光滑度rho(k) = x0(k)/x1(k-1)
    
    % 画出光滑度的图形，并画上0.5的直线，表示临界值
    figure(2)
    plot(year(2:end),rho,'o-',[year(2),year(end)],[0.5,0.5],'-'); grid on;
    text(year(end-1)+0.2,0.55,'临界线')   % 在坐标(year(end-1)+0.2,0.55)上添加文本
    set(gca,'xtick',year(2:1:end))  % 设置x轴横坐标的间隔为1
    xlabel('年份');  ylabel('原始数据的光滑度');  % 给坐标轴加上标签
    
    
    disp(strcat('指标1：光滑比小于0.5的数据占比为',num2str(100*sum(rho<0.5)/(n-1)),'%'))
    disp(strcat('指标2：除去前两个时期外，光滑比小于0.5的数据占比为',num2str(100*sum(rho(3:end)<0.5)/(n-3)),'%'))
    disp('参考标准：指标1一般要大于60%, 指标2要大于90%，你认为本例数据可以通过检验吗？')
    
    Judge = input('你认为可以通过准指数规律的检验吗？可以通过请输入1，不能请输入0：');
    if Judge == 0
        disp('亲，灰色预测模型不适合你的数据哦~ 请考虑其他方法吧 例如ARIMA，指数平滑等')
        ERROR = 1;
    end
    disp('------------------------------------------------------------')
end

if ERROR == 0   % 如果上述错误均没有发生时，才能执行下面的操作步骤
        if n > 7    % 将数据分为训练组和试验组(根据原数据量大小n来取，n小于7则取最后两年为试验组，n大于7则取最后三年为试验组)
            test_num = 3;
        else
            test_num = 2;
        end
        train_x0 = x0(1:end-test_num);  % 训练数据
        disp('训练数据是: ')
        disp(mat2str(train_x0'))  % mat2str可以将矩阵或者向量转换为字符串显示, 这里加一撇表示转置，把列向量变成行向量方便观看
        test_x0 =  x0(end-test_num+1:end); % 试验数据
        disp('试验数据是: ')
        disp(mat2str(test_x0'))  % mat2str可以将矩阵或者向量转换为字符串显示
        disp('------------------------------------------------------------')
        
        % 使用GM（1，1）模型对训练数据进行训练，返回的result就是往后预测test_num期的数据
        disp(' ')
        disp('***下面是GM(1,1)模型预测的详细过程***')
        result1 = gm11(train_x0, test_num); %使用传统的GM(1,1)模型对训练数据，并预测后test_num期的结果
        disp(' ')
        disp('------------------------------------------------------------')
        % 绘制对试验数据进行预测的图形
        test_year = year(end-test_num+1:end);  % 试验组对应的年份
        figure(3)
        plot(test_year,test_x0,'o-',test_year,result1,'*-'); grid on;
        set(gca,'xtick',year(end-test_num+1): 1 :year(end))  % 设置x轴横坐标的间隔为1
        legend('试验组的真实数据','GM(1,1)预测结果')  % 注意：如果lengend挡着了图形中的直线，那么lengend的位置可以自己手动拖动
        xlabel('年份');  ylabel('排污总量');  % 给坐标轴加上标签
     
        predict_num = input('请输入你要往后面预测的期数： ');
        % 计算使用传统GM模型的结果，用来得到另外的返回变量：x0_hat, 相对残差relative_residuals和级比偏差eta
        [result, x0_hat, relative_residuals, eta] = gm11(x0, predict_num);  % 先利用gm11函数得到对原数据拟合的详细结果
        
        %% 输出使用模型预测出来的结果
        disp('------------------------------------------------------------')
        disp('对原始数据的拟合结果：')
        for i = 1:n
            disp(strcat(num2str(year(i)), ' ： ',num2str(x0_hat(i))))
        end
        disp(strcat('往后预测',num2str(predict_num),'期的得到的结果：'))
        for i = 1:predict_num
            disp(strcat(num2str(year(end)+i), ' ： ',num2str(result(i))))
        end
    
    %% 绘制相对残差和级比偏差的图形
    figure(4)
    subplot(2,1,1)  % 绘制子图（将图分块）
    plot(year(2:end), relative_residuals,'*-'); grid on;   % 原数据中的各时期和相对残差
    legend('相对残差'); xlabel('年份');
    set(gca,'xtick',year(2:1:end))  % 设置x轴横坐标的间隔为1
    subplot(2,1,2)
    plot(year(2:end), eta,'o-'); grid on;   % 原数据中的各时期和级比偏差
    legend('级比偏差'); xlabel('年份');
    set(gca,'xtick',year(2:1:end))  % 设置x轴横坐标的间隔为1
    disp(' ')
    disp('****下面将输出对原数据拟合的评价结果***')
    
    %% 残差检验
    average_relative_residuals = mean(relative_residuals);  % 计算平均相对残差 mean函数用来均值
    disp(strcat('平均相对残差为',num2str(average_relative_residuals)))
    if average_relative_residuals<0.1
        disp('残差检验的结果表明：该模型对原数据的拟合程度非常不错')
    elseif average_relative_residuals<0.2
        disp('残差检验的结果表明：该模型对原数据的拟合程度达到一般要求')
    else
        disp('残差检验的结果表明：该模型对原数据的拟合程度不太好，建议使用其他模型预测')
    end
    
    %% 级比偏差检验
    average_eta = mean(eta);   % 计算平均级比偏差
    disp(strcat('平均级比偏差为',num2str(average_eta)))
    if average_eta<0.1
        disp('级比偏差检验的结果表明：该模型对原数据的拟合程度非常不错')
    elseif average_eta<0.2
        disp('级比偏差检验的结果表明：该模型对原数据的拟合程度达到一般要求')
    else
        disp('级比偏差检验的结果表明：该模型对原数据的拟合程度不太好，建议使用其他模型预测')
    end
    disp(' ')
    disp('------------------------------------------------------------')
    
    %% 绘制最终的预测效果图
    figure(5)  % 下面绘图中的符号m:洋红色 b:蓝色
    plot(year,x0,'-o',  year,x0_hat,'-*m',  year(end)+1:year(end)+predict_num,result,'-*b' );   grid on;
    hold on;
    plot([year(end),year(end)+1],[x0(end),result(1)],'-*b')
    legend('原始数据','拟合数据','预测数据')  % 注意：如果lengend挡着了图形中的直线，那么lengend的位置可以自己手动拖动
    set(gca,'xtick',[year(1):1:year(end)+predict_num])  % 设置x轴横坐标的间隔为1
    xlabel('年份');  ylabel('排污总量');  % 给坐标轴加上标签
end
