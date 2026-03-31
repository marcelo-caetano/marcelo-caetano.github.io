function dirlist = nlistdir(querydir,depth,classflag)
%NLISTDIR List dir n-level deep.
%   L = NLISTDIR(QUERYDIR,NLEVEL)
%
%   See also RSF, RSD

% 2020 MCaetano SMT 0.3.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,3);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 1
    
    % Default depth
    depth = 1;
    
    % Default class of output
    classflag = 'default';
    
end

if nargin == 2
    
    % Default class of output
    classflag = 'default';
    
end

% Check class of input argument QUERYDIR
if ~(ischar(querydir)||isstring(querydir))
    
    error('MATLAB:NLISTDIR:InputArgument',['Wrong Type of Input Argument.\n'...
        'QUERYDIR must be class CHAR or STRING.\n'...
        'Input was %s.\n'],class(querydir));
    
end

% Check class of input argument DEPTH
if ~isnumeric(depth)
    
    error('MATLAB:NLISTDIR:InputArgument',['Wrong Type of Input Argument.\n'...
        'DEPTH must be numeric.\n'...
        'Input was %s.\n'],class(depth));
    
end

% Check class of input argument CLASSFLAG
if ~(ischar(classflag)||isstring(classflag))
    
    error('MATLAB:NLISTDIR:InputArgument',['Wrong Type of Input Argument.\n'...
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
dirlist = initfun(0);

% Initialize partial list
partialList = string(querydir);

% Initialize auxiliary list
auxList = strings(0);

for idepth = 1:depth
    
    % Number of dir
    [ndir,~] = size(partialList);
    
    % For each dir
    for idir = 1:ndir
        
        % List dir inside partialList
        aux = listdir(partialList(idir,1));
        
        if ~isempty(aux)
            
            % Concatenate to partial list of dir
            auxList = [auxList;aux];
            
        end
        
    end
    
    % Update partial list
    partialList = auxList;
    
    
end

% Update final list of dir
dirlist = partialList;

% End of main function
end

function list = listdir(querydir)

dirlist = dir(querydir);

[ndir,~] = size(dirlist);

list = strings(ndir,1);

for idir = 1:ndir
    
    % If DIRLIST(idir) is dir and not '.' nor '..'
    if dirlist(idir).isdir && ~any(strcmp(dirlist(idir).name,["." ".."]))
        
        % Add to list
        list(idir,1) = fullfile(querydir,dirlist(idir).name);
        
    end
    
end

bool = ~strcmp(list,"");

list = list(bool);

%End of private function
end
