function status = savewav(wav,fullpath,fs)
%SAVEWAV Save audio file.
%   S = SAVEWAV(WAV,FPATH,EXT)
%   S == TRUE upon success
%   S == FALSE upon failure with a warning
%
%   See also SAVEIMG

% 2022 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(3,3);

% Check number of output arguments
nargoutchk(0,1);

% Attribute FIG not supported
validateattributes(fullpath,{'char','string'},{'scalartext'},mfilename,'FPATH',2)
validateattributes(ext,{'char','string'},{'scalartext'},mfilename,'EXT',3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

valid_format = upper({'wav','ogg','flac'});

try
    
    [fpath,fname,fext] = fileparts(fullpath);
    
    fext = strip(fext,'left','.');
    
    isFormat = strcmpi(fext,valid_format);
    
    if ~any(isFormat)
        
        error('SMT:SAVEWAV:invalidFileFormat',['Invalid file format\n'...
            'Supported audio file formats are .%s, .%s, or .%s\n'...
            'Input format entered was .%s'],valid_format{:},upper(fext));
        
    end
    
    [stat,err] = tools.iofun.mknewdir(fpath);
    
    if stat
        
        audiowrite(fullpath,wav,fs)
        
        status = true;
        
    else
        
        error('SMT:SAVEWAV:ERR',['%s'],err)
        
    end
    
catch ME
    
    warning('SMT:SAVEWAV:audioWriteFailed','%s',ME.message)
    
    status = false;
    
end

end
