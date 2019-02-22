 function [bp] = a6_messages_sum(bp)
    
 
 
%--------------------------Indirect Factor Nodes---------------------------
 [bp.row, bp.col] = find(bp.Aind);
%-------------------------------------------------------------------------- 
 

%-----------------------Mask Row Messages Summation------------------------
 dim = (1:bp.Nmsg)';
 
 A = bp.Aind;
 A(bp.idx) = dim;
 Ap = A(bp.row,:);
 
 [r1, c1] = size(Ap);
 id = sparse(dim, bp.col, true, r1, c1);
 Ap(id) = 0;

 [row, ~, col] = find(Ap);
 bp.row_sum    = sparse(row, col, 1, bp.Nmsg, bp.Nmsg);
%--------------------------------------------------------------------------


%---------------------Mask Column Messages Summation-----------------------
 A  = A';
 Ap = A(bp.col,:);

 [r1, c1] = size(Ap);
 id = sparse((1:bp.Nmsg)', bp.row, true, r1, c1);
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