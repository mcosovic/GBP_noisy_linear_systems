 clc
 clearvars

%--------------------------------------------------------------------------
% We observe a noisy linear system of equations with real coefficients and 
% variables:
%                           b = f(x) + u,
% where x is the vector of the state variables (i.e., unknowns), f(x) 
% is the vector of linear functions, b is the vector of observation
% values and u is the vector of uncorrelated observation errors. Note that 
% the linear system of equations represents an overdetermined system.
%
% The solution can be obtained by solving linear weighted least-squares
% (WLS) problem:
%                        (A'*W*A)x = A'*W*b
% where A is the Jacobian matrix of linear functions or the coefficient 
% matrix for our system, and W is a diagonal matrix containing inverses 
% of observation variances. 
%
% Further, the solution to the problem can be found via maximization of the
% likelihood function which is defined via likelihoods of independent 
% observations, and that can be efficiently solved utilizing factor
% graphs and the Gaussian belief propagation (BP) algorithm. 
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------   
% Input data: data.mat file with variables:
%    data.A - coefficient matrix m x n (m>n);
%    data.b - observation values column vector dimension of m x 1;
%    data.v - observation variances column vector dimension of m x 1;
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% User Options:
%
% Post-Processing Options:
%   user.radius - compute spectral radius for synchronous and randomized
%                 damping scheduling, if spectral radius is less than 1  
%                 the BP algorithm converges;
%   user.valuation - compute mean absolute error, root mean square error
%                    and weighted residual sum of squares for solution;
%
% Design of Iteration Scheme:
%   user.stop - the BP algorithm in the iteration loop is running until 
%               the criterion is reached, where the criterion is applied 
%               on the vector of mean-value messages from factor nodes to 
%               variable nodes in two consecutive iterations;
%   user.maxi - the upper limit on BP iterations;
%
% Convergence Parameters:
%   user.prob - a Bernoulli random variable with probability "prob" 
%               independently sampled for each mean value message from 
%               indirect factor node to a variable node, with values 
%               between 0 and 1;
%   user.alph - the damped message is evaluated as a linear combination of 
%               the message from the previous and the current iteration,
%               with weights "alph" and 1 - "alph", where "alph" is 
%               between 0 and 1;
% Note: We use an improved BP algorithm that applies synchronous scheduling 
% with randomized damping. The randomized damping parameter pairs lead to  
% a trade-off between the number of non-converging simulations and the rate  
% of convergence. In general, for the selection of "prob" and "alph" for  
% which only a small fraction of messages are combined with their values in 
% a previous iteration, and that is a case for "prob" close to 0 or "alph"  
% close to 1, we observe a large number of non-converging simulations.
%
% Virtual Factor Nodes
%   user.mean - the mean value of virtual factor nodes;
%   user.vari - the variance value of the virtual factor nodes;
% Note: The virtual factor node is a singly-connected factor node used 
% if the variable node xi is not directly observed. In a usual scenario, 
% without prior knowledge, the variance of virtual factor nodes tend to 
% infinity. 
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% More information about parameters: 
%  M. Cosovic and D. Vukobratovic, "Distributed Gauss-Newton Method for 
%  State Estimation Using Belief Propagation," in IEEE Transactions on 
%  Power Systems, vol. 34, no. 1, pp. 648-658, Jan. 2019.
%--------------------------------------------------------------------------


%------------------------------Load Data-----------------------------------
 addpath(genpath('data'))
 load('data29_14.mat')
%--------------------------------------------------------------------------
 

%-----------------------Post-processing Options----------------------------
 user.radius    = 1;
 user.valuation = 1;
%--------------------------------------------------------------------------
 

%-----------------------Design of Iteration Scheme-------------------------
 user.stop = 10^-12;
 user.maxi = 2000;
%--------------------------------------------------------------------------


%-----------------------Convergence Parameters-----------------------------
 user.prob = 0.6;
 user.alph = 0.5;
%--------------------------------------------------------------------------


%-----------------------Virtual Factor Nodes-------------------------------
 user.mean = 0;
 user.vari = 10^60;
%--------------------------------------------------------------------------


%---------------------------Main Functions---------------------------------
 [bp, wls] = a1_preprocessing(data, user);
 [bp]      = b1_belief_propagation(bp, user); 
 [wls, bp] = c1_postprocessing(wls, bp, user);
%--------------------------------------------------------------------------
