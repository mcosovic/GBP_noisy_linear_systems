 function [bp] = b1_belief_propagation(bp, user)
 


%------------------------Indirect Factor Nodes-----------------------------
 tic
 
 mind = spdiags(bp.zind, 0, bp.Nind, bp.Nind) * bp.Inc;
 vind = spdiags(bp.vind, 0, bp.Nind, bp.Nind) * bp.Inc;
 
 mind = full(mind(bp.idx));
 vind = full(vind(bp.idx));
%--------------------------------------------------------------------------

 
%-------------------Messages v -> f Initialization-------------------------
 m_vf = bp.Inc * spdiags(bp.zloc, 0, bp.Nvar, bp.Nvar);                                                 
 v_vf = bp.Inc * spdiags(bp.vloc, 0, bp.Nvar, bp.Nvar);
 
 m_vf = full(m_vf(bp.idx));
 v_vf = full(v_vf(bp.idx));
%--------------------------------------------------------------------------


%-----------------------Parameters Initialization-------------------------- 
 J  = full(bp.Aind(bp.idx));
 J2 = J.^2;
 
 m_fvp = m_vf;
 
 row_sum = sparse(bp.rowi, bp.rowe, 1, bp.Nmsg, bp.Nmsg);
 col_sum = sparse(bp.coli, bp.cole, 1, bp.Nmsg, bp.Nmsg);

 bp.pre_time = toc + bp.pre_time;
%-------------------------------------------------------------------------- 


%======================Belief Propagation Algorithm========================
 tic
 for k = 1:user.maxi

     
%------------Messages f -> v - from Indirected Factor Nodes----------------
 m_fv  = (mind - row_sum * (J .* m_vf)) ./ J;
 v_fvi = J2 ./ (vind + row_sum * (J2 .* v_vf)); 
%--------------------------------------------------------------------------

 
%---------------------------Convergence Fix--------------------------------
 [m_fv] = b2_converg_fix(k, m_fv, m_fvp, user.alph, bp.wow);
%-------------------------------------------------------------------------- 
 

%-----------------------------Stopping-------------------------------------
 if all(abs(m_fvp - m_fv) < user.stop) 
    break
 end
 m_fvp = m_fv;
%--------------------------------------------------------------------------


%-----------------Messages v -> f - to Indirected Nodes--------------------
 v_vf = 1 ./ (col_sum * v_fvi + bp.Lv_fv);
 m_vf = (col_sum * (m_fv .* v_fvi) + bp.Lm_fv) .* v_vf;
%--------------------------------------------------------------------------

 end
%==========================================================================


%---------------------------Iteration Time---------------------------------
 bp.iter_time = toc; 
%-------------------------------------------------------------------------- 


%------------------------------Marginals-----------------------------------
 tic

 sz = [bp.Nvar 1];

 varii = accumarray(bp.col, v_fvi, sz) + 1 ./ bp.vloc;
 cmv   = m_fv .* v_fvi;
 
 vari    = 1 ./ varii;
 bp.mean = (accumarray(bp.col, cmv, sz) + bp.zloc ./ bp.vloc) .* vari;
%--------------------------------------------------------------------------


%------------------------------Save Data-----------------------------------
 bp.v_fvi = v_fvi;
 bp.k     = k;
%--------------------------------------------------------------------------