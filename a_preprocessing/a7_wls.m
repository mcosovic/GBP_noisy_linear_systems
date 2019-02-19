 function [wls] = a7_wls(data, bp)
  


%------------------------Force QR Decomposition ---------------------------
 warning('off')
 lastwarn('');
 
 tic
 C = spdiags(data.v, 0, bp.Nfac, bp.Nfac);
 E = speye(bp.Nfac, bp.Nfac);
 W = C.^(1/2) \ E;
 
 Hti = W * data.A;                                                     
 rti = W * data.b;
 pre = toc;

 tic
 if issparse(Hti)
    R = qr(Hti); 
 else
    R = triu(qr(Hti)); 
 end
 x   = R \ (R' \ (Hti' * rti));
 r   = rti - Hti * x;
 err = R \ (R' \ (Hti' * r));
 
 wls.x_qr = x + err;
 
 [wls.war_qr] = lastwarn;
 wls.time_qr  = toc + pre; 
%--------------------------------------------------------------------------


%----------------------------Matlab mldivide-------------------------------
 lastwarn('');
 
 tic
 wls.x_ml = (Hti' * Hti) \ (Hti' * rti);

 [wls.war_ml] = lastwarn;
 wls.time_ml  = toc + pre;
 
 warning('on')
%-------------------------------------------------------------------------- 