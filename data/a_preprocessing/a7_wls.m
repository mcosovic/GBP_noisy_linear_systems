 function [wls] = a7_wls(data, bp)
  

 
%-----------------Vector of Estimated State Variable-----------------------
 tic
 
 C = spdiags(data.v, 0, bp.Nfac, bp.Nfac);
 E = speye(bp.Nfac, bp.Nfac);
 W = C.^(1/2) \ E;

 Hti = W * data.A;                                                     
 rti = W * data.b;     

 [Q,R,P] = qr(Hti);                                                         
 r       = sprank(Hti);                                                       
 Qn      = Q(:,1:r);                                                           
 U       = R(1:r,1:r);    

 wls.x = full(P * [U \ (Qn' * rti); sparse(bp.Nvar - r, 1)]); 

 wls.time = toc; 
%--------------------------------------------------------------------------
