 function [bp] = a8_connect(bp)



%----------------------------Disconnected Node-----------------------------
 zero_col = sum(bp.Inc, 1) == 0;

 if any(zero_col)
    g = sprintf('%d ', find(zero_col));
    fprintf('Variable nodes connected only on the singly-conected factor node: %s', g)
 end
%--------------------------------------------------------------------------