function [status,errmsg] = mkdir(dirpath,dispflag)
%MKDIR Make new folder when folder does not exist.
%   MKDIR(P) checks if the folder specified by P exists. If the folder P
%   does not exist, MKDIR creates the new folder.
%   P is a character vector with either a relative or an absolute path.
%
%   A relative path starts with . or .. so P is expanded as [PWD; P].
%   Relative paths must be in the search path.
%
%   Absolute paths start from the root directory and MKDIR decomposes
%   P = [PARENT; NEW], where PARENT must be a valid path inside USER.HOME
%   returned by the JAVA method java.lang.System.getProperty('user.home')
%   and the current user must have write permission inside PARENT.
%
%   MKDIR(P,DISPFLAG) allows to specify DISPFLAG as a char 'v': verbose
%   or 's': silent. If DISPFLAG is not provided, DISPFLAG defaults to 's'.
%
%   [S,ERR] = MKDIR(...) returns the status S and ERR. S == TRUE when a
%   new folder is created and FALSE otherwise. ERR returns the error
%   message in a cell string. ERR is empty when MKDIR encounters no
%   errors.
%
%   EXAMPLE 1: Relative path
%
%   p = fullfile('.','tmp');
%   nf = MKDIR(p,'v');
%
%   EXAMPLE 2: Relative path
%
%   p = fullfile('..','tmp');
%   nf = MKDIR(p,'v');
%
%   EXAMPLE 3: Absolute path
%
%   p = fullfile(pwd,'myfolder','tmp');
%   [nf,s] = MKDIR(p,'v');
%
%   See also ISROOT, ROOTDIR

% M Caetano 2019
% 2022 M Caetano SMT (Revised)

% TODO: DEBUG! LOCAL FUNCTION CALSS DEPRECATED FUNCTION TOOLS.IOFUN.DIRPATH

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,2);

nargoutchk(0,2);

if nargin == 1
    
    dispflag = 's';
    
end

validateattributes(dirpath,{'char','string'},{'scalartext'},mfilename,'P',1)
validateattributes(dispflag,{'char','string'},{'scalartext'},mfilename,'DISPFLAG',2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check whether FULLPATH exists
exflag = exist(dirpath,'dir');

switch exflag
    
    case 7
        
        if strcmpi(dispflag,'v')
            
            % Display warning to user
            warning('SMT:MKDIR:ExistingDir',['Existing dir\n',...
                'Directory was not created\n'...
                'Directory %s already exists.'],dirpath)
            
        end
        
        % Did not make new folder
        status = false;
        
        % No error message
        errmsg = sprintf('Folder %s already exists',dirpath);
        
    case 0
        
        if strcmpi(dispflag,'v')
            
            % Display message to user
            fprintf(1,'Creating folder %s\n',dirpath);
            
        end
        
        % Split FULLPATH at system FILESEP
        [pathparts,del] = split(dirpath,filesep);
        
        % Check if FULLPATH has the rigth system dependent delimiter
        % (filesep)
        if isempty(del)
            
            % Throw error
            error('SMT:MKDIR:WrongDelimiter',['Wrong delimiter\n',...
                '%s uses the wrong delimiter for this system.\n'...
                'See FILESEP for the correct delimiter.\n'],dirpath);
            
        end
        
        % Check whether FULLPATH is absolute or relative
        if strcmp(pathparts{1},'.')
            
            auxpath = pathparts(2:end);
            
            clear pathparts;
            
            pathparts = [split(pwd,filesep);auxpath];
            
        elseif strcmp(pathparts{1},'..')
            
            auxpath = pathparts(2:end);
            
            tmppath = split(pwd,filesep);
            
            clear pathparts;
            
            pathparts = [tmppath(1:end-1);auxpath];
            
        end
        
        % Make new folder
        [status,errmsg] = makeNewFolder(pathparts,dispflag);
        
    otherwise
        
        % Never reaches this line
        error('SMT:MKDIR:InvalidPath',['Invalid path\n',...
            'Path %s contains errors.'],dirpath);
        
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOCAL FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Function to make new folder
function [status,errmsg] = makeNewFolder(pathParts,dispflag)

% Get size of FULLPATH
[npart,~] = size(pathParts);

% Check if any partial path exists
for ipart = 0:npart-1
    
    partial_path = tools.iofun.dirpath(pathParts(1:end-ipart));
    
    if exist(partial_path,'dir') == 7
        
        break
        
    end
    
end

% Make path to parent folder
parentFolder = tools.iofun.dirpath(pathParts(1:end-ipart));

% Make path to new folder
newFolder = fullfile(pathParts{end-ipart+1:end});

% Retrieve USER.HOME (see also 'help getuserdir')
userHome = char(java.lang.System.getProperty('user.home'));

% Check if FULLPATH contains USER.HOME
if contains(parentFolder,userHome)
    
    % Write file
    [status,errmsg] = writeFolder(parentFolder,newFolder,dispflag);
    
else
    
    % Throw error
    error('SMT:MKDIR:WrongUser',...
        ['Path specified will write to %s.\n',...
        'Path must write inside %s.\n'],parentFolder,userHome);
    
end

end

% Function to write folder
function [status,errmsg] = writeFolder(parent,new,dispflag)

% Check if PARENT is writable
[status,val] = fileattrib(parent);

if status && val.UserWrite
    
    if strcmpi(dispflag,'v')
        
        % Display message to warn user of new folder
        fprintf(1,['Making new folder\n%s\n'...
            'inside parent folder\n',...
            '%s\n'],new,parent);
        
    end
    
    % Make new folder
    [success,mess,messid] = mkdir(parent,new);
    
    % Check if new folder was successfully created
    if success
        
        % Made new folder
        status = true;
        
        % No error message
        errmsg = {};
        
    else
        
        % Did not make new folder
        status = false;
        
        % Output error message
        errmsg = {mess,messid};
        
    end
    
else
    
    % Throw error
    error('SMT:MKDIR:UserWrite',...
        'User does not have permission to write in %s.\n',val.Name);
    
end

end
