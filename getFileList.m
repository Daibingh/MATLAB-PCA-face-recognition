function fileList=getFileList(path)
% fileList=getFileList(path)
%����:
%path������ȡ���ļ��б��·��
%�����
%fileList��path·�����ļ��б�cell����
list=dir(path);
n=size(list,1);
fileList=cell(n-2,1);
k=1;
for i=1:n
    if strcmp(list(i).name,'.') || strcmp(list(i).name, '..')
        continue;
    end
    fileList{k}=list(i).name;
    k=k+1;
end
end