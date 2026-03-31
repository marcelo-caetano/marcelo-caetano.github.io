function bool = isroot(querydir)
%ISROOT Check if path is absolute starting at the root dir.
%   BOOL = ISROOT(QUERYDIR) returns true when QUERYDIR is an absolute path
%   starting at the root dir and FALSE otherwise. ISROOT checks if QUERYDIR
%   starts with the root directory given by ROOTDIR.
%
%   QUERYDIR can be a string array, a character vector, or a cell array of
%   character vectors. If QUERYDIR is a string array or cell array, then
%   BOOL is a logical array that is the same size.
%
%   See also ISABS, ISREL, ABS2REL, REL2ABS, ROOTDIR, USERDIR

% 2020 MCaetano SMT 0.3.0

% TODO: Check if it's absolute path first

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,1);

% Check number of output arguments
nargoutchk(0,1);

% Check class of input argument
if ~(ischar(querydir)||isstring(querydir)||iscellstr(querydir))
    
    error('SMT:ISROOT:InvalidArgument',['InvalidArgument\n',...
        'Input argument QUERYDIR must be CHAR, STRING, or CELL ARRAY OF CHAR']);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check if path starts with root dir
bool = startsWith(querydir,tools.iofun.rootdir);

end
