%子函数，进行施密特正交化，对实对称矩阵的特征向量求正交矩阵
function vv = simitzj(v, d)
%vv = simitzj(v, d)
%功能：对输入的实对称的特征值，特征向量施密特正交化，单位化
%输入：
%v：特征向量
%d：特征值
%输出：
%vv：正交化单位化后的特征向量
ii=1;
k=0;
nn=length(d);
vv=zeros(size(v));
while ii<=nn
    jj=ii-k;
    b=0;
    while jj<ii
        b=b+dot(vv(:,jj),v(:,ii))/dot(vv(:,jj),vv(:,jj))*vv(:,jj);
        jj=jj+1;
    end
    vv(:,ii)=v(:,ii)-b;
    ii=ii+1;
    if ii<=nn && d(ii)==d(ii-1)
        k=k+1;
    else
        k=0;
    end
end
for ii=1:nn
    vv(:,ii)=vv(:,ii)/sqrt(dot(vv(:,ii),vv(:,ii)));
end
end