function pca_train(path,trainImageNameList, newSize, trainClassType, energy)
%pca_train(path,trainImageNameList, newSize, trainClassType, energy)
%���ܣ�����ѵ�����������㲢����classType,newSize,originSize��ƽ��������������ͶӰ����,��pca_data.mat
%���룺
% path��ѵ������·��
% trainImageNameList��ѵ��ͼ�������б�Ԫ�����飩
% newSize���������ͼ��߶�
% trainClassType��ѵ�����������(������)
% energy��������
%�����
%����pca_data.mat����ǰĿ¼

save('pca_data.mat','trainClassType');
fprintf('����trainClassType��pca_data.mat�ɹ���\n');
save('pca_data.mat','newSize','-append');
fprintf('����newSize��pca_data.mat�ɹ���\n');

%step1:�����Ӻ���������ѵ��������������,��ƽ����
[trainSamples, trainSamplesMean, trainNum, ~, originSize]=arrDataMat(path, trainImageNameList, newSize);
trainMeanFace = reshape(trainSamplesMean',newSize(1),newSize(2));
save('pca_data.mat','trainSamplesMean','-append');
fprintf('����trainSamplesMean��pca_data.mat�ɹ���\n');
save('pca_data.mat','originSize','-append');
fprintf('����originSize��pca_data.mat�ɹ���\n');
figure;
% trainMeanFace = imresize(trainMeanFace, originSize);
imshow(trainMeanFace); %��ʾƽ����
title('Mean face of the training samples');
%step2����Э�����������ֵ��������������������λ������ͶӰ����
%��������Э������󣬲�������ֵ����������,ȷ��������ά��,��ͶӰ����
%��ֱ����a'a������ֵ�������������ǲ���SVD�ķ���������aa'������ֵ������������a'a������ֵ������
trainZeroMeanSamples=trainSamples-repmat(trainSamplesMean,trainNum,1);%�������ֵ����������
cov = trainZeroMeanSamples*trainZeroMeanSamples';%��Э�������
[v, d] = eig(cov);
lamna = diag(d);
[D, indx] = sort(lamna,1,'descend');%������ֵ��������
rankV = v(:,indx);%��������������
t = 0;
tt = sum(D);
for i=1:trainNum %ѡ���ۻ�����ռ%99����ֵ
    t = t + D(i);
    ratio = t/tt;
    if(ratio>=energy)
        break;
    end
end
T_len=i;%ѡ������ֵ�ĸ���
T2 = rankV(:,1:i);%ѡ����������
D2 = D(1:i);%ѡ������ֵ
T3 = simitzj(T2,D2); %���������Ĺ�һ����������
%��a'a������ֵ��������,��ԭΪԭʼЭ�������������
L = repmat((1./sqrt(D2))',trainNum,1);
T=trainZeroMeanSamples'*(T3.*L);%ͶӰ����
% Data{4} = T;
save('pca_data.mat','T','-append');
fprintf('����ͶӰ����T��pca_data.mat�ɹ���\n');
D = D2;
save('pca_data.mat', 'D', '-append');
fprintf('��������ֵD��pca_data.mat�ɹ���\n');

%step3����ѵ��������������
trainNew = trainZeroMeanSamples*T; %��ѵ������������
% Data{5} = trainNew;
% save('Data.mat','Data');
% disp('���ݱ���ɹ���');
save('pca_data.mat','trainNew','-append');
fprintf('����trainNew��pca_data.mat�ɹ���\n');
end
