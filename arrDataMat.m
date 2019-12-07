function [samples, samplesMean, rawNum, rolNum, originSize]=arrDataMat(path, imageNameList, newSize)        
%[samples, samplesMean, rawNum, rolNum, originSize]=arrDataMat(path, imageNameList, newSize) 
%子函数，根据图像名称列表，读取图像数据，并灰度化，转化成 样本数*[newSize(1)*newSize(2)]数据阵
%输入：
%path：图像路径
%imageNameList：图像名称列表，类型为元胞数组
%newSize：缩减后图像尺度
%输出：
%samples：数据矩阵（一行为一个样本）
%samplesMean：数据阵平均值（行向量）
%rawNum：样本数
%rolNum：原始的变量维数，即像素的行*像素的列
%originSize：缩减前图片尺寸

rawNum = size(imageNameList,1); %rawNum:样本数
rolNum=newSize(1)*newSize(2); %原始维度
samples = zeros(rawNum, rolNum);
img = imread([path,imageNameList{1}]);
originSize = size(img);
originSize = originSize(1:2);
clear img;
%准备样本矩阵
 for k=1:rawNum
     imageTemp_ = imread([path,imageNameList{k}]);
     imageTemp = im2double(imageTemp_);
     if length(size(imageTemp))==3
        imageTemp = rgb2gray(imageTemp); %灰度化
%         imageTemp = histeq(imageTemp); %直方图均衡化
     end
    imageTemp2 = imresize(imageTemp, newSize);
    imageTemp3  = imageTemp2(:)';
    samples(k,:) = imageTemp3;
end
samplesMean = mean(samples); %样本均值
end