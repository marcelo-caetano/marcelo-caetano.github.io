function y = peakdb(x,reflevel,logflag,nanflag)
%PEAKDB Peak level in dB.
%   Y = PEAKDB(X) returns the peak level of X in dB. The reference level is
%   0 dB corresponding to PEAKLEVEL(X) = 1.
%
%   Y has the peak level per channel when X has one channel per column.
%
%   See also PEAKLEVEL, RMSLEVEL, RMSDB.

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,3);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 1
    
    reflevel = 1;
    
    logflag = 'dbp';
    
    nanflag = false;
    
elseif nargin == 2
    
    logflag = 'dbp';
    
    nanflag = false;
    
elseif nargin == 3
    
    nanflag = false;
    
end

% Check input argument type
if ~isnumeric(x)
    
    error('TypeInArg:wrongType',['Wrong Type of Input Argument.\n'...
        'X must be a numeric class not %s.\n'...
        'Type HELP PEAKDB for more information.\n'],class(x))
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xpeak = tools.wav.peaklevel(x);

ratio = xpeak ./ reflevel;

% Peak level in dB
y = tools.math.lin2log(ratio,logflag,nanflag);

end
