function flist = rsf(querydir,ext,classflag)
%RSF Recursive search for file.
%   FLIST = RSF(QUERYDIR) performs a recursive search in QUERYDIR and all
%   its subdirectories for files with any extension and returns the result
%   in FLIST. The file naming convention is FNAME.EXT, where FNAME is the
%   file name containing any alphanumeric characters, '.', '&', '_', or '-'
%   and EXT is the file extension containing any alphanumeric characters.
%   RSF assumes that there is a literal '.' character between FNAME and
%   EXT.
%
%   FLIST = RSF(QUERYDIR,EXT) performs a recursive search in QUERYDIR
%   for files of type .EXT. The recursive search looks in QUERYDIR and all
%   subfolders. QUERYDIR must be a path to a valid folder. EXT must be a
%   valid file extension. FLIST is a string array listing the absolute
%   paths to all the files of type .EXT found. QUERYDIR and EXT can be
%   either a char vector or a string scalar.
%
%   EXT can be preceded by the dot (.ext) or not (ext). RSF adds the
%   dot internally so the search is always for .ext.
%
%   FLIST = RSF(QUERYDIR,EXT,CLASSFLAG) uses CLASSFLAG = 'legacy' to force
%   legacy behavior (i.e., output FLIST as a cell array of characters).
%   CLASSFLAG can also be truncated to any length (e.g. 'l', 'le', 'leg',
%   'lega', etc). Any other value of CLASSFLAG will fallback to the default
%   behavior (i.e., output a string array). CLASSFLAG can be either a char
%   or string array. Use the syntax RSF(QUERYDIR,[],CLASSFLAG) to return
%   files with any extension as a cell array of characters.
%
%   See also RSD, NLISTDIR

%   M Caetano 2018
% 2020 MCaetano SMT 0.3.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,3);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 1
    
    % Any file extension (any character in the range a to z, 0 to 9 one or
    % more times consecutively)
    ext = '[a-z0-9]+';
    
    % Default class of output
    classflag = 'default';
    
end

if nargin == 2
    
    % Default class of output
    classflag = 'default';
    
end

if nargin == 3 && isempty(ext)
    
    % Any file extension (any character in the range a to z, 0 to 9 one or
    % more times consecutively)
    ext = '[a-z0-9]+';
    
end

% Check class of input argument QUERYDIR
if ~(ischar(querydir)||isstring(querydir))
    
    error('SMT:RSF:InputArgument',['Wrong Type of Input Argument.\n'...
        'QUERYDIR must be class CHAR or STRING.\n'...
        'Input was %s.\n'],class(querydir));
    
end

% Check class of input argument EXT
if ~(ischar(ext)||isstring(ext))
    
    error('SMT:RSF:InputArgument',['Wrong Type of Input Argument.\n'...
        'EXT must be class CHAR or STRING.\n'...
        'Input was %s.\n'],class(ext));
    
end

% Check class of input argument CLASSFLAG
if ~(ischar(classflag)||isstring(classflag))
    
    error('SMT:RSF:InputArgument',['Wrong Type of Input Argument.\n'...
        'CLASSFLAG must be class CHAR or STRING.\n'...
        'Input was %s.\n'],class(classflag));
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create handle to initialization function
if startsWith('legacy',lower(classflag))
    
    initfun = @cell;
    
else
    
    initfun = @strings;
    
end

% Initialize output variable
flist = initfun(0);

% List contents of QUERYDIR
listdir = dir(querydir);

% Number of files/directories inside first level
[ndir,~] = size(listdir);

% Remove . from beginning of EXT (added back in call to REGEXPI))
ext = strip(ext,'left','.');

% Lookbehind (any character in the range a to z, 0 to 9, '_', '-', '&', and
% '.' one or more times consecutively)
lookbehind = '(?<=[a-z_0-9-&.]+)';

% Create regular expression (LOOKBEHIND followed by literal . character
% followed by EXT at the end of input text)
expr = [lookbehind '\.' ext '$'];

% For each file/dir
for idir = 1:ndir
    
    % If LISTDIR(IDIR) is not a directory AND the file name has .EXT
    if ~listdir(idir).isdir && ~isempty(regexpi(listdir(idir).name,expr,'once'))
        
        % Add file to the list
        flist = vertcat(flist,fullfile(querydir,listdir(idir).name));
        
        % If LISTDIR(IDIR) is a directory (not current directory nor parent directory)
    elseif listdir(idir).isdir && ~any(strcmp(listdir(idir).name,["." ".."]))
        
        % Get dir name
        dirname = fullfile(querydir,listdir(idir).name);
        
        % Recursive search (return partial file list)
        part_flist = tools.iofun.rsf(dirname,ext,classflag);
        
        % If recursive search is fruitful
        if ~isempty(part_flist)
            
            % Concatenate to the current file list
            flist = vertcat(flist,part_flist);
            
        end
        
    else
        
        continue
        
    end
    
end

end
