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
 Adir = full(bp.Inc(bp.idx_dir, :));
 
 mrg = sum(Adir) > 1;
 Amr = Adir(:, mrg);
 rem = logical(sum(Amr, 2));
 
 vi = spdiags(1 ./ vdir, 0, Ndir, Ndir) * Amr;
 m  = spdiags(zdir, 0, Ndir, Ndir) * Amr;
 
 vdiri = sum(vi);
 var   = 1 ./ vdiri';
  
 msum = sum(m .* vi); 
 mean = msum' .* var;

 zdir(rem)   = [];
 vdir(rem)   = [];
 Adir(rem,:) = [];

 zdir = [zdir; mean];
 vdir = [vdir; var];
%--------------------------------------------------------------------------
 

%--------------------------Local Factor Nodes------------------------------  
 idx      = sum(Adir,1) ~= 0;
 idx(mrg) = 0;
 col      = [find(idx) find(mrg)];

 bp.zloc = user.mean * ones(bp.Nvar,1);
 bp.vloc = user.vari * ones(bp.Nvar, 1);
 
 bp.zloc(col) = zdir; 
 bp.vloc(col) = vdir;
%-------------------------------------------------------------------------- 

