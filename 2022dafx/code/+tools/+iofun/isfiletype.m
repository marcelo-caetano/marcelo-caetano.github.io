function bool = isfiletype(filename,ftype)
%ISFILETYPE Check filetype using file extension.
%   B = ISFILETYPE(FNAME,FTYPE) returns boolean TRUE if FNAME has extension
%   matching FTYPE. ISFILETYPE returns FALSE otehrwise. FNAME can be a
%   relative or absolute path. FNAME can have the file extension or not.
%   FTYPE can either be preceded by a dot or not. FTYPE is case
%   insensitive.
%
%   EXAMPLE 1: Relative path
%
%   B = tools.iofun.isfiletype('','.M')
%
%   See also ISSCRIPT, ISFUNCTION

% 2019 M Caetano
% 2020 MCaetano SMT 0.2.1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,2);

% Check number of output arguments
nargoutchk(0,1);

% Check if FNAME is char
if ~(ischar(filename)||isstring(filename))
    
    error('MATLAB:ISFILETYPE:InputArgument',...
        'Input argument FILENAME must be class CHAR');
    
end

% Check if FTYPE is char
if ~(ischar(ftype)||isstring(ftype))
    
    error('MATLAB:ISFILETYPE:InputArgument',...
        'Input argument FTYPE must be class CHAR');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION BODY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check file type
existflag = exist(filename,'file');

% Check that filename exists
if existflag == 0
    
    error('MATLAB:ISFILETYPE:NotFile',...
        '%s is not on the Matlab path.\n',filename);
    
end

% If FNAME is a file (exist 2,3,6)
if ~any(existflag == [2 3 6])
    
    error('MATLAB:ISFILETYPE:NotFile',...
        '%s is not a file.\n',filename);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK IF FILENAME IS FILETYPE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get file extension
[~,~,fext] = fileparts(filename);

% If FEXT is empty
if isempty(fext)||fext==""
    
    [~,~,fext] = fileparts(which(filename));
    
end

% Check that ftype starts with "."
if ~startsWith(ftype,".")
    
    ftype = strcat(".",ftype);
    
end

% Check if FEXT is FTYPE
if strcmpi(fext,ftype)
    
    bool = true;
    
else
    
    bool = false;
    
end

end
