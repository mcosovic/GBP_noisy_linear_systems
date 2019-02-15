 function [] = d2_estimation(bp, wls, stop)

 
 
%-------------------------------Display Data-------------------------------
 bp.pos_time = toc;
 
 m = bp.mean;
 A = [(1:bp.Nvar)' m wls.x_qr abs(m - wls.x_qr)];
 
 if (wls.war_qr == "")
     wls.war_qr = "no warning";
 end
 
 if (wls.war_ml == "")
     wls.war_ml = "no warning";
 end
%--------------------------------------------------------------------------


%%
 disp(' ')
 disp(' ')
 disp(' ....................:::::::::::::::::::::::::::   BP State Estimation   :::::::::::::::::::::::::::....................');
 disp(' ')
 fprintf('\tMethod: Gaussian Belief Propagation Solver\n');
 fprintf(['\tDate: ', datestr(now, 'dd.mm.yyyy HH:MM:SS \n')])
 fprintf('\tStopping condition for iterative process: %s\n ', num2str(stop))
 fprintf ('\tNumber of iterations: %d\n', bp.k)
 disp(' ')
 fprintf ('\tNumber of Variable Nodes: %d\n', bp.Nvar)
 fprintf ('\tNumber of Factor Nodes: %d\n', bp.Nfac)
 fprintf ('\tNumber of Links: %d\n', bp.Nmsg + bp.Nfac - bp.Nind)
 disp(' ')
 fprintf('\tWeighted Least Squares using QR Decomposition: %2.5f seconds\n', wls.time_qr)
 fprintf('\tNumerical Stability: %s\n', wls.war_qr)
 disp(' ')
 fprintf('\tWeighted Least Squares using mldivide: %2.5f seconds\n', wls.time_ml)
 fprintf('\tNumerical Stability: %s\n', wls.war_ml)
  disp(' ')
 fprintf('\tPreprocessing: %2.5f seconds\n', bp.pre_time)
 fprintf('\tBelief Propagation Iterations: %2.5f seconds\n', bp.iter_time)
 fprintf('\tPostprocessing: %2.5f seconds\n', bp.pos_time)
 disp(' ')

 disp('  __________________________________________________________________') 
 disp('    Variable         BP         WLS               Difference')
 disp('  ------------------------------------------------------------------') 
 fprintf('%8.f %16.4f %11.4f %21.2e\n', A') 
 disp('  __________________________________________________________________')