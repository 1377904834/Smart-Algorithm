% pop:��Ⱥ������Ⱥ������ ����������
% chromosome_size:����ߴ�
% Image: ͼ��
% pop_size: ��Ⱥ����
% m:ͼ�񳤶�
% n��ͼ����
% number: 
function [fitness, threshold, number] = fitnessty(pop, chromosome_size, Image, pop_size, m, n, number)
    num = m * n;
    for i = 1: pop_size
        number = number + 1;
        anti = pop(i, :);
        lower = [];
        high = [];
        hecimal = 0;
        for j = 1: chromosome_size
            hecimal = hecimal + anti(1, j) * (2 ^ (chromosome_size - j));
        end
        threshold(1, i) = hecimal * 255 / (2^chromosome_size - 1);
        for x = 1: m
            for y = 1: n
                if Image(x, y) > threshold(1, i)
                    high = [high, Image(x, y)];
                else
                    lower = [lower, Image(x, y)];
                end
            end
        end
        u = mean(mean(Image));
        if ~isempty(high)
            u0 = mean(high);
        else
            u0 = 0;
        end
        if ~isempty(lower)
            u1 = mean(lower);
        else
            u1 = 0;
        end
        w0 = length(high) / num;
        w1 = 1 - w0; % ʵ��Ӧ���� length(lower) / num

        fitness(1, i) = w0 * (u0 - u)^2 + w1 * (u1 - u)^2;
    end
end