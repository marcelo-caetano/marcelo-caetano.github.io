function real_ceps = mag_spec2real_ceps(magspec,nfft,logflag,nanflag)
%MAG_SPEC2REAL_CEPS Real cepstrum from magnitude spectrum.
%   RC = MAG_SPEC2REAL_CEPS(ME,NFFT) returns the real cepstrum
%   corresponding to the magnitude spectrum ME converted with an FFT of
%   size NFFT. RC is size NFFT x NFRAME x NCHANNEL, where NFRAME is the
%   number of STFT frames and NCHANNEL is the number of audio channels. If
%   the number of rows of ME is different from NFFT, RC will be either
%   truncated or zero-padded accordingly by the IFFT function. Type HELP
%   IFFT for further details.
%
%   RC = MAG_SPEC2REAL_CEPS(ME,NFFT,LOG) uses the text flag LOGFLAG in the
%   conversion. LOGFLAG can be 'DBR' for decibel root-power, 'DBP' for
%   decibel power, 'BEL' for bels, 'NEP' for neper, and 'OCT' for octave.
%   See TOOLS.MATH.LIN2LOG for further details. The default is LOGFLAG =
%   'DBP' for the syntax above.
%
%   RC = MAG_SPEC2REAL_CEPS(ME,NFFT,LOG,NANFLAG) uses the logical flag 
%   NANFLAG to handle the case LINMAG = 0. NANFLAG = TRUE replaces 0 with 
%   eps(0) to avoid -Inf in LOGMAG. NANFLAG = FALSE ignores 0 in LINMAG. 
%   Use NANFLAG = TRUE to get numeric values in LOGMAG. NANFLAG defaults to 
%   FALSE for the syntaxes above.
%
%   See also REAL_CEPS2MAG_SPEC, TOOLS.LPC.LIN_PRED2MAG_SPEC

% 2022 M Caetano SMT

% TODO: VALIDATE ARGUMENTS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,4);

% Check number of output arguments
nargoutchk(0,1);

% Default SPECENVFLAG & WINFLAG
if nargin == 2
    
    % dB power
    logflag = 'dbp';
    
    % Allow -Inf in LOGMAGSPEC
    nanflag = false;
    
elseif nargin == 3
    
    % Allow -Inf in LOGMAGSPEC
    nanflag = false;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

logmagspec = tools.math.lin2log(magspec,logflag,nanflag);

real_ceps = tools.ceps.log_mag_spec2real_ceps(logmagspec,nfft);

end
