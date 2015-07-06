clc; 
clear all; 
close all;

x=-15.5:0.25:15.5;
y=-15.5:0.25:15.5;
[X, Y] = meshgrid (x,y);

fun = @rosen
selectionMethod = @DEbest

funchart = zeros(length(X),length(X));
for a=1:length(X)
    for b=1:length(X)
        funchart(a,b) = fun([X(a,b),Y(a,b)]);
    end
end

figure();
hold off
surf(X,Y,funchart);
grid off
hold on

maxIt = 100;
minIt = 1;

F = 0.9;
Cr = 0.5;
Dim = 2;
Np = Dim * 10;

initPopulation = zeros(Np,Dim);

for i=1:Np
	for j=1:Dim
		initPopulation(i,j) = X(randi(length(x),1),randi(length(x),1));
	end
end


for i=1:length(initPopulation(:,1))
    posPopulation(i) = fun([initPopulation(i,:)]);
end

plot3(initPopulation(:,1), initPopulation(:,2), posPopulation,'y+','MarkerSize',10,'MarkerFaceColor','r');

hold on

testPopulation = initPopulation;
evalVec = zeros(1,length(testPopulation(:,1)));
bestSpecimen = zeros(1,maxIt);
 
while (minIt <= maxIt)

    for i=1:Np
        
        indiciesVec = selectionMethod(testPopulation,fun,i);
        newMutant = testPopulation(indiciesVec(1),:) + F * (testPopulation(indiciesVec(2),:) - testPopulation(indiciesVec(3),:));
        
        for j=1:Dim
            if rand < Cr
                newSpecimen(i,j) = newMutant(j);
            else
                newSpecimen(i,j) = testPopulation(i,j);
            end
        end
        
        if fun(newSpecimen(i,:)) < fun(testPopulation(i,:))
            testPopulation(i,:) = newSpecimen(i,:);
        end
  
    end
    for i=1:length(testPopulation(:,1))
        evalVec(i) = fun(testPopulation(i,:));
    end
    bestSpecimen(minIt) = min(evalVec);
    minIt = minIt + 1;
    Cr = Cr + 0.002;
end

for i=1:length(testPopulation(:,1))
    posPopulation(i) = fun([testPopulation(i,:)]); 
end

plot3(testPopulation(:,1), testPopulation(:,2), posPopulation,'ko','MarkerSize',10,'MarkerFaceColor','r');

hold off

min(bestSpecimen)
newMutant

figure
it = 1:maxIt;
comet(it,bestSpecimen);