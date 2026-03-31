function relpath = abs2rel(abspath,refpath)
%ABS2REL Convert absolute path to relative path.
%   REL = ABS2REL(ABS,REF) returns a relative path REL equivalent to the
%   absolute path ABS relative to the reference path REF. For example, when
%   ABS = /HOME/USR/TMP/FILE1.EXT and REF = /HOME/USR/, then REL =
%   ./TMP/FILE1.EXT.
%
%   Note that ABS2REL also handles the case when ABS and REF do not
%   fully overlap. For example, when ABS = /HOME/USR/TMP/BIS/FILE1.EXT and
%   REF = /HOME/USR/TMP/FOO/, then REL = ../BIS/FILE1.EXT. Finally, when
%   ABS = /MNT/DRV/FILE1.EXT and REF = /HOME/USR/TMP, REL = ABS.
%
%   See also REL2ABS, ISREL, ISABS, ISROOT, ROOTDIR, USERDIR

% 2020 MCaetano SMT 0.3.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,2);

% Check number of output arguments
nargoutchk(0,1);

% Relative to the current directory
if nargin == 1
    
    refpath = string(pwd);
    
end

if ~isstring(abspath)
    
    abspath = string(abspath);
    
end

if ~isstring(refpath)
    
    refpath = string(refpath);
    
end

% Prepend FILESEP
if ~endsWith(refpath,filesep)
    
    refpath = strcat(refpath,filesep);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get absolute path, file name, and file extension
[absPath,absName,absExt] = fileparts(abspath);

% Split reference path into components
absPathParts = split(absPath,filesep);

% Get reference path (allowing refpath to also be a file)
refPath = fileparts(refpath);

% Split reference path into components
refPathParts = split(refPath,filesep);

% Parts in absPathParts that are also in refPathParts
pathCommonParts = intersect(absPathParts,refPathParts,'stable');

% Parts in absPathParts that are not in refPathParts (ABS-REF==REL)
relPathParts = setdiff(absPathParts,refPathParts,'stable');

% Parts in refPathParts that are not in absPathParts (REF-ABS==NLEVELUP)
diffPathParts = setdiff(refPathParts,absPathParts,'stable');

% Make file name
fname = strcat(absName,absExt);

% Replace FNAME if it does not exist
if fname == ""
    
    fname = filesep;
    
end

% If both absolute and reference paths are relative to the same root drive
if ~isempty(pathCommonParts) && startsWith(abspath,strjoin(pathCommonParts,filesep))
    
    % If absolute path belongs to the same branch as reference path
    if isempty(diffPathParts)
        
        % Dir symbol (current dir)
        dirsymbol = ".";
        
        % Number of times must add dir symbol
        nrep = 1;
        
    else
        
        % Dir symbol (previous dir)
        dirsymbol = "..";
        
        % Number of times must add dir symbol
        nrep = length(diffPathParts);
        
    end
    
    % Concatenate dir symbol
    relPathParts = [repmat(dirsymbol,nrep,1);relPathParts];
    
else
    
    % If absolute path and reference path belong to different root drives
    relPathParts = absPathParts;
    
end

% Make relative path
relpath = fullfile(strjoin(relPathParts,filesep),fname);

end
