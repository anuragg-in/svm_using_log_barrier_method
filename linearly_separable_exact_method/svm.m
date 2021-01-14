clear all; clc;

%% fetching data
[xt, yt] = getData();
siz = size(xt);
numData = siz(1);
dimData = siz(2);

objective = @(x)x(1:dimData).'*x(1:dimData);
A=[];
b=[];
for i=1:numData
    A=[A;-yt(i)*xt(i,:) -yt(i)];
    b=[b;-1];
end
x0=get_start_point();
x0=x0(1:dimData+1);

x = fmincon(objective,x0,A,b);
x

fig = figure;
hold off;
msize=14;
for i = 1:numData
    if(yt(i)==1)
        plot(xt(i,1),xt(i,2),'xblack','MarkerSize',msize);
    else
        plot(xt(i,1),xt(i,2),'oblack','MarkerSize',msize);
    end
    hold on;
end

index=1;
%% plotting separating hyperplane
margin = 0.4;
xMin = min(xt(:,1))-margin;
xMax = max(xt(:,1))+margin;
yMin = -(xMin*x(1)+x(3))/x(2);
yMax = -(xMax*x(1)+x(3))/x(2);
if(index==1)
    marker = '-black';
elseif(index==2)
    marker = '--black';
else
    marker = '-black';
end
p(index)=plot([xMin, xMax],[yMin, yMax],marker);
index=index+1;
set(gca,'FontSize',14)
set(findall(gca, 'Type', 'Line'),'LineWidth',1);
xlim([xMin, xMax]);
ylim([min(xt(:,2))-margin, max(xt(:,2))+margin]);

print(fig, 'images/svm_linearly_separable_exact_method','-dpng');