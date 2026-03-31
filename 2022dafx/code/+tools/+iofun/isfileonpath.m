function bool = isonpath(queryfile)
%ISINPATH Chech if file is on search path.
%   BOOL = ISINPATH(QUERYFILE) returns TRUE if QUERYFILE can be found on the
%   current search path or FALSE otherwise.
%
%   NOTE: ISONPATH relies on the result of WHICH to determine if QUERYFILE
%   can be found on the search path. Therefore, all files inside the
%   current
%
%   See also ISFUNCTION, ISSCRIPT

% 2020 MCaetano SMT 0.3.1

% Prepend '/' to limit the search to functions that are on the search path
% For example, which('/myfunction') displays the full path for function
% 'myfunction.m', but not built-in or JAVA functions with the same name.
str = strcat('/',queryfile);

% Query /QUERYFILE with which
res = which(str);

if isempty(res)
    
    % File not found
    bool = false;
    
else
    
    % Get the absolute path of QUERYFILE
    abspath = fileparts(res);
    
    if strcmp(abspath,pwd)
        
        % Check if current search path contains QUERYPATH
        bool = tools.iofun.isdironpath(abspath);
        
    else
        
        % File is in the current folder but not on the search path
        bool = true;
        
    end
    
end

end
