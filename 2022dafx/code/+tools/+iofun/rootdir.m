function rdir = rootdir(dispflag)
%ROOTDIR Return root directory.
%   R = ROOTDIR returns the root directory in R.
%
%   R = ROOTDIR(DFLAG) uses the DFLAG to set the class of the output. Use
%   DFLAG = 's' (also "s") for string or DFLAG = 'c' (also "c") for char.
%   DFLAG can be either char or string.
%
%   See also USERDIR, ISROOT, ISABS, ISREL, ABS2REL, REL2ABS

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
    
    error('MATLAB:ROOTDIR:InputArgument',...
        'Input argument DISPFLAG must be class CHAR or STRING');
    
end

if ~any(strcmpi(dispflag,{'s','c'}))
    
    warning('MATLAB:ROOTDIR:InputArgument',['Input argument DISPFLAG '...
        'must be either s or c. Value entered was DISPFLAG = %s.\n'...
        'Using default DISPFLAG = s']);
    
    dispflag = 's';
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Retrieve USER.HOME from Java method
usrdir = tools.iofun.userdir(dispflag);

% Split at file separator
usrdirParts = split(usrdir,filesep);

% Return root dir
% WARNING! getenv('homedrive') gives identical result on windows
if isempty(usrdirParts{1}) && ~ispc
    
    rdir = filesep;
    
elseif ~isempty(usrdirParts{1}) && ispc
    
    rdir = usrdirParts(1);
    
else
    
    error('SMT:ROOTDIR:InvalidUserDir',['Invalid user directory\n'...
        'User directory retrieved was %s'],usrdir)
    
end

end
