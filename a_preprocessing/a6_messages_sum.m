 function [bp] = a6_messages_sum(bp)
    
 
 
%-----------------------------Initialization-------------------------------
 [bp.row, bp.col] = find(bp.Aind);
 
 A  = sparse(bp.Nind, bp.Nvar);
 ms = (1:bp.Nmsg)';
%-------------------------------------------------------------------------- 
 

%-----------------------Mask Row Messages Summation------------------------
 A(bp.idx) = ms;
 Ap = A(bp.row,:);
 
 id = sparse(ms, bp.col, true, bp.Nmsg, bp.Nvar);
 Ap(id) = 0;

 [row, ~, col] = find(Ap);
 bp.row_sum    = sparse(row, col, 1, bp.Nmsg, bp.Nmsg);
%--------------------------------------------------------------------------


%---------------------Mask Column Messages Summation-----------------------
 A  = A';
 Ap = A(bp.col,:);

 id = sparse(ms, bp.row, true, bp.Nmsg, bp.Nind);
 Ap(id) = 0;

 [row, ~, col] = find(Ap);
 bp.col_sum    = sparse(row, col, 1, bp.Nmsg, bp.Nmsg);
%--------------------------------------------------------------------------


%------------------------Expand Local Factor Nodes-------------------------
 C = 1 ./ bp.vloc;
 bp.Lv_fv = C(bp.col);
 
 Lm_fv = bp.zloc .* C;
 bp.Lm_fv = Lm_fv(bp.col);
 
 bp.pre_time = toc;
%--------------------------------------------------------------------------