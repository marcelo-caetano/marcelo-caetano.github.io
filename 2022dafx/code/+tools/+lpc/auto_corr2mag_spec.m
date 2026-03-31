function mag_spec = auto_corr2mag_spec(acorr_coeff,nfft,biasflag,posspecflag,nrgflag)
%AUTO_CORR2MAG_SPEC Magnitude spectrum from autocorrelation coefficients.
%   MS = AUTO_CORR2MAG_SPEC(ACORR,NFFT,BIASFLAG) returns the magnitude spectrum MS
%   corresponding to the autocorrelation coefficients ACORR converted
%   with an FFT of size NFFT. The conversion is MS = SQRT(ABS(FFT(MS,NFFT))).
%   The logical flag BIASFLAG determines the type of autocorrelation coefficients
%   used. BIASFLAG = TRUE uses biased autocorrelation coefficients for stochastic
%   processes and BIASFLAG = FALSE uses unbiased (raw) autocorrelation coefficients
%   for deterministic signals.
%
%   MS = AUTO_CORR2MAG_SPEC(ACORR,NFFT,POSSPECFLAG) uses the logical flag
%   POSSPECFLAG to determine if MS contains only the positive frequency
%   range or full frequency range. POSSPECFLAG = TRUE outputs the
%   __positive__ frequency range and POSSPECFLAG = FALSE outputs the full
%   frequency range. The default is POSSPECFLAG = FALSE.
%
%   MS = AUTO_CORR2MAG_SPEC(ACORR,NFFT,POSSPECFLAG,NRGFLAG) uses the logical
%   flag NRGFLAG to determine if MS contains the spectral energy of the
%   negative frequencies added to the positive energy. NRGFLAG = TRUE add
%   the negative spectral energy to MS and NRGFLAG = FALSE does not. The
%   default is NRGFLAG = FALSE. The functionality of NRGFLAG depends on
%   POSSPECFLAG = TRUE. NRGFLAG is ignored with a warning when
%   POSSPECFLAG = FALSE.
%
%   See also AUTO_CORR2MAG_SPEC

% 2022 M Caetano SMT

% TODO: Validate inputs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(3,5);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 3
    
    posspecflag = false;
    
    nrgflag = false;
    
elseif nargin == 4
    
    nrgflag = false;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fom BIASED to RAW autocorrelation coefficients
% Biased AUTOCORR: Random (stochastic) process
% Raw AUTOCORR: Deterministic signal
if biasflag
    
    acorr_coeff = nfft*acorr_coeff;
    
end

% Power spectral density: PSD = abs(S).^2
powmagspec = abs(fft(acorr_coeff,nfft));

% PSD -> MAG_SPEC
mag_spec = sqrt(powmagspec);

if posspecflag
    
    % Return positive spectrum
    mag_spec = tools.fft2.full_spec2pos_spec(mag_spec,nfft,nrgflag);
    
end

end
