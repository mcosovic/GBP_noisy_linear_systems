 function [bp] = a2_num_var_fac(data)
    

 
%------------------Number of Variables and Factor Nodes--------------------
 tic
 [bp.Nfac, bp.Nvar] = size(data.A);
%--------------------------------------------------------------------------