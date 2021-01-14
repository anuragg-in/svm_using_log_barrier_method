function f = objective(lambda)
    global t;
    [xt,yt] = getData();
    siz = size(xt);
    numData = siz(1);
    dimData = siz(2);
    
%     lambda
%     lambda(1:dimData).'*lambda(1:dimData)
    C = 1; % Regularization parameter
    sum = 0;
    sum1 = 0;
    for i=1:numData
        sum = sum + log(yt(i)*(lambda(1:dimData).'*xt(i,:).'+lambda(dimData+1))-1+lambda(dimData+1+i)) + log(lambda(dimData+1+i));
        sum1 = sum1 + lambda(dimData+1+i);
    end
    sum = sum/t;
    sum1 = sum1*C;
    f=lambda(1:dimData).'*lambda(1:dimData) - sum + sum1;
end

