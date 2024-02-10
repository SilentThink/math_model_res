%% Matlab������ͼ
% ��1����Ȩ�أ�ÿ���ߵ�Ȩ��Ĭ��Ϊ1��
% ����graph(s,t)������ s �� t �еĶ�Ӧ�ڵ�֮�䴴���ߣ�������һ��ͼ
% s �� t �����������ͬ��Ԫ��������Щ�ڵ���붼�Ǵ�1��ʼ���������������ַ���Ԫ�����顣
% ע��Ŷ���������Ǵ�1��ʼ������ţ���Ҫ�Լ���㶨����
s1 = [1,2,3,4];
t1 = [2,3,1,1];
G1 = graph(s1, t1);
plot(G1)
% ������������ڻ�ͼ����ʾ����
set( gca, 'XTick', [], 'YTick', [] );  


% ע���ַ���Ԫ���������ô����Ű�������Ŷ
s2 = {'ѧУ','��ӰԺ','����','�Ƶ�'};
t2 = {'��ӰԺ','�Ƶ�','�Ƶ�','KTV'};
G2 = graph(s2, t2);
plot(G2, 'linewidth', 2)  % �����ߵĿ��
% ������������ڻ�ͼ����ʾ����
set( gca, 'XTick', [], 'YTick', [] );  

% ��2����Ȩ��
% ����graph(s,t,w)������ s �� t �еĶ�Ӧ�ڵ�֮����w��Ȩ�ش����ߣ�������һ��ͼ
s = [1,2,3,4];
t = [2,3,1,1];
w = [3,8,9,2];
G = graph(s, t, w);
% G.Edges.Weight ��ʾͼ�ζ��� G �����бߵ�Ȩ��ֵ��'EdgeLabel' ��ʾ��ͼ������ʾ��ЩȨ��ֵ
plot(G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2) 
set( gca, 'XTick', [], 'YTick', [] );  

% ����graph(a)��aΪ�ڽӾ���0��ʾû�б�
a=[0 3 9 2;
   3 0 8 0;
   9 8 0 0;
   2 0 0 0];
G = graph(a);
% a=[0 3 9 2;
%    0 0 8 0;
%    0 0 0 0;
%    0 0 0 0];
% G = graph(a,'upper'); %'upper'��ʹ�������Ǿ���������ͼ
% G.Edges.Weight ��ʾͼ�ζ��� G �����бߵ�Ȩ��ֵ��'EdgeLabel' ��ʾ��ͼ������ʾ��ЩȨ��ֵ
plot(G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2) 
set( gca, 'XTick', [], 'YTick', [] );  
%% Matlab������ͼ
% ��Ȩͼ digraph(s,t)
s = [1,2,3,4,3,6,4,3,2,5];
t = [2,3,4,5,6,5,3,2,1,6];
G = digraph(s, t);
G.Nodes.Name = {'0' '1' '2' '3' '4' '5'}';
plot(G)
set( gca, 'XTick', [], 'YTick', [] );  

% ��Ȩͼ digraph(s,t,w)
s = [1,2,3,4];
t = [2,3,1,1];
w = [3,8,9,2];
G = digraph(s, t, w);
plot(G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2) 
set( gca, 'XTick', [], 'YTick', [] );  
%digraph(a) aΪ�ڽӾ���
a=[0 3 0 0;
   0 0 8 0;
   9 0 0 0;
   2 0 0 0];
G = digraph(a);
% s=cellstr(strcat('����',int2str([1:4]')));
% % ��ÿ�������ע���ƣ�int2str([1:4]')������1��4������ת��Ϊ�ַ�
% % strcat���ַ���ˮƽ��������
% % strcat('����',int2str([1:4]'))�Ѷ�����ַ�1��4ƴ����
% G = digraph(a,s);
plot(G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2) 
set( gca, 'XTick', [], 'YTick', [] );  


