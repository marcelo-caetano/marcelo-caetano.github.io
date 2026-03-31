function ydb = rmsdb(x,rmsflag,logflag,nanflag)
%RMSDB Root mean square level in dB.
%   Y = RMSDB(X,RMSFLAG) returns the root-mean-square (RMS) level of X in dB.
%   RMSFLAG can be either 'SIN' or 'SQ' to determine the reference level used.
%   SIN uses 0 dB as RMS(SIN) and SQ uses 0 dB as RMS(SQUARE), where
%   RMS(SIN) is the RMS level of a full-scale sine wave [1] and RMS(SQUARE)
%   is the RMS level of a full-scale square wave [2].
%
%   Y = RMSDB(X) uses 'SIN' as default reference level.
%
%   Y has the RMS level per channel when X has one channel per column.
%
%   [1] AES17-2015: AES standard method for digital audio engineering -
%   Measurement of digital audio equipment.
%   (http://www.aes.org/publications/standards/search.cfm?docID=21)
%
%   [2] Recommendation ITU-T G.100.1 provides the definition for different
%   logarithmic power level measurement units in current use in
%   telecommunication systems.
%   (http://www.itu.int/ITU-T/recommendations/rec.aspx?rec=5596&lang=en)
%
%   See also PEAKDB, RMSLEVEL, PEAKLEVEL.

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,4);

% Check number of output arguments
nargoutchk(0,1);

% Default input arguments
if nargin == 1
    
    rmsflag = 'sin';
    
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
        'Type HELP RMSDB for more information.\n'],class(x))
    
end

% Check input argument type
if ~tools.misc.istext(rmsflag)
    
    error('TypeInArg:wrongType',['Wrong Type of Input Argument.\n'...
        'RMSFLAG must be class CHAR not %s.\n'...
        'Type HELP RMSDB for more information.\n'],class(rmsflag))
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Reference level specified by RMSFLAG
switch lower(rmsflag)
    
    case 'sin'
        
        reflevel = sqrt(2)/2;
        
    case 'sq'
        
        reflevel = 1;
        
    otherwise
        
        warning('SMT:RMSDB:InvalidInputArgument',['Invalid RMSFLAG'...
            'RMSFLAG must be either SIN or SQ\n'...
            'RMSFLAG entered was %s\n'...
            'Using default RMSFLAG = SIN.\n'],rmsflag)
        
        reflevel = sqrt(2)/2;
        
        
end


yrms = tools.wav.rmslevel(x);

ratio = yrms ./ reflevel;

% RMS level in dB
ydb = tools.math.lin2log(ratio,logflag,nanflag);

end
