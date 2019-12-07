function testClassType = pca_test(path, testImageNameList, trueClassType)
%testClassType = pca_test(path, testImageNameList, trueClassType)
%功能：训练样本，得到特征空间的投影矩阵，并求测试样本的类别
%输入：
% path：测试样本路径
% testImageNameList：测试图像名称列表（元胞数组）
% trueClassType：测试真实类别
%输出：
%testClassType：分类结果

load ('pca_data.mat','trainClassType','newSize','trainSamplesMean','T','trainNew');

%调用子函数，将测试样本转化为数据阵
[testSamples, ~, testNum]=arrDataMat(path, testImageNameList, newSize);
testZeroMeanSamples = testSamples-repmat(trainSamplesMean,testNum,1);
testNew = testZeroMeanSamples*T;%求测试样本的特征脸
n = size(trainNew,1);
m = size(testNew,1);
dis = zeros(m,n);
for i=1:m %求距离矩阵
    for j=1:n
        dis(i,j) = sqrt(sum((testNew(i,:)-trainNew(j,:)).^2));
    end
end
K=1; %KNN最近邻的k值
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
    fprintf('分类的准确度是%f\n',rate);
    figure;
    h=bar([rate,1-rate]);
    set(h,'barwidth',.2);
    set(gca,'xticklabel',{'true rate','false rate'});
    title('测试准确率');
end
end