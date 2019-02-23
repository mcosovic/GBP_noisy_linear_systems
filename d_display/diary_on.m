 function [] = diary_on(bp, user)



%------------------------------Turn on Diary-------------------------------
 if user.save == 1
    diary(strcat('data', num2str(bp.Nfac), '_', num2str(bp.Nvar), datestr(now,'_dd-mm-yy','local'),'_', datestr(now,'hh-MM-ss','local'), '.txt'))
 end
%--------------------------------------------------------------------------