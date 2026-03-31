function y = rmslevel(x)
%RMSLEVEL Root mean square level.
%   RMS = RMSLEVEL(X) returns the root-mean-square level RMS of X.
%   RMS(X) = SQRT((1/L)*SUM(X.^2)), where L is the length of X.
%   RMS has the RMS level per channel when X has one channel per column.
%
%   See also PEAKLEVEL, RMSDB, PEAKDB.

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0
% 2021 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,1);

% Check number of output arguments
nargoutchk(0,1);

% Check input argument type
if ~isnumeric(x)
    
    error('SMT:RMSLEVEL:InvalidInputArgument',['Invalid Input Argument.\n'...
        'X must be a numeric class not %s.\n'...
        'Type HELP RMSLEVEL for more information.\n'],class(x))
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get NSAMPLE and NCHANNEL
[nsample,nchannel] = size(x);

% RMS level
y = sqrt((1/nsample) * sum(x .* conj(x)));

end
