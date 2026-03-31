function nbin = neg_freq_band(nfft)
%NEG_FREQ_BAND Negative frequency band.
%   NB = NEG_FREQ_BAND(NFFT) returns the length of the negative frequency
%   band in bins of a spectrum obtained with an FFT of size NFFT.
%   NB = NFFT/2-1, so NB excludes the zero frequency and Nyquist frequency
%   bins, which are part of the positive half.
%
%   See also POS_FREQ_BAND, NYQBIN, FFTFLIP, IFFTFLIP, LEFTWIN, RIGHTWIN

% 2020 MCaetano SMT 0.1.1
% 2021 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,1);

% Check number of output arguments
nargoutchk(0,1);

% Validate NFFT
validateattributes(nfft,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NFFT',1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Length of negative frequency band
nbin = nfft - tools.spec.pos_freq_band(nfft);

end
