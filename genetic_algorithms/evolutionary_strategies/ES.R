ackley <- function(xx, a=20, b=0.2, c=2*pi)
{
  d <- length(xx)
  
  sum1 <- sum(xx^2)
  sum2 <- sum(cos(c*xx))

  term1 <- -a * exp(-b*sqrt(sum1/d))
  term2 <- -exp(sum2/d)

  y <- term1 + term2 + a + exp(1)
  return(y)
}

easom <- function(xx)
{
  x1 <- xx[1]
  x2 <- xx[2]
	
  fact1 <- -cos(x1)*cos(x2)
  fact2 <- exp(-(x1-pi)^2-(x2-pi)^2)
	
  y <- fact1*fact2
  return(y)
}

rosen <- function(xx)
{
  d <- length(xx)
  xi <- xx[1:(d-1)]
  xnext <- xx[2:d]
	
  sum <- sum(100*(xnext-xi^2)^2 + (xi-1)^2)
	
  y <- sum
  return(y)
}

griewank <- function(xx)
{
  ii <- c(1:length(xx))
  sum <- sum(xx^2/4000)
  prod <- prod(cos(xx/sqrt(ii)))
		
  y <- sum - prod + 1
  return(y)
}

fitnessFunction <- rosen;

x <- seq(0.5,9.5,0.2);
y <- seq(0.5,9.5,0.2);

m <- length(x); 
lgh <- length(y);
X <- matrix(rep(x,each=lgh),nrow=lgh);
Y <- matrix(rep(y,m),nrow=lgh);

n <- 2;
mi <- 40; 
ro <- 4; 
iterations <- 100;

c <- 1;
tauInit <- c / sqrt(2*n);
initPopulation <- matrix(0,mi,n+1);

for(i in 1:mi)
{
	for(j in 1:n)
	{
		initPopulation[i,j] <- X[sample(length(x), 1),sample(length(x), 1)];
	}
	initPopulation[i,3] = easom(c(initPopulation[i,1], initPopulation[i,2]));
}

lambda <- 40;
P <- initPopulation;
T <- matrix(0,lambda,n+1);
O <- matrix(0,lambda,n+1);

chartMinimum.plus <- matrix(0,1,iterations);
chartMean.plus <- matrix(0,1,iterations);

for(i in 1:iterations)
{    
	for(j in 1:lambda)
	{
		T[j,] <- P[sample(mi,1),];
	}
   
    parentsPopulation <- matrix(0,ro,n+1);
	
	for(j in 1:lambda)
	{
      	for(k in 1:ro)
		{
           	parentsPopulation[k,] <- T[sample(lambda,1)];
        }
       	for(k in 1:n)
		{
           	O[j,k] <- mean(parentsPopulation[,k]);
       	}
        
       	O[j,1] <- O[j,1] + 0.9 * tauInit * rnorm(1,0,1);
       	O[j,2] <- O[j,2] + 0.9 * tauInit * rnorm(1,0,1);
        
       	O[j,n+1] <- easom(c(O[j,1], O[j,2]));
	}
   	OP <- rbind(O,P);
   	sortedOP <- OP[order(OP[,n+1]),];
   	P <- sortedOP[1:mi,];
        
   	chartMinimum.plus[i] <- min(P[,n+1]);
	chartMean.plus[i] <- mean(P[,n+1]);   
}

distanceMatrix.plus <- matrix(0,mi,mi);
distanceCount.plus <- 0;
distanceSum.plus <- 0;

for(i in 1:mi)
{
   	for(j in 1:mi)
	{
     	distanceMatrix.plus[i,j] <- sqrt((P[i,1]-P[j,1])^2 + (P[i,2]-P[j,2])^2 + (P[i,3]-P[j,3])^2);
       	if (distanceMatrix.plus[i,j] > 0)
		{
            distanceSum.plus <- distanceMatrix.plus[i,j];
           	distanceCount.plus <- distanceCount.plus + 1;
        }
   	}
}
distance.plus <- distanceSum.plus/distanceCount.plus;
finalPopulation.plus <- P;

#coma

P <- initPopulation;
T <- matrix(0,lambda,n+1);
O <- matrix(0,lambda,n+1);

chartMinimum.comma <- matrix(0,1,iterations);
chartMean.comma <- matrix(0,1,iterations);

for(i in 1:iterations)
{    
	for(j in 1:lambda)
	{
		T[j,] <- P[sample(mi,1),];
	}
   
    parentsPopulation <- matrix(0,ro,n+1);
	
	for(j in 1:lambda)
	{
      	for(k in 1:ro)
		{
           	parentsPopulation[k,] <- T[sample(lambda,1)];
        }
       	for(k in 1:n)
		{
           	O[j,k] <- mean(parentsPopulation[,k]);
       	}
        
       	O[j,1] <- O[j,1] + 1.0 * tauInit * rnorm(1,0,1);
       	O[j,2] <- O[j,2] + 1.0 * tauInit * rnorm(1,0,1);
        
       	O[j,n+1] <- easom(c(O[j,1], O[j,2]));
	}
	
   	sortedO <- O[order(O[,n+1]),];
   	P <- sortedO[1:mi,];
        
   	chartMinimum.comma[i] <- min(P[,n+1]);
	chartMean.comma[i] <- mean(P[,n+1]);   
}

distanceMatrix.comma <- matrix(0,mi,mi);
distanceCount.comma <- 0;
distanceSum.comma <- 0;

for(i in 1:mi)
{
   	for(j in 1:mi)
	{
     	distanceMatrix.comma[i,j] <- sqrt((P[i,1]-P[j,1])^2 + (P[i,2]-P[j,2])^2 + (P[i,3]-P[j,3])^2);
       	if (distanceMatrix.comma[i,j] > 0)
		{
            distanceSum.comma <- distanceMatrix.comma[i,j];
           	distanceCount.comma <- distanceCount.comma + 1;
        }
   	}
}
distance.comma <- distanceSum.comma/distanceCount.comma;
finalPopulation.comma <- P;

#OPO

P <- initPopulation;
T <- matrix(0,1,n+1);

chartMinimum.opo <- matrix(0,1,iterations);
chartMean.opo <- matrix(0,1,iterations);

for(i in 1:iterations)
{    
    for(j in 1:mi)
	{
        T <- P[j,];
        for(k in 1:n)
		{
			T[k] <- T[k] + 1.0 * tauInit * rnorm(1,0,1);
		}
		T[n+1] <- easom(c(T[1],T[2]));

		if(P[j,n+1] > T[n+1])
		{
			P[j,] <- T;
		}      
    }
    
    chartMinimum.opo[i] <- min(P[,n+1]);
    chartMean.opo[i] <- mean(P[,n+1]);      
}

distanceMatrix.opo <- matrix(0,mi,mi);
distanceCount.opo <- 0;
distanceSum.opo <- 0;

for(i in 1:mi)
{
   	for(j in 1:mi)
	{
     	distanceMatrix.opo[i,j] <- sqrt((P[i,1]-P[j,1])^2 + (P[i,2]-P[j,2])^2 + (P[i,3]-P[j,3])^2);
       	if (distanceMatrix.opo[i,j] > 0)
		{
            distanceSum.opo <- distanceMatrix.opo[i,j];
           	distanceCount.opo <- distanceCount.opo + 1;
        }
   	}
}
distance.opo <- distanceSum.opo/distanceCount.opo;
finalPopulation.opo <- P;

xplot <- 1:iterations;
par(mfrow=c(3,2))
plot(xplot,chartMinimum.plus,type = "l",col = "red",main = "Best population's specimen",xlab = "iteration",ylab = "fitness value");
plot(xplot,chartMean.plus,type = "l",col = "blue",main = "Mean population fitness",xlab = "iteration",ylab = "fitness value");
plot(xplot,chartMinimum.comma,type = "l",col = "red",main = "Best population's specimen",xlab = "iteration",ylab = "fitness value");
plot(xplot,chartMean.comma,type = "l",col = "blue",main = "Mean population fitness",xlab = "iteration",ylab = "fitness value");
plot(xplot,chartMinimum.opo,type = "l",col = "red",main = "Best population's specimen",xlab = "iteration",ylab = "fitness value");
plot(xplot,chartMean.opo,type = "l",col = "blue",main = "Mean population fitness",xlab = "iteration",ylab = "fitness value");

print(min(chartMinimum.plus));
print(min(chartMinimum.comma));
print(min(chartMinimum.opo));
print(distance.plus);
print(distance.comma);
print(distance.opo);
