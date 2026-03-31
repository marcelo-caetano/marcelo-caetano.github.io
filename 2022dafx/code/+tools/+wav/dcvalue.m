function dcval = dcvalue(x)
%DCVALUE DC value of signal.
%   DCVAL = DCVALUE(X) returns the DC value of X.
%
%   Y has the DC value per channel when X has one channel per column.
%
%   See also PEAKLEVEL, RMSLEVEL.

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
if nargin ~= 1
    
    error('NumInArg:wrongNumber',['Wrong Number of Input Arguments.\n'...
        'DCVALUE takes 1 input arguments.\n'...
        'Type HELP DCVALUE for more information.\n'])
    
end

% Check input argument type
if not(isnumeric(x))
    
    error('TypeInArg:wrongType',['Wrong Type of Input Argument.\n'...
        'X must be a numeric class not %s.\n'...
        'Type HELP DCVALUE for more information.\n'],class(x))
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get NSAMPLE and NCHANNEL
[nsample,nchannel] = size(x);

% Calculate DC value
dcval = sum(x) / nsample;

end

