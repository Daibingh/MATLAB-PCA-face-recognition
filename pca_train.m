function pca_train(path,trainImageNameList, newSize, trainClassType, energy)
%pca_train(path,trainImageNameList, newSize, trainClassType, energy)
%功能：根据训练样本，计算并保存classType,newSize,originSize，平均脸，特征脸，投影矩阵,到pca_data.mat
%输入：
% path：训练样本路径
% trainImageNameList：训练图像名称列表（元胞数组）
% newSize：缩减后的图像尺度
% trainClassType：训练样本类别标号(列向量)
% energy：能量比
%输出：
%保存pca_data.mat到当前目录

save('pca_data.mat','trainClassType');
fprintf('保存trainClassType到pca_data.mat成功！\n');
save('pca_data.mat','newSize','-append');
fprintf('保存newSize到pca_data.mat成功！\n');

%step1:调用子函数，计算训练样本的数据阵,和平均脸
[trainSamples, trainSamplesMean, trainNum, ~, originSize]=arrDataMat(path, trainImageNameList, newSize);
trainMeanFace = reshape(trainSamplesMean',newSize(1),newSize(2));
save('pca_data.mat','trainSamplesMean','-append');
fprintf('保存trainSamplesMean到pca_data.mat成功！\n');
save('pca_data.mat','originSize','-append');
fprintf('保存originSize到pca_data.mat成功！\n');
figure;
% trainMeanFace = imresize(trainMeanFace, originSize);
imshow(trainMeanFace); %显示平均脸
title('Mean face of the training samples');
%step2：求协方差阵的特征值和向量并排序，正交化单位化，求投影矩阵
%求样本的协方差矩阵，并求特征值和特征向量,确定出降的维数,求投影矩阵
%不直接求a'a的特征值特征向量，而是采用SVD的方法，利用aa'的特征值特征向量来求a'a的特征值和向量
trainZeroMeanSamples=trainSamples-repmat(trainSamplesMean,trainNum,1);%计算零均值的人脸样本
cov = trainZeroMeanSamples*trainZeroMeanSamples';%求协方差矩阵
[v, d] = eig(cov);
lamna = diag(d);
[D, indx] = sort(lamna,1,'descend');%对特征值进行排序
rankV = v(:,indx);%对特征向量排序
t = 0;
tt = sum(D);
for i=1:trainNum %选出累积能量占%99特征值
    t = t + D(i);
    ratio = t/tt;
    if(ratio>=energy)
        break;
    end
end
T_len=i;%选出特征值的个数
T2 = rankV(:,1:i);%选出特征向量
D2 = D(1:i);%选出特征值
T3 = simitzj(T2,D2); %特征向量的归一化，正交化
%求a'a的特征值特征向量,还原为原始协方差的特征向量
L = repmat((1./sqrt(D2))',trainNum,1);
T=trainZeroMeanSamples'*(T3.*L);%投影矩阵
% Data{4} = T;
save('pca_data.mat','T','-append');
fprintf('保存投影矩阵T到pca_data.mat成功！\n');
D = D2;
save('pca_data.mat', 'D', '-append');
fprintf('保存特征值D到pca_data.mat成功！\n');

%step3：求训练样本的特征脸
trainNew = trainZeroMeanSamples*T; %求训练样本特征脸
% Data{5} = trainNew;
% save('Data.mat','Data');
% disp('数据保存成功！');
save('pca_data.mat','trainNew','-append');
fprintf('保存trainNew到pca_data.mat成功！\n');
end
