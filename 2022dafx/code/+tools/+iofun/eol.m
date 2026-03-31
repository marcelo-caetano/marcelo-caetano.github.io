function nl = eol(sys)
%EOL End of line.
%   NL = EOL(SYS) returns the new line character(s) NL for the OS SYS.
%
%   See also NEWLINE

% 2020 MCaetano SMT 0.3.0
% 2021 M Caetano (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(0,1);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 0
    
    sys = getPlatform;
    
elseif nargin == 1
    
    bool = strcmp(sys,["win","lin","mac"]);
    
    if ~any(bool)
        
        warning('SMT:EOL:UnknownFlag',['Unknown system flag.\n'...
            'Flag entered was %s. Options are WIN, LIN, MAC.\n'...
            'Attempting to automatically retrieve SYS.\n'],sys);
        
        sys = getPlatform;
        
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch lower(sys)
    
    case 'win'
        
        nl = '\r\n';
        
    case {'lin','mac'}
        
        nl = '\n';
        
    otherwise
        
        nl = '\n';
        
end

end

% Local function to get platform
function sys = getPlatform

if ispc
    
    sys = 'win';
    
elseif isunix
    
    sys = 'lin';
    
elseif ismac
    
    sys = 'mac';
    
else
    
    warning('SMT:EOL:UnknownPlatform',...
        ['Local function GETPLATFORM was '...
        'unable to retrieve the platform.\n'...
        'Function COMPUTER returns %s.\n'...
        'Using \\n as default EOL.\n'],computer);
    
end

end
