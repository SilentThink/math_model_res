% ����ͼ�ıߺ�Ȩ��
s = [9 9 1 1 3 3 3 2 2 5 5 7 7 8]; % ��ʼ�ڵ���
t = [1 2 2 3 4 6 7 4 5 4 7 6 8 6]; % ��ֹ�ڵ���
w = [4 8 3 8 2 7 4 1 6 6 2 14 10 9]; % �ߵ�Ȩ��

% ����һ��ͼ�ζ��� G
G = graph(s,t,w);

% ����ͼ�� G�������ߵ�Ȩ����ӵ�ͼ����
% G.Edges.Weight ��ʾͼ�ζ��� G �����бߵ�Ȩ��ֵ��'EdgeLabel' ��ʾ��ͼ������ʾ��ЩȨ��ֵ
plot(G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2)
% ����ͼ�ε�������
set( gca, 'XTick', [], 'YTick', [] );

% shortestpath ��������ӽڵ� 9 ���ڵ� 8 �����·����·�����ȣ�����·����·�����ȷֱ�洢�� P �� d ��
[P,d] = shortestpath(G, 9, 8)
% ��ͼ�� G �и�����ʾ���·��
% highlight ��������ͼ�ζ��� myplot �е�·�� P��'EdgeColor', 'r' ��ʾ��·����ɫ����Ϊ��ɫ��
myplot = plot(G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2);
highlight(myplot, P, 'EdgeColor', 'r')


% ����ͼ�� G ����������֮������·������
D = distances(G)
% ��� 1 �� 2 �����·��
D(1,2)
% ��� 9 �� 4 �����·��
D(9,4)
% �ҳ�ͼ�� G �о���ڵ� 2 ������ 10 �����нڵ�
[nodeIDs,dist] = nearest(G, 2, 10)