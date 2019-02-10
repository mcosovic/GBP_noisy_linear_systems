 function [bp] = a3_local_factor(data, user, bp)



%------------------Position of Directed Factor Nodes-----------------------
 bp.Inc     = data.A ~= 0;
 bp.idx_dir = sum(bp.Inc, 2) == 1;
 
 Ndir = sum(bp.idx_dir); 
%--------------------------------------------------------------------------


%----------------------Scale Directed Factor Nodes-------------------------
 Cdir = sum(data.A(bp.idx_dir, :), 2);

 zdir = data.b(bp.idx_dir) ./ Cdir;
 vdir = data.v(bp.idx_dir) ./ (Cdir.^2);
%--------------------------------------------------------------------------


%------------------Merge Multiple Directed Factor Nodes--------------------
 Adir = bp.Inc(bp.idx_dir, :);
 idx = find(sum(Adir));

 vi = spdiags(1 ./ vdir, 0, Ndir, Ndir) * Adir;
 m  = spdiags(zdir, 0, Ndir, Ndir) * Adir;

 vdiri   = sum(vi);
 bp.vdir = (1 ./ vdiri(idx))';
 
 msum    = sum(m .* vi); 
 bp.zdir = (msum(idx)' .* bp.vdir);

 bp.Ndir = length(bp.vdir);
 bp.Adir = sparse((1:bp.Ndir)', idx, 1, bp.Ndir, bp.Nvar);
%--------------------------------------------------------------------------


%--------------------------Local Factor Nodes------------------------------ 
 [~, col] = find(bp.Adir);

 bp.zloc = user.mean * ones(bp.Nvar,1);
 bp.vloc = user.vari * ones(bp.Nvar, 1);
 
 bp.zloc(col) = bp.zdir; 
 bp.vloc(col) = bp.vdir;
 
 bp.Nloc = length(bp.zloc);
%-------------------------------------------------------------------------- 