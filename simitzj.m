%�Ӻ���������ʩ��������������ʵ�Գƾ����������������������
function vv = simitzj(v, d)
%vv = simitzj(v, d)
%���ܣ��������ʵ�ԳƵ�����ֵ����������ʩ��������������λ��
%���룺
%v����������
%d������ֵ
%�����
%vv����������λ�������������
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