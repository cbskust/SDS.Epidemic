# data from UW epidemic as described in H1N1 paper with ES 

library(plyr)
library(MASS)
library(smfsb)
library(ramcmc) 

source("GaussianMCMC.R")
source("GillespieMCMC.R")
source("SdsMCMC.R")
source("Sellke.R")
source("SellkeToTrajecotory.R")
source("SirMle.R")
source("sir_ode.R")
par(mfrow=c(2,2))
T.max=104;
sim.num=2000;
n1=4000 # second sample
#n2= # Sellkie sample 

d=read.csv('Data1.csv')
d=d[-(105:110),]
n=length(d[,1])


init.data <- function(d, n1){
        n=length(d[,1])
        d[n,1]=n1; d[1,2]  # 18234
        tot=sum(d[,1])
        d=d[,1]
        la=5
        dd=NULL
        set.seed(1124)
        for (i in 1:n) {
                if (i==1) x=rep(0,d[i]) else x=sort(runif(d[i]));
                y=rexp(d[i],1/la)
                dd=rbind(dd,cbind(pmin(i-1+x,n-1),i-1+x+y))
        }
        return(dd)
}


nrepeat=100
n.gen=matrix(0,nrow=nrepeat,ncol=1)
exp.gen=matrix(0,nrow=nrepeat,ncol=1)

theta.gen=matrix(0,nrow=nrepeat,ncol=3)

n1=0;theta = c(0.25, 0.2, 0.01)
        


for (rep in 1:nrepeat) {
        pop.data = init.data(d,n1)
        n2 = length(pop.data[,1])
        samp.data <- pop.data[sort(sample.int(n2,min(n2,500))),]
        sds <- SDS.Likelihood.MCMC(data = samp.data, Tmax=T.max, nrepeat = sim.num, tun=c(0.1,0.1,0.1), 
                                   prior.a=c(0.001,0.001,0.001), prior.b=c(0.001,0.001,0.001), ic = theta)
        rho=mean(sds[-(1:1000),3])
        beta=mean(sds[-(1:1000),1])
        gamma=mean(sds[-(1:1000),2])
        theta=c(beta,gamma,rho)
        tau <- uniroot(function(x) 1 - x - exp(-(beta)/gamma *(x + rho)), c(0, 1))$root
        n1=rnbinom(1,mu=2276*(1-tau)/tau,size=2276)
        expt = ode.final.size.cnt(x0=n2,y0=n2*rho,ga=gamma,la=beta,k=50)[50]
        n.gen[rep,]=n1
        theta.gen[rep,]=theta
        exp.gen[rep,]=expt
        cat("iter: ",rep,', Epidemic_size: Model Predicted=',expt,', Observed=',sum(dd[,1]<T.max))
}

