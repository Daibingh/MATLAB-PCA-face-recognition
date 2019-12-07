function [samples, samplesMean, rawNum, rolNum, originSize]=arrDataMat(path, imageNameList, newSize)        
%[samples, samplesMean, rawNum, rolNum, originSize]=arrDataMat(path, imageNameList, newSize) 
%�Ӻ���������ͼ�������б���ȡͼ�����ݣ����ҶȻ���ת���� ������*[newSize(1)*newSize(2)]������
%���룺
%path��ͼ��·��
%imageNameList��ͼ�������б�����ΪԪ������
%newSize��������ͼ��߶�
%�����
%samples�����ݾ���һ��Ϊһ��������
%samplesMean��������ƽ��ֵ����������
%rawNum��������
%rolNum��ԭʼ�ı���ά���������ص���*���ص���
%originSize������ǰͼƬ�ߴ�

rawNum = size(imageNameList,1); %rawNum:������
rolNum=newSize(1)*newSize(2); %ԭʼά��
samples = zeros(rawNum, rolNum);
img = imread([path,imageNameList{1}]);
originSize = size(img);
originSize = originSize(1:2);
clear img;
%׼����������
 for k=1:rawNum
     imageTemp_ = imread([path,imageNameList{k}]);
     imageTemp = im2double(imageTemp_);
     if length(size(imageTemp))==3
        imageTemp = rgb2gray(imageTemp); %�ҶȻ�
%         imageTemp = histeq(imageTemp); %ֱ��ͼ���⻯
     end
    imageTemp2 = imresize(imageTemp, newSize);
    imageTemp3  = imageTemp2(:)';
    samples(k,:) = imageTemp3;
end
samplesMean = mean(samples); %������ֵ
end