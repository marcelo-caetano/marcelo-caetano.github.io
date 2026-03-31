function [centroid,spread,skewness,kurtosis] = spec_shape(amp,freq,normflag)
%SPEC_SHAPE Spectral shape descriptors.
%   [CT,SP,SK,KT] = SPEC_SHAPE(A,F) returns the spectral centroid CT,
%   spectral spread SP, spectral skewness SK, and spectral kurtosis KT of
%   the spectral amplitudes A calculated at the frequencies F. A is a
%   multidimensional array of size NBIN x NFRAME x NCHANNEL, where NBIN is
%   the number of bins of the FFT, NFRAME is the number of FFT frames, and
%   NCHANNEL is the number of channels. F is a column vector with NBIN
%   rows (NBIN x 1).
%
%   [...] = SPEC_SHAPE(A,F,NORMFLAG) uses the logical flag NORMFLAG to
%   determine if the amplitudes A are normalized before the calculation.
%   NORMFLAG = TRUE normalizes and NORMFLAG = FALSE does not. The default
%   is NORMFLAG = TRUE. NOTE: NORMFLAG = TRUE also normalizes the kurtosis
%   by subtracting 3 (the kurtosis of the normal distribution).
%
%   freqs = linspace(0,20,1000)';
%   fft_data = pdf('Gamma',freqs,9,.5);
%   [ct,sp,sk,kt] = tools.descr.spec_shape(fft_data,freqs);
%   ct = 4.5; sp = 2.25; sk = 0.667; kt = 3.667;
%
%   See also SPEC_SHAPE_DESCR

% 2022 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,3);

% Check number of output arguments
nargoutchk(0,4);

if nargin == 2
    
    normflag = true;
    
end

validateattributes(amp,{'numeric'},{'real'},mfilename,'AMP',1)
validateattributes(freq,{'numeric'},{'real'},mfilename,'FREQ',2)
validateattributes(normflag,{'numeric','logical'},{'binary'},mfilename,'NORMFLAG',3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if normflag
    
    amp = amp./sum(amp);
    
end

centroid = sum(amp .* freq);

% Centered frequencies
center_freq = freq - centroid;

% spread =  sum(amp .* (freq - centroid).^2);
spread =  sum(amp .* center_freq.^2);

% Normalized centered frequencies
norm_center_freq = center_freq ./ sqrt(spread);

% skewness = sum(amp .* ((freq - centroid)./std_dev).^3);
skewness = sum(amp .* norm_center_freq.^3);

if normflag
    
    % Normalized kurtosis
    % kurtosis = sum(amp .* ((freq - centroid)./std_dev).^4) - 3;
    kurtosis = sum(amp .* norm_center_freq.^4) - 3;
    
else
    
    % Statistical kurtosis
    % kurtosis = sum(amp .* ((freq - centroid)./std_dev).^4);
    kurtosis = sum(amp .* norm_center_freq.^4);
    
end

end
