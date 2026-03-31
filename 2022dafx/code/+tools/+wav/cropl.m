function y = cropl(x,maxl,fadeoutlen,fadeoutflag)
%CROPL Crop length.
%   Y = CROPL(X,L,F,FADEOUTFLAG) crops X to the maximum length specified by L and
%   applies a fadeout curve to the last F samples of Y. FADEOUTFLAG specifies the
%   kind of fade-out curve used. FADEOUTFLAG = 'LIN' uses a linear fade-out curve
%   and FADEOUTFLAG = 'EXP' uses an exponential fade-out curve (from 0 to -20 dB).
%
%   See also other functions

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,4);

% Check number of output arguments
nargoutchk(0,1);

% Check number of input arguments
if nargin == 2
    
    fadeoutlen = round(0.1*length(x));
    
    fadeoutflag = 'lin';
    
elseif nargin == 3
    
    fadeoutflag = 'lin';
    
end

% Check input argument type
if ~isnumeric(x)
    
    error('TypeInArg:wrongType',['Wrong Type of Input Argument.\n'...
        'BASEDIR must be class CHAR not %s.\n'...
        'Type HELP RECURSDIR for more information.\n'],class(basedir))
    
end

% Check input argument type
if ~isnumeric(maxl)
    
    error('TypeInArg:wrongType',['Wrong Type of Input Argument.\n'...
        'BASEDIR must be class CHAR not %s.\n'...
        'Type HELP RECURSDIR for more information.\n'],class(maxl))
    
end

% Check input argument type
if ~isnumeric(fadeoutlen)
    
    error('TypeInArg:wrongType',['Wrong Type of Input Argument.\n'...
        'BASEDIR must be class CHAR not %s.\n'...
        'Type HELP RECURSDIR for more information.\n'],class(fadeoutlen))
    
end

% Check input argument type
if ~tools.misc.istext(fadeoutflag)
    
    error('TypeInArg:wrongType',['Wrong Type of Input Argument.\n'...
        'EXPR must be class CHAR not %s.\n'...
        'Type HELP RECURSDIR for more information.\n'],class(fadeoutflag))
    
end

% Check if MAXL is integer
if ~tools.misc.isint(maxl)
    
    warning('ValueInArg:notInteger',['REM(MAXL,1)=%5.5f\n'...
        'MAXL must be an integer.\n'...
        'Using MAXL=ROUND(MAXL)=%d instead.\n'],rem(maxl,1),round(maxl))
    
    maxl = round(maxl);
    
end

% Check if FADEOUT is integer
if ~tools.misc.isint(fadeoutlen)
    
    warning('ValueInArg:notInteger',['REM(FADEOUT,1)=%5.5f\n'...
        'FADEOUT must be an integer.\n'...
        'Using FADEOUT=ROUND(FADEOUT)=%d instead.\n'],rem(maxl,1),round(maxl))
    
    maxl = round(fadeoutlen);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Length of X
[nsample,nchannel] = size(x);

% Check if L >= MAXL
if nsample < maxl
    
    % No need to crop X
    maxl = nsample;
    
    % Check if L >= FADEOUT
    if nsample < fadeoutlen
        
        % Fade-out region is L (entire X)
        fadeoutlen = nsample;
        
    end
    
end

% Make fade-out curve
switch lower(fadeoutflag)
    
    case 'lin'
        
        fadeout = linspace(1,0,fadeoutlen)';
        
    case 'exp'
        
        fadeout = logspace(0,-20,fadeoutlen)';
        
    otherwise
        
        warning('SMT:CROPL:InvalidFlag',['Invalid FADEOUTFLAG.\n'...
            'FADEOUTFLAG must be either LIN or EXP.\n'...
            'Using default LIN.'])
        
        fadeout = linspace(1,0,fadeoutlen)';
        
end

% Crop to MAXL
y = x(1:maxl,:,:);

% Apply fade-out curve
y(end-fadeoutlen+1:end,:,:) = y(end-fadeoutlen+1:end,:,:) .* repmat(fadeout,1,nchannel);

end
