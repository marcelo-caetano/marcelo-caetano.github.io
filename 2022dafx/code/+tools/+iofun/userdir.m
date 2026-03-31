function udir = userdir(dispflag)
%USERDIR Return user directory.
%   U = USERDIR returns the user directory in U.
%
%   U = USERDIR(DFLAG) uses the DFLAG to set the class of the output. Use
%   DFLAG = 's' (also "s") for string or DFLAG = 'c' (also "c") for char.
%   DFLAG can be either char or string.
%
%   See also ROOTDIR, ISROOT, ISABS, ISREL, ABS2REL, REL2ABS

% 2020 MCaetano SMT 0.3.0

% Useful Java properties: file.separator, path.separator, user.name,
% user.home
% Useful environment variables: getenv('homedrive'), getenv('userprofile'),
% getenv('homepath')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(0,1);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 0
    
    dispflag = 's';
    
end

% Check if DISPFLAG is char or string
if ~(ischar(dispflag)||isstring(dispflag))
    
    error('MATLAB:USERDIR:InputArgument',...
        'Input argument DISPFLAG must be class CHAR or STRING');
    
end

if ~any(strcmpi(dispflag,{'s','c'}))
    
    warning('MATLAB:USERDIR:InputArgument',['Input argument DISPFLAG '...
        'must be either s or c. Value entered was DISPFLAG = %s.\n'...
        'Using default DISPFLAG = s']);
    
    dispflag = 's';
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Class for output variable
if strcmpi(dispflag,'s')
    
    dispfun = @string;
    
else
    
    dispfun = @char;
    
end

% Retrieve USER.HOME from Java method (see also 'help getuserdir')
% WARNING! udir = getenv('userprofile') gives identical result on windows
udir = dispfun(java.lang.System.getProperty('user.home'));

end
