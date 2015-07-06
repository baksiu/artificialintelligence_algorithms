function [ indiciesVec ] = DEcurrent(testSwarm, funfun, iteration)

    indiciesVec(1) = iteration;
    indiciesVec(2) = randi(size(testSwarm,1),1,1);
    indiciesVec(3) = randi(size(testSwarm,1),1,1);

end

