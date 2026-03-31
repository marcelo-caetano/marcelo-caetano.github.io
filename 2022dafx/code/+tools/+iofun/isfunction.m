function bool = isfunction(queryfile)
%ISFUNCTION Check if file is a Matlab function.
%   BOOL = ISFUNCTION(QUERYFILE) returns BOOL == TRUE when QUERYFILE is a
%   function or contains a function definition and BOOL = FALSE otherwise.
%
%   ISFUNCTION uses NARGIN(QUERYFILE) to test if QUERYFILE is a function,
%   so NARGIN must be able to find QUERYFILE. ISFUNCTION throws an error if
%   EXIST(QUERYFILE) == 0. Therefore, use absolute paths to QUERYFILE to
%   avoid the error. If QUERYFILE is specified as a relative path, then it
%   must be on the search path. ISFUNCTION is able to handle files that are
%   not on the search path by momentarily adding their folder to the search
%   path and then removing it after the query with NARGIN. That is why
%   QUERYFILE must be an absolute path.
%
%   See also ISSCRIPT, ISFILETYPE

% 2019 M Caetano
% 2020 MCaetano SMT 0.2.1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,1);

% Check number of output arguments
nargoutchk(0,1);

% Check if QUERYFILE is char or string
if ~(ischar(queryfile)||isstring(queryfile))
    
    error('MATLAB:ISFUNCTION:inputArgument',['Wrong Type of Input Argument.\n'...
        'QUERYFILE must be class CHAR or STRING.\n'...
        'Input was %s.\n'],class(queryfile));
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION BODY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if exist(queryfile,'file') == 0
    
    error('MATLAB:ISFUNCTION:fileNotFound',...
        '%s was not found.\n',queryfile);
    
end

% Check if QUERYFILE is a function
if tools.iofun.isfiletype(queryfile,'.m')
    
    % Check that queryfile is on the path
    if tools.iofun.isfileonpath(queryfile)
        
        % Try nargin
        bool = trynargin(queryfile);
        
    else
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % ADD FILE MOMENTARILY TO PATH, QUERY, AND THEN REMOVE FROM PATH
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Get dir
        filedir = fileparts(queryfile);
        
        % Add dir to path
        addpath(filedir);
        
        % Query NARGIN
        tmpBool = trynargin(queryfile);
        
        % Remove dir from path
        rmpath(filedir);
        
        % Return
        bool = tmpBool;
        
    end
    
else
    
    % Only m-file can be function
    bool = false;
    
end

end

% PRIVATE FUNCTION TRYNARGIN
function boolNargin = trynargin(fname)

try
    
    % Use NARGIN to query if file is a function
    nargin(fname);
    
    % If NARGIN returns the number of input arguments (QUERYFILE is a
    % function)
    boolNargin = true;
    
catch
    
    % Otherwise, nargin throws an error (QUERYFILE is a script)
    boolNargin = false;
    
end

end
