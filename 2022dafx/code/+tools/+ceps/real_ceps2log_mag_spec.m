function specenv = real_ceps2log_mag_spec(realceps,nfft)
%REAL_CEPS2LOG_MAG_SPEC Convert real cepstrum to spectral envelope.
%   SPECENV = REAL_CEPS2LOG_MAG_SPEC(RC,NFFT) returns the spectral
%   envelope SPECENV corresponding to the real cepstral coefficients RC
%   transformed with an FFT of size NFFT.
%
%   See also LOG_MAG_SPEC2REAL_CEPS.

% 2021 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,2);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Remove imaginary part due to floating error
specenv = real(fft(realceps,nfft));

end
