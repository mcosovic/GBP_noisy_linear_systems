 function [wls, bp] = c2_valuation(data, wls, bp)

 
 
%--------------------State Estimation WLS Evaluation-----------------------
 f = data.A * wls.x; 
 
 wls.mae  = sum(abs(data.b - f)) / bp.Nfac; 
 wls.rmse = ((sum(data.b - f).^2) / bp.Nfac)^(1/2);    
 wls.wrss = sum(((data.b - f).^2) ./ data.v);
%--------------------------------------------------------------------------
 

%-------------------State Estimation BP Evaluation-------------------------
 f = data.A * bp.mean;
 
 bp.mae  = sum(abs(data.b - f)) / bp.Nfac; 
 bp.rmse = ((sum(data.b - f).^2) / bp.Nfac)^(1/2);    
 bp.wrss = sum(((data.b - f).^2) ./ data.v);
%-------------------------------------------------------------------------- 


