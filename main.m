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
%������ԭͼ���� ��������ͶӰ��������Ա�
l=15; %Ҫ�ȶԵڼ���
%��ʾһ������ԭͼ��
i1=imresize(imread([trainpath,trainImageNameList{l}]), newSize);
i1=rgb2gray(i1);
figure;
imshow(i1);
title(['��',num2str(l), '��������ԭʼ��']);
%����������ͶӰ��ȥ
load pca_data;
zeroMeanTrainSamples2=trainNew*T'; %��������ͶӰ�õ����ֵ������
trainSamples2=zeroMeanTrainSamples2+repmat(trainSamplesMean,size(zeroMeanTrainSamples2,1),1); %���Ͼ�ֵ
i2=reshape(trainSamples2(l,:)',newSize(1),newSize(2)); %��ԭΪ����
% i2=imresize(i2,originSize); %��ԭΪԭʼͼ��ߴ�
figure;
imshow(i2);
title(['��',num2str(l), '���������ؽ���']);

figure;bar(D);title('����ֵ');
num_eigenfaces = 10;
T2=T(:,1:num_eigenfaces);
img=reshape(T2, [newSize(1), num_eigenfaces*newSize(2)]);
img=mapminmax(img)/2+.5;
figure;imshow(img);title(['ǰ',num2str(num_eigenfaces), '��������']);