clc
clear all
close all
path='./face_images/';
trainpath=[path,'train/'];
testpath=[path,'test/'];
trainImageNameList=getFileList(trainpath);
testImageNameList=getFileList(testpath);
for i=1:size(trainImageNameList,1)
    trainClassType(i,:)=ceil(i/5);
end
trueClassType = (1:40)';
newSize=[200,200];
energy=0.9;
pca_train(trainpath,trainImageNameList, newSize, trainClassType, energy);
testClassType = pca_test(testpath, testImageNameList, trueClassType);
%将人脸原图像与 特征脸反投影后的人脸对比
l=15; %要比对第几张
%显示一张人脸原图像
i1=imresize(imread([trainpath,trainImageNameList{l}]), newSize);
i1=rgb2gray(i1);
figure;
imshow(i1);
title(['第',num2str(l), '张人脸（原始）']);
%将特征脸反投影回去
load pca_data;
zeroMeanTrainSamples2=trainNew*T'; %特征脸反投影得到零均值的人脸
trainSamples2=zeroMeanTrainSamples2+repmat(trainSamplesMean,size(zeroMeanTrainSamples2,1),1); %加上均值
i2=reshape(trainSamples2(l,:)',newSize(1),newSize(2)); %还原为矩阵
% i2=imresize(i2,originSize); %还原为原始图像尺寸
figure;
imshow(i2);
title(['第',num2str(l), '张人脸（重建）']);

figure;bar(D);title('特征值');
num_eigenfaces = 10;
T2=T(:,1:num_eigenfaces);
img=reshape(T2, [newSize(1), num_eigenfaces*newSize(2)]);
img=mapminmax(img)/2+.5;
figure;imshow(img);title(['前',num2str(num_eigenfaces), '个特征脸']);