# data from UW epidemic as described in H1N1 paper with ES 

library(plyr)
library(MASS)
library(smfsb)
library(ramcmc) 
library(SDSMCMC)
source("SdsMCMC.R")

d=readRDS(file = "wsu.rds")
d=as.data.frame(d[-(105:110),])

T.max=104; # cut-off time point 
n1=10000; # initial number of susceptible 
burn = 100; #  burning period
thin =10; # tinning period 
nrepeat = 1000; # number of posterior sample;  
sim.num= burn + nrepeat * thin; # total number of simulation 

# The input data only has daily number new infection. 
# init.data function generate infection period using exponential distribution;
# Input argument: 
#   d: input ata 
#   n1: initial number of susceptible
#   la: mean of infection period  
init.data <- function(d, n1, la = 5){
        n=length(d[,1])
        d[n,1]=n1; d[1,2]  # 18234
        tot=sum(d[,1])
        d=d[,1]
        dd=NULL
        set.seed(1124)
        for (i in 1:n) {
                if (i==1) x=rep(0,d[i]) else x=sort(runif(d[i]));
                y=rexp(d[i],1/la)
                dd=rbind(dd,cbind(pmin(i-1+x,n-1),i-1+x+y))
        }
        return(dd)
}
pop.data = init.data(d,n1)

sds <- SDS.Likelihood.withN.MCMC(data = pop.data, Tmax=T.max, nrepeat = sim.num, tun=c(0.1,0.1,0.1,5000), 
                                   prior.a=c(0.001,0.001,0.001,0.001), prior.b=c(0.001,0.001,0.001,0.001), ic = c(0.25, 0.2, 0.01))

selrow = burn+seq(0,by=thin,length.out = nrepeat)
summary(sds[selrow, ]) 
apply(sds[selrow, ],2, quantile,probs = c(0.025, 0.975))

plot(sds[,1],type="l")
plot(sds[,2],type="l")
plot(sds[,3],type="l")
plot(sds[,4],type="l")
