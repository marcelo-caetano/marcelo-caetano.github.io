function rc = log_mag_spec2real_ceps(specenv,nfft)
%LOG_MAG_SPEC2REAL_CEPS Convert spectral envelope to real cepstrum.
%   RC = LOG_MAG_SPEC2REAL_CEPS(SPECENV,NFFT) returns the real
%   cepstral coefficients RC corresponding to the spectral envelope SPECENV
%   transformed with an FFT of size NFFT.
%
%   See also REAL_CEPS2LOG_MAG_SPEC

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

% Remove imaginary part due to floating point error
rc = real(ifft(specenv,nfft));

end
