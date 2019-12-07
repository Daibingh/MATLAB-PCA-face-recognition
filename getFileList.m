function fileList=getFileList(path)
% fileList=getFileList(path)
%输入:
%path：所获取的文件列表的路径
%输出：
%fileList：path路径下文件列表，cell数组
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