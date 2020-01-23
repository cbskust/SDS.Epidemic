# SDS.Epidemic
In this paper, we show that solutions to ordinary differential equations describing the large-population limits of Markovian stochastic epidemic models can be interpreted as survival or cumulative hazard functions when analysing data on individuals sampled from the population. We refer to the individual-level survival and hazard functions derived from population-level equations as a survival dynamical system (SDS). To illustrate how population-level dynamics imply probability laws for individual-level infection and recovery times that can be used for statistical inference, we show numerical examples based on 
data maximum-likelihood analysis. 

In this repository, we provide the necessary toolkit for a statistical inference method based on the SDS interpretation of the compartmental susceptible-infected-recovered (SIR) epidemic model due to Kermack and McKendrick for the papaer on http://dx.doi.org/10.1098/rsfs.2019.0048.

We provide 8 R scripts.

Sellke.R:  This function generate synthetic epidemic data using Sellke construciotn  in Algorithm 3.1. 

SellkeToTrajectory.R:  This function converts epidemic data wih infection and removed time to SIR trajectory data with S(t), I(t), and R(t) at discrete time t

SirMle.R: This function calculates MLE using SIR empidemic data.

GillespieMCMC.R: This function generates posterior samples of beta, gamma, and rho using MCMC based on Examce likelihood in subsection 4.1.

GaussianMCMC.R: This function generates posterior samples of beta, gamma, and rho using MCMC based on Gaussian likelihood in subsection A.2.

SdsMCMC.R: These functions are to draw posterior samples using MCMC for SDS likelihood in subsection 4.2 and Algorithm 5.1.

Example.R: This file provides examples using R codes to generate synthetic epidemic data and to estimate parameters accoriding to estimation methods described in the paper. 

WS_data_MCMC_NB.R: R code of MCMC simulation for H1N1 pandemic data at Washington State University 
data1.csv: Daily count data of H1N1 pandemic at Washington State University 
