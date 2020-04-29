% ����������
clear;
clc;
%% �������
county_size = 10;
countys_size = 40;
epoch = 200;
m = 2;      % ��Ӧֵ��һ����̭����ָ������ĸ��� С�ĸ�С
cross_rate = 0.4;
mutation_rate = 0.2;
%% ���ɻ�������
% ���ɳ�������
position = randn(county_size, 2);
% ���ɳ���֮��ľ������
distance = zeros(county_size, county_size);
for i = 1:county_size
    for j = i+1:county_size
        dis = (position(i, 1) - position(j, 1))^2 + (position(i, 2) - position(j, 2))^2;
        distance(i, j) = dis^0.5;
        distance(j, i) = distance(i, j);
    end
end
% ���ɳ�ʼ��Ⱥ
population = zeros(countys_size, county_size);
for i = 1: countys_size
    population(i, :) = randperm(county_size);
end
% %% ���ѡ��һ����Ⱥ
% pop = population(1, :);
% figure(1);
% scatter(position(:, 1), position(:, 2), 'k.');
% xlabel('x');
% ylabel('y');
% title('������зֲ����');
% axis([-3, 3, -3, 3]);
% figure(2);
% plot_route(position, pop);
% xlabel('x');
% ylabel('y');
% title('�������·���ֲ����');
% axis([-3, 3, -3, 3]);
%% ��ʼ����Ⱥ������Ӧ�Ⱥ���
fitness = zeros(countys_size, 1);
len = zeros(countys_size, 1);
for i = 1: countys_size
    len(i, 1) = myLength(distance, population(i, :));
end
maxlen = max(len);
minlen = min(len);
fitness = fit(len, m, maxlen, minlen);
rr = find(len == minlen);  % ���Բ�ѯ���
pop = population(rr(1, 1), :);
for i = 1: county_size
    fprintf('%d  ', pop(i));
end
fprintf('\n');
fitness = fitness/sum(fitness);
distance_min = zeros(epoch + 1, 1);
population_sel = zeros(countys_size + 1, county_size);
%% ��ʼ����
while epoch >= 0
    fprintf('���������� %d\n', epoch);
    nn = 0;
    p_fitness = cumsum(fitness);
    for i = 1:size(population, 1)
        len_1(i, 1) = myLength(distance, population(i, :));
        jc = rand;
        for j = 1: size(population, 1)
            if p_fitness(j, 1) > jc
                nn  = nn + 1;
                population_sel(nn, :) = population(j, :);
                break;
            end
        end
    end
    %% ÿ��ѡ�񱣴�������Ⱥ
    population_sel = population_sel(1:nn, :);
    [len_m, len_index] = min(len_1);
    [len_max, len_index_max] = max(len_1);
    population_sel(len_index_max, :) = population_sel(len_index, :);
    %% �������
    nnper = randperm(nn);
    A = population_sel(nnper(1), :);
    B = population_sel(nnper(2), :);
    for i = 1 : nn * cross_rate
        [A, B] = cross(A, B);
        population_sel(nnper(1), :) = A;
        population_sel(nnper(2), :) = B;
    end
    %% �������
    for i = 1: nn
        pick = rand;
        while pick == 0
            pick = rand;
        end
        if pick <= mutation_rate
            population_sel(i, :) = mutation(population_sel(i, :));
        end
    end
    %% ��ת����
    for i = 1: nn
        population_sel(i,:) = reverse(population_sel(i,:), distance);
    end
    %% ��Ӧ�Ⱥ�������
    NN = size(population_sel, 1);
    len = zeros(NN, 1);
    for i = 1: NN
        len(i, 1) = myLength(distance, population_sel(i, :));
    end
    maxlen = max(len);
    minlen = min(len);
    distance_min(epoch+1, 1) = minlen;
    fitness = fit(len, m, maxlen, minlen);
    rr = find(len == minlen);  % ���Բ�ѯ���
    fprintf('minlen�� %d\n', minlen);
    pop = population(rr(1, 1), :);
    for i = 1: county_size
        fprintf('%d  ', pop(i));
    end
    fprintf('\n');
    population = population_sel;
    epoch = epoch - 1;
end
figure(3);
plot_route(position, pop)
xlabel('x');
ylabel('y');
title('���ų���·���ֲ����');
axis([-3, 3, -3, 3]);   