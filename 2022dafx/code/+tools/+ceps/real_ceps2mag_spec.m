function magspec = real_ceps2mag_spec(rc,nfft,logflag,realflag)
%REAL_CEPS2MAG_SPEC Magnitude spectrum from real cepstrum.
%   ME = REAL_CEPS2MAG_SPEC(RC,NFFT) returns the Magnitude spectrum ME
%   corresponding to the real cepstrum RC converted with an FFT of size
%   NFFT.
%
%   ME = REAL_CEPS2MAG_SPEC(RC,NFFT,LOGFLAG) uses the text flag LOGFLAG in
%   the conversion. LOGFLAG can be 'DBR' for decibel root-power, 'DBP' for
%   decibel power, 'BEL' for bels, 'NEP' for neper, and 'OCT' for octave.
%   See TOOLS.MATH.LIN2LOG for further details. The default is LOGFLAG =
%   'DBP' for the syntax above.
%
%   ME = REAL_CEPS2MAG_SPEC(RC,NFFT,LOGFLAG,REALFLAG) uses the logical flag
%   REALFLAG to ensure ME has no imaginary component due to floating point
%   conversions. REALFLAG = TRUE forces ME to be real and REALFLAG = FALSE
%   does not. The default is REALFLAG = TRUE.
%
%   See also MAG_SPEC2REAL_CEPS, REAL_CEPS2LIN_PRED

% 2022 M Caetano SMT

% TODO: VALIDATE ARGUMENTS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,4);

% Check number of output arguments
nargoutchk(0,1);

% Default LOGFLAG & REALFLAG
if nargin == 2
    
    % dB power
    logflag = 'dbp';
    
    % Force SPEC_ENV to be real
    realflag = true;
    
elseif nargin == 3
    
    % Force SPEC_ENV to be real
    realflag = true;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

logmagspec = tools.ceps.real_ceps2log_mag_spec(rc,nfft);

magspec = tools.math.log2lin(logmagspec,logflag,realflag);

end
