# SDS.Epidemic
In this paper, we show that solutions to ordinary differential equations describing the large-population limits of Markovian stochastic epidemic models can be interpreted as survival or cumulative hazard functions when analysing data on individuals sampled from the population. We refer to the individual-level survival and hazard functions derived from population-level equations as a survival dynamical system (SDS). To illustrate how population-level dynamics imply probability laws for individual-level infection and recovery times that can be used for statistical inference, we show numerical examples based on 
data maximum-likelihood analysis. 

In this repository, we provide the necessary toolkit for a statistical inference method based on the SDS interpretation of the compartmental susceptible-infected-recovered (SIR) epidemic model due to Kermack and McKendrick for the paper on http://dx.doi.org/10.1098/rsfs.2019.0048.

We provide a R package and three example R codes. In order to use the pacakge, a user need to download "SDSMCMC_0.1.0.tar.gz" and install SDSMCMC R pakcage in your local machine. 

Description for mainly used functions in the SDSMCMC package  

Sellke():  This function generate synthetic epidemic data using Sellke construciotn  in Algorithm 3.1. 

SellkeToTrajectory():  This function converts epidemic data wih infection and removed time to SIR trajectory data with S(t), I(t), and R(t) at discrete time t

SirMle(): This function calculates MLE using SIR empidemic data.

GillespieMCMC(): This function generates posterior samples of beta, gamma, and rho using MCMC based on Examce likelihood in subsection 4.1.

GaussianMCMC(): This function generates posterior samples of beta, gamma, and rho using MCMC based on Gaussian likelihood in subsection A.2.

SdsMCMC(): This function conducts MCMC simuation using SDS likelihood in subsection 4.2 and Algorithm 5.1 and generate posterior samples of parameters from their posterior distribution.

result(): This function produce a summary statistics table of posterior samples and fugures for MCMC diagnostics. 


Description for example files 
Example1.R: This file provides examples using R codes to estimate WSU H1N1 daeta using MCMC for SDS likelhood. This example used "WSU.csv" data file. 

Example2.R : This file provides examples using R codes to estimate synthetic epidemic data with Sellke construction to utilize MCMC for SDS likelhood.

Example3.R : This file provides examples using R codes to estimate synthetic epidemic data with Sellke construction to utilize maximum likelihood and MCMC for Doob Gillespie method. 

WSU.csv: example data of H1N1 pandemic data from WSU. The original data only has daily counts of new infection. We modifed it to use SDS method. 
