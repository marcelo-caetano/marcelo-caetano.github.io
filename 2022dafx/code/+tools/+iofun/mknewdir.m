function [status,errmsg] = mknewdir(dirpath,dispflag)
%MKNEWDIR Make new folder when folder does not exist.
%   MKNEWDIR(P) checks if the folder specified by P exists. If the folder P
%   does not exist, MKNEWDIR creates the new folder.
%   P is a character vector with either a relative or an absolute path.
%
%   A relative path starts with . or .. so P is expanded as [PWD; P].
%   Relative paths must be in the search path.
%
%   Absolute paths start from the root directory and MKNEWDIR decomposes
%   P = [PARENT; NEW], where PARENT must be a valid path inside USER.HOME
%   returned by the JAVA method java.lang.System.getProperty('user.home')
%   and the current user must have write permission inside PARENT.
%
%   MKNEWDIR(P,DISPFLAG) allows to specify DISPFLAG as a char 'v': verbose
%   or 's': silent. If DISPFLAG is not provided, DISPFLAG defaults to 's'.
%
%   [S,ERR] = MKNEWDIR(...) returns the status S and ERR. S == TRUE when a
%   new folder is created and FALSE otherwise. ERR returns the error
%   message in a cell string. ERR is empty when MKNEWDIR encounters no
%   errors.
%
%   EXAMPLE 1: Relative path
%
%   p = fullfile('.','tmp');
%   nf = MKNEWDIR(p,'v');
%
%   EXAMPLE 2: Relative path
%
%   p = fullfile('..','tmp');
%   nf = MKNEWDIR(p,'v');
%
%   EXAMPLE 3: Absolute path
%
%   p = fullfile(pwd,'myfolder','tmp');
%   [nf,s] = MKNEWDIR(p,'v');
%
%   See also ISROOT, ROOTDIR

% M Caetano 2019
% 2022 M Caetano SMT (Revised)

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
            warning('SMT:MKNEWDIR:ExistingDir',['Existing dir\n',...
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
        
        [status,msg,msgID] = mkdir(dirpath);
        
        errmsg = msg;
        
    otherwise
        
        % Never reaches this line
        error('SMT:MKNEWDIR:InvalidPath',['Invalid path\n',...
            'Path %s contains errors.'],dirpath);
        
end

end
