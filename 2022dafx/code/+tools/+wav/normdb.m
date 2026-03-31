function normwav = normdb(wav,dblevel,dbflag)
%NORMDB Normalize wav signal in dB.
%   Y = NORMDB(X,DBLEVEL,DBFLAG) Normalizes the audio in X to DBLEVEL dB
%   power using the scale specified by DBFLAG. DBFLAG = 'PEAK' uses
%   Peak-to-Peak normalization whereas DBFLAG = 'RMS' uses Root-Mean-Square
%   normalization.
%
%   See also PEAKDB, RMSDB.

% 2016 M Caetano; Revised 2019
% 2020 MCaetano SMT 0.1.1 (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,3);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 2
    
    dbflag = 'rms';
    
end

% Check type of input argument
if ~isnumeric(dblevel)
    
    error('SMT:NORMDB:invalidArgument',['Invalid Input Argument.\n'...
        'DBLEVEL must be class NUMERIC not %s.\n'...
        'Type HELP NORMDB for more information.\n'],class(dbflag));
    
end

% Check type of input argument
if ~tools.misc.istext(dbflag)
    
    error('SMT:NORMDB:invalidArgument',['Invalid Input Argument.\n'...
        'DBFLAG must be class CHAR not %s.\n'...
        'Type HELP NORMDB for more information.\n'],class(dbflag));
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check sign of dB level
if dblevel > 0
    
    dblevel = -dblevel;
    
end

% Reference specified by DBFLAG
switch lower(dbflag)
    
    case 'peak'
        
        normlevel = 1/tools.wav.peaklevel(wav);
        
    case 'rms'
        
        normlevel = (sqrt(2)/2)/tools.wav.rmslevel(wav);
        
    otherwise
        
        warning('SMT:NORMDB:invalidArgument',...
            ['DBFLAG must be either PEAK or RMS.\n'...
            'DBFLAG entered was %s.\n'
            'Using default DBFLAG = RMS.\n'],dbflag);
        
        normlevel = (sqrt(2)/2)/tools.wav.rmslevel(wav);
        
end

% Normalize input signal to 0 dB
naudio = wav*normlevel;

% Calculate normalization factor
normfac = tools.math.log2lin(dblevel,'dbp');

% Normalize to DBLEVEL dB
normwav = naudio*normfac;

% Check if data clipped
if tools.wav.peaklevel(normwav) > 1
    
    % Warn about clipping
    warning('SMT:NORMDB:dataClipped',...
        ['Data clipped when normalized to %d dB %s.\n'...
        'Normalizing to 0 dB Peak instead to avoid clipping.'],dblevel,dbflag);
    
    % Normalize to 0 dB Peak
    normwav = tools.wav.normdb(wav,0,'peak');
    
end

end
