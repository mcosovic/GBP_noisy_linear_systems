 function [bp] = a4_indirect_factor(data, bp)
 


%--------------------------Indirect Factor Nodes---------------------------
 idx_ind = ~bp.idx_dir;

 bp.Inc  = bp.Inc(idx_ind, :);
 bp.Aind = data.A(idx_ind, :);

 bp.zind = data.b(idx_ind);
 bp.vind = data.v(idx_ind);
 
 bp.Nind = bp.Nfac - bp.Ndir;
%--------------------------------------------------------------------------