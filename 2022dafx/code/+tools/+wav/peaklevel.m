function y = peaklevel(x)
%PEAKLEVEL Peak level.
%   Y = PEAKLEVEL(X) returns the peak level of X. Y = MAX(ABS(X)).
%
%   Y has the peak level per channel when X has one channel per column.
%
%   See also PEAKDB, RMSLEVEL, PEAKDB.

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
    
    error('SMT:PEAKLEVEL:InvalidInputArgument',['Invalid Input Argument.\n'...
        'X must be a numeric class not %s.\n'...
        'Type HELP PEAKLEVEL for more information.\n'],class(x))
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Peak level
y = max(abs(x));

end
