clc; clear all; close all;

x=-15.5:0.25:15.5;
y=-15.5:0.25:15.5;
[X, Y] = meshgrid (x,y);

fun = @rosen

gbest(1:3) = Inf;
maxIt=30;
gbestchart = zeros(1,maxIt);
c1 = 1.5;
c2 = 2;
%wagabezw = ??

swarmsize=10;
initSwarm = zeros(swarmsize,6);

for i=1:swarmsize
    initSwarm(i,1) = X(randi(length(x),1),randi(length(x),1));
    initSwarm(i,2) = X(randi(length(x),1),randi(length(x),1));
    initSwarm(i,3) = initSwarm(i,1);
    initSwarm(i,4) = initSwarm(i,2);
    initSwarm(i,5) = 0.1;
    initSwarm(i,6) = 0.1;
    if (fun([initSwarm(i,3),initSwarm(i,4)]) < gbest(3))
        gbest(1) = initSwarm(i,1);
        gbest(2) = initSwarm(i,2);
        gbest(3) = fun([initSwarm(i,3),initSwarm(i,4)]);
    end
end

minIt = 1;
testSwarm = initSwarm;

while (minIt < maxIt)

    for i=1:swarmsize
    
        testSwarm(i,5) = 0.1 + c1*rand * (testSwarm(i,3) - testSwarm(i,1)) + c2*rand * (gbest(1) - testSwarm(i,1));
        testSwarm(i,6) = 0.1 + c1*rand * (testSwarm(i,4) - testSwarm(i,2)) + c2*rand * (gbest(1) - testSwarm(i,2));
        testSwarm(i,1) = testSwarm(i,1) +  testSwarm(i,5);
        testSwarm(i,2) = testSwarm(i,2) +  testSwarm(i,6);

        if (fun([testSwarm(i,1),testSwarm(i,2)]) < fun([testSwarm(i,3),testSwarm(i,4)]))
            testSwarm(i,3) = testSwarm(i,1);
            testSwarm(i,4) = testSwarm(i,2);
        end

        if (fun([testSwarm(i,3),testSwarm(i,4)]) < gbest(3))
           % gbest
           % minIt
            gbest(1) = testSwarm(i,3);
            gbest(2) = testSwarm(i,4);
            gbest(3) = fun([testSwarm(i,3),testSwarm(i,4)]);
        end    
    end
    gbestchart(1,minIt) = gbest(3);
    minIt = minIt + 1;
end
gbest

funchart = zeros(length(X),length(X));
for a=1:length(X)
    for b=1:length(X)
        funchart(a,b) = fun([X(a,b),Y(a,b)]);
    end
end

figure();
hold off
surf(X,Y,funchart);
hold on

for i=1:length(testSwarm(:,3))
    swarmpos(i) = fun([testSwarm(i,3),testSwarm(i,4)]);
end
plot3(testSwarm(:,3), testSwarm(:,4), swarmpos,'ko','MarkerSize',10,'MarkerFaceColor','r');
hold off

figure();
hold on
gbestdim = 1:maxIt;
plot(gbestdim,gbestchart);
xlabel('iteracja');
ylabel('gbest');