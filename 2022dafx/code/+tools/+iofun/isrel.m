function bool = isrel(querydir)
%ISREL Check if path is relative.
%   BOOL = ISREL(QUERYDIR) returns true when QUERYDIR is a relative path
%   and FALSE otherwise. ISREL uses ISABS to check if QUERYDIR starts with
%   the root directory given by ROOTDIR.
%
%   QUERYDIR can be a string array, a character vector, or a cell array of
%   character vectors. If QUERYDIR is a string array or cell array, then
%   BOOL is a logical array that is the same size.
%
%   See also ISABS, ISROOT, ABS2REL, REL2ABS, ROOTDIR, USERDIR

% 2020 MCaetano SMT 0.3.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,1);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bool = ~tools.iofun.isabs(querydir);

end
