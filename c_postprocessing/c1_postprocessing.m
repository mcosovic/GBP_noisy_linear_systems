 function  [wls, bp] = c1_postprocessing(data, wls, bp, user)
  
 

%-----------------------------Spectral Radius------------------------------
 if user.radius == 1
    [bp] = c1_spectral_rad(user, bp);
 end
%-------------------------------------------------------------------------- 


%-----------------------State Estimation Evaluation------------------------
 if user.error == 1
    [wls, bp] = c2_evaluation(data, wls, bp);
 end    
%--------------------------------------------------------------------------


%---------------------------------Display----------------------------------
 d1_disp(bp, wls, user);
%--------------------------------------------------------------------------