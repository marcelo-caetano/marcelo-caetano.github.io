function bool = isscript(queryfile)
%ISSCRIPT Check if file is a Matlab script.
%   BOOL = ISSCRIPT(FILENAME) returns BOOL == TRUE when FILENAME is a
%   script and BOOL = FALSE otherwise. A script is an m-file that is not a
%   function.
%
%   See also ISFUNCTION, ISFILETYPE

% 2019 M Caetano
% 2020 MCaetano SMT 0.2.1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,1);

% Check number of output arguments
nargoutchk(0,1);

% Check if FNAME is char
if ~(ischar(queryfile)||isstring(queryfile))
    
    error('MATLAB:ISSCRIPT:InputArgument',['Wrong input argument.\n'...
        'Input argument FILENAME must be class CHAR or STRING.\n']);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION BODY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check that queryfile exists
if exist(queryfile,'file') == 0
    
    error('MATLAB:ISSCRIPT:NotFile',...
        '%s is not found on the Matlab path.\n',queryfile);
    
end

if tools.iofun.isfiletype(queryfile,'.m')
    
    % Script is NOT function
    bool = ~tools.iofun.isfunction(queryfile);
    
else
    
    % Only m-file can be function
    bool = false;
    
end

end
