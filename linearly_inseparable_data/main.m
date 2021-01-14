clear all; clc;
global t;
t = 0.2; % log barrier function scaling parameter

%% fetching data
[xt, yt] = getData();
siz = size(xt);
numData = siz(1);
dimData = siz(2);

%% feasible start point for optimization
x0 = get_start_point();
disp("---------Feasible start point optimization result (w; b; s_min)-----------");
disp(x0);


x0copy=x0;
x0=x0(1:dimData+1);
% x0=[-1.3574;5.1205;1.8035];
% x0=[-1.0024;5.1205;1.8035];
x0 = [x0; (max(x0copy(dimData+2)*-1+1,1))*ones(numData,1)];
disp("---------Feasible start point (w; b)-----------");
disp(x0);


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

%% solving optimization problem
index=1;
markerType=['-black' '-black' '-black'];
for t=[0.2,1,10,100]
    options = optimoptions(@fminunc,'Algorithm','quasi-newton');
    [x,fval,exitflag,output] = fminunc(@objective,x0,options);
    x0=x;
    %% plotting separating hyperplane
    margin = 0.4;
    xMin = min(xt(:,1))-margin;
    xMax = max(xt(:,1))+margin;
    yMin = -(xMin*x(1)+x(3))/x(2);
    yMax = -(xMax*x(1)+x(3))/x(2);
    if(index==1)
        marker = ':black';
    elseif(index==2)
        marker = '-.black';
    elseif(index==3)
        marker = '--black';
    else
        marker = '-black';
    end
%     if(index == 4)
        p(index)=plot([xMin, xMax],[yMin, yMax],marker,'DisplayName', 't = '+string(t));
%     end
    index=index+1;
end
% legend(p(:),'Location','northwest');
set(gca,'FontSize',14)
set(findall(gca, 'Type', 'Line'),'LineWidth',1);
xlim([xMin, xMax]);
ylim([min(xt(:,2))-margin, max(xt(:,2))+margin]);

% print(fig,'images/linearly_inseparable_dataset_t_100_central_path','-dpng');
print(fig, 'images/separating_hyperplane_linearly_inseparable_data_log_barrier_method_multiple_t','-dpng');