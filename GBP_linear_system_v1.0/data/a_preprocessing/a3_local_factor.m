 function [bp] = a3_local_factor(data, user, bp)



%-------------------------Directed Factor Nodes---------------------------- 
 bp.Inc = data.A ~= 0;
 
 bp.idx_dir = sum(bp.Inc, 2) == 1;
 bp.Adir    = bp.Inc(bp.idx_dir, :);

 bp.zdir = data.b(bp.idx_dir);
 bp.vdir = data.v(bp.idx_dir);
 
 bp.Ndir = sum(bp.idx_dir); 
%-------------------------------------------------------------------------- 


%-----------------------Scale Directed Factor Nodes------------------------
 Cdir = nonzeros(data.A(bp.idx_dir, :));
 
 bp.zdir = bp.zdir ./ Cdir;
 bp.vdir = bp.vdir ./ (Cdir.^2);
%--------------------------------------------------------------------------


%--------------------------Local Factor Nodes------------------------------ 
 [~, col] = find(bp.Adir);

 bp.zloc = user.mean * ones(bp.Nvar,1);
 bp.vloc = user.vari * ones(bp.Nvar, 1);
 
 bp.zloc(col) = bp.zdir; 
 bp.vloc(col) = bp.vdir;
 
 bp.Nloc = length(bp.zloc);
%-------------------------------------------------------------------------- 


