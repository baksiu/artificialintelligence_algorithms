function [ indiciesVec ] = DEbest( testSwarm, funfun, iteration )

    fun = funfun;

    for i=1:size(testSwarm,1)
        
        evaluateMatrix(i) = fun(testSwarm(i,:));
        
    end
    
    [Y, I] = min(evaluateMatrix);
    
    indiciesVec(1) = I;
    indiciesVec(2) = randi(size(testSwarm,1),1,1);
    indiciesVec(3) = randi(size(testSwarm,1),1,1);


end

