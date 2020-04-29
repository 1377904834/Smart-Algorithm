% distance:�������������ͼ�ı��淽ʽ������ÿһ������֮��ľ��룬��С��N*N
% chromosome: ���ڵ���Ⱦɫ�壬����洢�����г��е��������
function len = myLength(distance, chromosome)
    [~, N] = size(distance);
    len = distance(chromosome(1, N), chromosome(1, 1));
    for i = 1:(N-1)
        len = len + distance(chromosome(1, i), chromosome(1, i + 1));
    end
end