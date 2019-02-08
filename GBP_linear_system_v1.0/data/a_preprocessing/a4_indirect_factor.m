 function [bp] = a4_indirect_factor(data, bp)
 


%--------------------------Indirect Factor Nodes---------------------------
 bp.Inc  = bp.Inc(~bp.idx_dir,:);
 bp.Aind = data.A(~bp.idx_dir,:);

 bp.zind = data.b(~bp.idx_dir);
 bp.vind = data.v(~bp.idx_dir);
 
 bp.Nind = bp.Nfac - bp.Ndir;
%--------------------------------------------------------------------------