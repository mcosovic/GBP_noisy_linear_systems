 function [bp] = a5_converg(user, bp)



%-----------------------Randomized Damping Messages------------------------
 bp.idx  = find(bp.Aind);
 bp.Nmsg = length(bp.idx);
 bp.wow  = logical(binornd(ones(bp.Nmsg, 1), user.prob));
%--------------------------------------------------------------------------