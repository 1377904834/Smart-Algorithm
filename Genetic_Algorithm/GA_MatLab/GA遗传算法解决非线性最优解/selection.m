%���ѡ���µĸ���
%���������pop��������Ⱥ��fitvalue����Ӧ��ֵ
%���������newpopѡ���Ժ�Ķ�������Ⱥ
function [newpop] = selection(pop,fitvalue)
%��������
[px,py] = size(pop);
totalfit = sum(fitvalue);
p_fitvalue = fitvalue/totalfit;
p_fitvalue = cumsum(p_fitvalue); % ��������ۼ�ֵ ��ת�̣�
ms = sort(rand(px,1)); % ��С�������У�ָ�룩
fitin = 1;
newin = 1;
while newin<=px
    if(ms(newin))<p_fitvalue(fitin)
        newpop(newin,:)=pop(fitin,:);
        newin = newin+1;
    else
        fitin=fitin+1;
    end
end