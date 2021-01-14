clear all; clc;
% t = 10; % log barrier function scaling parameter

%% fetching data
[xt, yt] = getData();
siz = size(xt);
numData = siz(1);
dimData = siz(2);

%% feasible start point for optimization
x0 = get_start_point();
disp("---------Feasible start point optimization result (w; b; s_min)-----------");
disp(x0);


x0=x0(1:dimData+1);
% x0=[-1.3574;5.1205;1.8035];
% x0=[-1.0024;5.1205;1.8035];
disp("---------Feasible start point (w; b)-----------");
disp(x0);

options = optimoptions(@fminunc,'Algorithm','quasi-newton');
[x,fval,exitflag,output] = fminunc(@objective,x0,options);
x

%% plotting training data for 2d case
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

%% plotting separating hyperplane
margin = 0.4;
xMin = min(xt(:,1))-margin;
xMax = max(xt(:,1))+margin;
yMin = -(xMin*x(1)+x(3))/x(2);
yMax = -(xMax*x(1)+x(3))/x(2);
plot([xMin, xMax],[yMin, yMax],'black');

set(gca,'FontSize',14)
set(findall(gca, 'Type', 'Line'),'LineWidth',1);
xlim([xMin, xMax]);
ylim([min(xt(:,2))-margin, max(xt(:,2))+margin]);

print(fig, 'images/separating_hyperplane_linearly_separable_data_log_barrier_method_t_1','-dpng');