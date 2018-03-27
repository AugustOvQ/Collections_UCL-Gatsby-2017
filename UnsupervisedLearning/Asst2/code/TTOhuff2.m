function [datatwo,pnew,h] = TTOhuff2(data)
%�����������Ž��й��������루�������ص�ȡֵ���ʣ�
%data��������ת����ʮ���Ƶ���������ͼ������
datanew = [];
p=[];
databaoliu=data;
while length(find(data~=-1)) >0
    xuhao = find(data~=-1);
    no = data(xuhao(1));
    datanew = [datanew no];
    p = [p length(find(data==no))];
    data(find(data==no))=-1;
end
p=p/length(data);

L=length(datanew);
pnew=[];
datatwo=[];

for i=1:L
    for j=1:L
        s=[datanew(i) datanew(j)]';
        datatwo=[datatwo s];
        pnew=[pnew p(i)*p(j)];
    end
end

pnew = [pnew 0];
q=pnew;
n=length(pnew);
a=zeros(n-1,n); %����һ��n-1 ��n �е�����
for i=1:n-1
[q,l]=sort(q); %�Ը�������q ���д�С��������򣬲�����l ���鷵��һ�����飬�������ʾ��������q ����ǰ��˳����
a(i,:)=[l(1:n-i+1),zeros(1,i-1)]; %������l ����һ�����󣬸þ���������ʺϲ�ʱ��˳�����ں���ı���
q=[q(1)+q(2),q(3:n),1]; %�������ĸ�������q ��ǰ�����������С���������Ӻͣ��õ��µ�һ���������
end
for i=1:n-1
c(i,1:n*n)=blanks(n*n); %����һ��n-1 ��n �У�����ÿ��Ԫ�صĵĳ���Ϊn �Ŀհ����飬c �������ڽ���huffman ���룬�����ڱ�������a ������һ���Ķ�Ӧ��ϵ
end
c(n-1,n)='0'; %����a ����ĵ�n-1 �е�ǰ����Ԫ��Ϊ����huffman ����Ӻ�����ʱ���õ���
c(n-1,2*n)='1'; %���������ʣ������ֵΪ0 ��1���ڱ���ʱ���n-1 �еĵ�һ���հ��ַ�Ϊ0���ڶ����հ��ַ�1��
for i=2:n-1
c(n-i,1:n-1)=c(n-i+1,n*(find(a(n-i+1,:)==1))-(n-2):n*(find(a(n-i+1,:)==1))); %����c �ĵ�n-i �ĵ�һ��Ԫ�ص�n-1 ���ַ���ֵΪ��Ӧ��a �����е�n-i+1 ����ֵΪ1 ��λ����c �����еı���ֵ
c(n-i,n)='0'; %����֮ǰ�Ĺ����ڷ�֧�ĵ�һ��Ԫ�����0
c(n-i,n+1:2*n-1)=c(n-i,1:n-1); %����c �ĵ�n-i �ĵڶ���Ԫ�ص�n-1 ���ַ����n-i �еĵ�һ��Ԫ�ص�ǰn-1 ��������ͬ����Ϊ����ڵ���ͬ
c(n-i,2*n)='1'; %����֮ǰ�Ĺ����ڷ�֧�ĵ�һ��Ԫ�����1
for j=1:i-1
    c(n-i,(j+1)*n+1:(j+2)*n)=c(n-i+1,n*(find(a(n-i+1,:)==j+1)-1)+1:n*find(a(n-i+1,:)==j+1));
%����c �е�n-i �е�j+1 �е�ֵ���ڶ�Ӧ��a �����е�n-i+1 ����ֵΪj+1 ��ǰ��һ��Ԫ�ص�λ����c �����еı���ֵ
end
end %���huffman ���ֵķ���
for i=1:n
h(i,1:n)=c(1,n*(find(a(1,:)==i)-1)+1:find(a(1,:)==i)*n); %��h ��ʾ����huffman ���룬����h�ĵ�i �е�Ԫ�ض�Ӧ�ھ���c �ĵ�һ�еĵ�i ��Ԫ��
ll(i)=length(find(abs(h(i,:))~=32)); %����ÿһ��huffman ����ĳ���
end
pnew=pnew(1:end-1);
ll=ll(1:end-1);
disp('��ά���ϻ���������ƽ���볤')
l=0.5*sum(pnew.*ll) %����ƽ���볤
disp('��Դ��')
hh=sum(p.*(-log2(p))) %������Դ��
disp('����Ч��')
t=hh/l %�������Ч��
end