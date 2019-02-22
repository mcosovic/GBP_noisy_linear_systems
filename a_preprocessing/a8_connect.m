 function [bp] = a8_connect(bp)
    


%----------------------------Disconnected Node-----------------------------
 zero_col = find(all(bp.Aind == 0, 1));  

 if ~isempty(zero_col)
    g = sprintf('%d ', zero_col);
    fprintf('Variable nodes connected only on the singly-conected factor node: %s', g)
 end
%--------------------------------------------------------------------------