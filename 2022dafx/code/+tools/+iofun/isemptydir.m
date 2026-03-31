function bool = isemptydir(querydir)
%ISEMPTYDIR True if folder is empty.
%   BOOL = ISEMPTYDIR(QUERYDIR) returns logical TRUE when QUERYDIR is empty
%   and FALSE otherwise. An emptydir only returns '.' and '..' and both
%   have size 0. QUERYDIR can be class CHAR or STRING.
%
%   See also ISFOLDER, ISFILE

% 2020 MCaetano SMT 0.3.0

% TODO: ALLOW QUERYDIR TO BE STRING ARRAY OR CELL ARRAY OF CHAR (Call
% cellfun or arrayfun recursively if either)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,1);

% Check number of output arguments
nargoutchk(0,1);

% Check class of input argument QUERYDIR
if ~(ischar(querydir)||isstring(querydir))
    
    error('SMT:ISEMPTYDIR:InputArgument',['Wrong Type of Input Argument.\n'...
        'QUERYDIR must be class CHAR or STRING.\n'...
        'Input was %s.\n'],class(querydir));
    
end

if size(querydir,1) ~= 1
    
    error('SMT:ISEMPTYDIR:InputArgument',['Wrong Type of Input Argument.\n'...
        'QUERYDIR must be a CHAR vector or STRING scalar.\n'...
        'Size of QUERYDIR is %d x %d.\n'],size(querydir,1),size(querydir,2));
    
end

% Check that QUERYDIR is a folder
if ~isfolder(querydir)
    
    error('SMT:ISEMPTYDIR:InputArgument',['Wrong Type of Input Argument.\n'...
        'QUERYDIR must be the path to a folder.\n']);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get contents of QUERYDIR
contdir = dir(querydir);

% Number of bytes of each file/dir inside QUERYDIR
nbyte = [contdir.bytes];

if any(nbyte ~= 0)
    
    bool = false;
    
else
    
    bool = true;
    
end

end
