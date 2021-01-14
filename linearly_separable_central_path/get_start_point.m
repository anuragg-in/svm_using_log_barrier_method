function [x] = get_start_point()
    [xt,yt] = getData();
    siz = size(xt);
    numData = siz(1);
    dimData = siz(2);
    A=[];
    b=[];
    for i=1:numData
        A =[A;-yt(i)*xt(i,:), -yt(i), 1];
        b = [b;-1];
    end
%     A
%     b
    Aeq=[];
    beq=[];
%     lb=[-2*ones(dimData+2,1)];
    lb=[-inf*ones(dimData+1,1);-2];
    ub=[];
    x=fmincon(@(x)x(dimData+2),zeros(dimData+2,1),A,b,Aeq,beq,lb,ub);
end