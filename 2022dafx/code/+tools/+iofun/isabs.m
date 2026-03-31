function bool = isabs(querydir)
%ISABS Check if path is absolute.
%   BOOL = ISABS(QUERYDIR) returns true when QUERYDIR is an absolute path
%   and FALSE otherwise. ISABS checks if QUERYDIR starts with the root
%   directory given by ROOTDIR.
%
%   QUERYDIR can be a string array, a character vector, or a cell array of
%   character vectors. If QUERYDIR is a string array or cell array, then
%   BOOL is a logical array that is the same size.
%
%   See also ISREL, ISROOT, ABS2REL, REL2ABS, ROOTDIR, USERDIR

% 2020 MCaetano SMT 0.3.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,1);

% Check number of output arguments
nargoutchk(0,1);

% Check class of input argument
if ~(ischar(querydir)||isstring(querydir)||iscellstr(querydir))
    
    error('SMT:ISABS:InvalidArgument',['Invalid argument\n',...
        'Input argument QUERYDIR must be CHAR, STRING, or CELL ARRAY OF CHAR']);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ispc
    
    % RegExp: lower- or upper-case letter followed by : OR // at the
    % beginning of the input text
    expr = '^([a-zA-Z]:|\\\\)';
    
else
    
    % RegExp: / at the beginning of the input text
    expr = '^/';
    
end

% Check if RegExp has a match
bool = ~isempty(regexp(querydir,expr,'once'));

end
