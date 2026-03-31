function [sinusoidal,partial,amplitude,frequency,phase] = sinusoidal_resynthesis(amp,freq,ph,framelen,hop,fs,winflag,...
    causalflag,center_frame,npartial,nframe,nchannel,nsample,synthflag,...
    ptrackflag,ptrackalgflag,freqdiff,...
    trackdurflag,durthres,gapthres,dispflag)
%SINUSOIDAL_RESYNTHESIS Resynthesis from the output of sinusoidal analysis [1].
%   [SIN,PART,AMP,FREQ,PH] = SINUSOIDAL_RESYNTHESIS(A,F,P,M,H,Fs,WINFLAG,...
%   CAUSALFLAG,CFR,NPARTIAL,NFRAME,NCHANNEL,NSAMPLE,SYNTHFLAG,...
%   PTRACKFLAG,PTRACKALGFLAG,FREQDIFF,TRACKDURFLAG,DURTHRES,GAPTHRES,DISPFLAG)
%   resynthesizes the sinusoidal model SIN from the output parameters of
%   SINUSOIDAL_ANALYSIS (A,F,P), where A=amplitude, F=frequency, and
%   P=phases estimated with a hop size H and a frame size of M. FREQDIFF
%   determines the maximum frequency difference for peak continuation for
%   PI and PRFI resynthesis in case of no partial tracking.
%
%   See also SINUSOIDAL_ANALYSIS

% 2016 M Caetano
% Revised 2019 (SM 0.1.1)
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0
% 2020 MCaetano SMT 0.2.1
% 2021 M Caetano SMT
% 2022 M Caetano SMT (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(20,21);

% Check number of output arguments
nargoutchk(0,5);

if nargin == 20
    
    dispflag = false;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Sinusoidal Resynthesis')

% Handle partial tracking
if ~ptrackflag && ~trackdurflag
    
    disp('Standard peak-to-peak matching for resynthesis');
    
    if strlength(ptrackalgflag) == 0 || isempty(ptrackalgflag)
        % Peak-to-peak matching
        ptrackalgflag = 'p2p';
    end
    
    [amp,freq,ph,npartial] = partial_tracking(amp,freq,ph,freqdiff,hop,fs,nframe,ptrackalgflag);
    
elseif ~ptrackflag && trackdurflag
    
    disp('Standard peak-to-peak matching for resynthesis');
    
    if strlength(ptrackalgflag) == 0 || isempty(ptrackalgflag)
        % Peak-to-peak matching
        ptrackalgflag = 'p2p';
    end
    
    [amp,freq,ph,npartial] = partial_tracking(amp,freq,ph,freqdiff,hop,fs,nframe,ptrackalgflag);
    
    disp('Minimum duration')
    
    [amp,freq,ph] = partial_track_duration(amp,freq,ph,hop,fs,npartial,nframe,nchannel,durthres,gapthres,'ms');
    
end

% Select resynthesis method
switch lower(synthflag)
    
    case 'ola'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % OVERLAP ADD
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        disp('Overlap-Add Resynthesis')
        
        [sinusoidal,partial,amplitude,frequency,phase] = sinusoidal_resynthesis_OLA...
            (amp,freq,ph,framelen,hop,fs,winflag,nsample,center_frame,npartial,nframe,nchannel,causalflag,dispflag);
        
    case 'pi'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % POLYNOMIAL INTERPOLATION
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        disp('Resynthesis by Polynomial Interpolation')
        
        [sinusoidal,partial,amplitude,frequency,phase] = sinusoidal_resynthesis_PI...
            (amp,freq,ph,framelen,hop,fs,nsample,center_frame,npartial,nframe,causalflag,dispflag);
        
    case 'prfi'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % PHASE RECONSTRUCTION VIA FREQUENCY INTEGRATION
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        disp('Resynthesis by Phase Reconstruction via Frequency Integration')
        
        [sinusoidal,partial,amplitude,frequency,phase] = sinusoidal_resynthesis_PRFI...
            (amp,freq,framelen,hop,fs,nsample,center_frame,npartial,nframe,causalflag,dispflag);
        
    otherwise
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % POLYNOMIAL INTERPOLATION BY DEFAULT
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        warning('SMT:SINUSOIDAL_RESYNTHESIS:NoSynthFlag',['Undefined synthesis flag.\n'...
            'SYNTHFLAG must be OLA, PI, or PRFI.\n'...
            'SYNTHFLAG entered was %s.\n'...
            'Using default PI (polynomial interpolation) synthesis'],synthflag)
        
        disp('Resynthesis by Polynomial Interpolation')
        
        [sinusoidal,partial,amplitude,frequency,phase] = sinusoidal_resynthesis_PI...
            (amp,freq,ph,framelen,hop,fs,nsample,center_frame,npartial,nframe,causalflag,dispflag);
        
end

end
