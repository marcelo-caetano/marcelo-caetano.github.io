function [makenew,chkstatus] = pathchk(fullpath,dispmode)
%PATHCHK Make new folder when folder does not exist.
%   PATHCHK(P) checks if the folder specified by P exists. If the folder P
%   does not exist, PATHCHK creates the new folder.
%   P is a character vector with either a relative or an absolute path.
%
%   A relative path starts with . or .. so P is expanded as [PWD; P].
%
%   Absolute paths start from the root directory and PATHCHK decomposes
%   P = [PARENT; NEW], where PARENT must be a valid path inside USER.HOME
%   returned by the JAVA method java.lang.System.getProperty('user.home')
%   and the current user must have write permission inside PARENT.
%
%   PATHCHK(P,M) allows to specify the dispmode M as a char 'v': verbose
%   or 's': silent. If M is not provided, M defaults to 's'.
%
%   [N,S] = PATHCHK(...) returns N and the status S. N is true when a new
%   folder is created and false otherwise. S returns the error message in a
%   cell string. S is empty when PATHCHK encounters no errors.
%
%   EXAMPLE 1: Relative path
%
%   p = fullfile('.','tmp');
%   nf = tools.iofun.pathchk(p,'v');
%
%   EXAMPLE 2: Relative path
%
%   p = fullfile('..','tmp');
%   nf = tools.iofun.pathchk(p,'v');
%
%   EXAMPLE 3: Absolute path
%
%   p = fullfile(pwd,'myfolder','tmp');
%   [nf,s] = tools.iofun.pathchk(p,'v');

% 2020 MCaetano SMT 0.3.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,2);

% Check number of output arguments
nargoutchk(0,2);

if nargin == 1
    
    dispmode = 's';
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check whether FULLPATH  exists
exflag = exist(fullpath,'dir');

switch exflag
    
    case 7
        
        if strcmpi(dispmode,'v')
            
            % Display message to user
            fprintf(1,'Folder %s already exists.\n',fullpath);
            
        end
        
        % Did not make new folder
        makenew = false;
        
        % No error message
        chkstatus = {};
        
    case 0
        
        if strcmpi(dispmode,'v')
            
            % Display warning to user
            warning('SMT:PATHCHK:NoFolder',...
                'Folder %s does not exist.',fullpath)
            
        end
        
        % Split FULLPATH at system FILESEP
        pathParts = split(fullpath,filesep);
        
        % Check whether FULLPATH is absolute or relative
        if startsWith(fullpath,'.')
            
            auxpath = pathParts(2:end);
            
%             clear pathParts;
            
            pathParts = [split(pwd,filesep);auxpath];
            
        elseif strcmp(pathParts{1},'..')
            
            auxpath = pathParts(2:end);
            
            tmppath = split(pwd,filesep);
            
            clear pathParts;
            
            pathParts = [tmppath(1:end-1);auxpath];
            
        end
        
        % Make new folder
        [chkstatus] = makeNewFolder(pathParts);
        
    otherwise
        
        error('SMT:PATHCHK:WrongPath','Path %s contains errors.',fullpath);
        
end

% Function to make new folder
    function [chkstatus] = makeNewFolder(pathParts)
        
        % Get size of FULLPATH
        [npart,~] = size(pathParts);
        
        % Check if any partial path exists
        for ipart = 0:npart-1
            
            if exist(fullfile(pathParts{1:end-ipart}),'dir') == 7
                
                break
                
            end
            
        end
        
        % Make path to parent folder
        parentFolder = fullfile(pathParts{1:end-ipart});
        
        % Make path to new folder
        newFolder = fullfile(pathParts{end-ipart+1:end});
        
        % Retrieve USER.HOME (see also 'help getuserdir')
        userHome = char(java.lang.System.getProperty('user.home'));
        
        % Check if FULLPATH contains USER.HOME
        if contains(parentFolder,userHome)
            
            % Write file
            [chkstatus] = writeFolder(parentFolder,newFolder);
            
        else
            
            % Throw error
            error('SMT:PATHCHK:WrongUser',...
                ['Path specified will write to %s.\n',...
                'Path must write inside %s.\n'],parentFolder,userHome);
            
        end
        
    end

    function [chkstatus] = writeFolder(parent,new)
        
        % Check if PARENT is writable
        [status,val] = fileattrib(parent);
        
        if status && val.UserWrite
            
            if strcmpi(dispmode,'v')
                
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
                makenew = true;
                
                % No error message
                chkstatus = {};
                
            else
                
                % Did not make new folder
                makenew = false;
                
                % Output error message
                chkstatus = {mess,messid};
                
            end
            
        else
            
            % Throw error
            error('SMT:PATHCHK:UserWrite',...
                'User does not have permission to write in %s.\n',val.Name);
            
        end
        
    end

end
