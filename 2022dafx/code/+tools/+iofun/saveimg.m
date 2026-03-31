function status = saveimg(fig,fullpath,ext)
%SAVEIMG Save image file.
%   S = SAVEIMG(FIG,FPATH,EXT) saves
%   S == TRUE upon success
%   S == FALSE upon failure with a warning
%
%   See also SAVEWAV

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

valid_format = upper({'fig','jpg','png','eps','pdf','bmp','emf','pbm','pcx',...
    'pgm','ppm','tif'});

try
    
    ext = strip(ext,'left','.');
    
    isFormat = strcmpi(ext,valid_format);
    
    if ~any(isFormat)
        
        error('SMT:SAVEWAV:invalidFileFormat',['Invalid file format\n'...
            'Supported audio file formats are .%s, .%s, .%s, .%s, .%s, '...
            '.%s, .%s, .%s, .%s, .%s, .%s, or .%s\n'...
            'Input format entered was .%s'],valid_format{:},upper(ext));
        
    end
    
    [fpath,fname,fext] = fileparts(fullpath);
    
    [stat,err] = tools.iofun.mknewdir(fpath);
    
    if stat
        
        saveas(fig,fullpath,ext)
        
        status = true;
        
    else
        
        error('SMT:SAVEWAV:ERR',['%s'],err)
        
    end
    
catch ME
    
    warning('SMT:SAVEIMG:saveAsFailed','%s',ME.message)
    
    status = false;
    
end

end

