 function [bp] = a3_local_factor(data, user, bp)



%--------------------------Directed Factor Nodes---------------------------
 bp.Inc     = data.A ~= 0;
 bp.idx_dir = sum(bp.Inc, 2) == 1;
 
 zdir = data.b(bp.idx_dir);
 vdir = data.v(bp.idx_dir);
 
 Ndir = sum(bp.idx_dir); 
%--------------------------------------------------------------------------


%----------------------Scale Directed Factor Nodes-------------------------
 coeff = sum(data.A(bp.idx_dir, :), 2);
 sc    = coeff ~= 1;

 zdir(sc) = zdir(sc) ./ coeff(sc);
 vdir(sc) = vdir(sc) ./ (coeff(sc).^2);
%--------------------------------------------------------------------------


%------------------Merge Multiple Directed Factor Nodes--------------------
 Adir = bp.Inc(bp.idx_dir, :);
 
 idx = find(Adir);
 [~, col] = find(Adir);
 
 m = spdiags(zdir, 0, Ndir, Ndir) * Adir;
 v = spdiags(vdir, 0, Ndir, Ndir) * Adir;

 zdir = m(idx);
 vdir = v(idx);
 idx  = unique(col);

 vdiri = 1 ./ vdir;
 var   = (accumarray(col, vdiri, [bp.Nvar 1]));
 var   = 1./var(idx);
 mean  = accumarray(col, zdir .* vdiri, [bp.Nvar 1]); 
 mean  = mean(idx).* var;
 
%--------------------------------------------------------------------------


%--------------------------Local Factor Nodes------------------------------  
 bp.zloc = user.mean * ones(bp.Nvar,1);
 bp.vloc = user.vari * ones(bp.Nvar, 1);
 
 bp.zloc(idx) = mean; 
 bp.vloc(idx) = var;
%-------------------------------------------------------------------------- 
