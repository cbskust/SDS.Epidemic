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

#initial parameter setting
k1 = 1.5; k2 = 1.0 ; k3 = 0.05; n1=1000; n2=100;T.max = 3; sim.num = 5000;

#generating synthetic epidemic data using Sellke construction
pop.data = Sellke(n=n2, rho=k3, beta=k1, gamma=k2, Tmax = T.max)

#converting Sellke epidemic data to SIR trajectory
emp.sir <- Sellke.to.trajectory(pop.data, Tmax = T.max)

# MLE using Mehtod 1
MLE <- SIR.MLE(emp.sir)

# MCMC using Method 2
gillespie <- Gillespie.Likelihood.MCMC(emp.sir, nrepeat=sim.num, prior.a=c(0.001,0.001), prior.b=c(0.001,0.001)) 
summary(gillespie)
plot(gillespie[,1],type="l")
plot(gillespie[,2],type="l")

#MCMC using Method 3
sds <- SDS.Likelihood.MCMC(data = pop.data, Tmax=T.max, nrepeat = sim.num, tun=c(0.1,0.1,0.1), 
                           prior.a=c(0.001,0.001,0.05*0.1), prior.b=c(0.001,0.001,0.1), ic = c(1.5, 1, 0.05))
summary(sds)
plot(sds[,1],type="l")
plot(sds[,2],type="l")
plot(sds[,3],type="l")

#MCMC using Method 4
gaussian <- Gaussian.MCMC(emp.sir, nrepeat=sim.num, ic = c(1, 1, 0.1), tun=c(0.1,0.1,1), prior.a=c(0.001,0.001,0.05*0.1)
                          , prior.b=c(0.001,0.001,0.1), Tmax = T.max)
summary(gaussian)
plot(gaussian[,1],type="l")
plot(gaussian[,2],type="l")
plot(gaussian[,3],type="l")

