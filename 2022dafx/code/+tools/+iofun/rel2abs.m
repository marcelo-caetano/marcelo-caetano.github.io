function abspath = rel2abs(relpath,refpath)
%REL2ABS Convert relative path to absolute path.
%   ABS = REL2ABS(REL,REF) returns an absolute path ABS equivalent to the
%   relative path REL relative to the reference path REF. For example, when
%   REL = ./TMP/FILE1.EXT and REF = /HOME/USR/, then ABS =
%   /HOME/USR/TMP/FILE1.EXT, so REL2ABS interprets ./ as REL being a direct
%   descendent of REF in the file path tree.
%
%   However, when REL = ../TMP/FILE1.EXT and REF = /HOME/USR/, then ABS =
%   /HOME/TMP/FILE1.EXT, so REL2ABS interprets ../ as REL being a direct
%   descendent of one level above REF.
%
%   See also ABS2REL, ISREL, ISABS, ISROOT, ROOTDIR, USERDIR

% 2020 MCaetano SMT 0.3.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,2);

% Check number of output arguments
nargoutchk(0,1);

% Relative to the current directory
if nargin == 1
    
    refpath = string(pwd);
    
end

if ~isstring(relpath)
    
    relpath = string(relpath);
    
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

% Get relative path, file name, and file extension
[relPath,relName,relExt] = fileparts(relpath);

% Split relative path into components
relPathParts = split(relPath,filesep);

% Get reference path (allowing refpath to also be a file)
refPath = fileparts(refpath);

% Split reference path into components
refPathParts = split(refPath,filesep);

% Make file name
fname = strcat(relName,relExt);

% Replace FNAME if it does not exist
if fname == ""
    
    fname = filesep;
    
end

% Check if relative to the current dir
bool_currdir = strcmp(".",relPathParts);

% Check if relative to parent dir
bool_pardir = strcmp("..",relPathParts);

% If relative path
if any([bool_currdir;bool_pardir])
    
    % If relative to current dir
    if any(bool_currdir)
        
        % Number of current dir symbols
        ncurrdir = nnz(bool_currdir);
        
        % Delete current dir from relative path
        relPathParts(1:ncurrdir) = "";
        
        % If more than one current dir symbol
        if ncurrdir > 1
            
            warning(['SMT:WrongRelativePath: ','Wrong relative path.\n'...
                'Relative path %s\n contains more than one current directory '...
                'symbol.\nBuilding absolute path relative to the reference '...
                'path %s\n'],relpath,refpath);
            
        end
        
        % Concatenate reference and relative path parts (eliminating
        % eventual duplicates)
        % absPathParts = unique([refPathParts;relPathParts],'stable');
        absPathParts = [refPathParts;relPathParts];
        
    else %If relative to parent dirs
        
        % Number of levels to go up
        npardir = nnz(bool_pardir);
        
        % Delete parent dir from relative path
        relPathParts(1:npardir) = "";
        
        % If refpath has more parent dir symbols than NPARDIR
        if length(refPathParts) >= npardir + 1
            
            % Eliminate
            refPathParts(end-npardir+1:end) = "";
            
            % Concatenate reference and relative path parts (eliminating
            % eventual duplicates)
            % absPathParts = unique([refPathParts;relPathParts],'stable');
            absPathParts = [refPathParts;relPathParts];
            
        else
            
            warning('SMT:WrongRelativePath',['Wrong relative path.\n'...
                'Relative path %s \ncontains more parent directory symbols '...
                'than the depth of the reference path\n%s.\n'...
                'The number of parent directory symbols in the relative path '...
                'is %d.\nThe depth of reference path is %d.\n'...
                'Building absolute path relative to the root directory %s.'],...
                relpath,refpath,npardir,length(refPathParts)-1,tools.iofun.rootdir);
            
            % Build absolute path relative to root
            absPathParts = [tools.iofun.rootdir;relPathParts];
            
        end
        
    end
    
else % Absolute path
    
    % If absolute path and reference path belong to different root drives
    absPathParts = relPathParts;
    
end

% Make absolute path
abspath = fullfile(strjoin(absPathParts,filesep),fname);

end
