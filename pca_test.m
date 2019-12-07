function testClassType = pca_test(path, testImageNameList, trueClassType)
%testClassType = pca_test(path, testImageNameList, trueClassType)
%���ܣ�ѵ���������õ������ռ��ͶӰ���󣬲���������������
%���룺
% path����������·��
% testImageNameList������ͼ�������б�Ԫ�����飩
% trueClassType��������ʵ���
%�����
%testClassType��������

load ('pca_data.mat','trainClassType','newSize','trainSamplesMean','T','trainNew');

%�����Ӻ���������������ת��Ϊ������
[testSamples, ~, testNum]=arrDataMat(path, testImageNameList, newSize);
testZeroMeanSamples = testSamples-repmat(trainSamplesMean,testNum,1);
testNew = testZeroMeanSamples*T;%�����������������
n = size(trainNew,1);
m = size(testNew,1);
dis = zeros(m,n);
for i=1:m %��������
    for j=1:n
        dis(i,j) = sqrt(sum((testNew(i,:)-trainNew(j,:)).^2));
    end
end
K=1; %KNN����ڵ�kֵ
[~, sortDisIndex] = sort(dis, 2, 'ascend');
KnnClassType = zeros(m, n);
for i=1:m
    KnnClassType(i,:)=trainClassType(sortDisIndex(i,:))';
end
testClassType = mode(KnnClassType(:,1:K), 2);
if nargin == 3
    total = length(trueClassType);
    count = 0;
    for i=1:total
        if testClassType(i) == trueClassType(i)
            count = count+1;
        end
    end
    rate = count/total;
    fprintf('�����׼ȷ����%f\n',rate);
    figure;
    h=bar([rate,1-rate]);
    set(h,'barwidth',.2);
    set(gca,'xticklabel',{'true rate','false rate'});
    title('����׼ȷ��');
end
end