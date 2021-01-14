function f = objective(lambda)
    global t;
    [xt,yt] = getData();
    siz = size(xt);
    numData = siz(1);
    dimData = siz(2);
    
%     lambda
%     lambda(1:dimData).'*lambda(1:dimData)
    
    sum = 0;
    for i=1:numData
        sum = sum + log(yt(i)*(lambda(1:dimData).'*xt(i,:).'+lambda(dimData+1))-1);
    end
    sum = sum/t;
    f=lambda(1:dimData).'*lambda(1:dimData)-sum;
end

