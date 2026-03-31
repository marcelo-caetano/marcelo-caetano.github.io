function [centroid,spread,skewness,kurtosis,slope] = spec_shape_descr(amp,freq,fs,typeflag)
%SPEC_SHAPE_DESCR Spectral shape descriptors.
%   [CT,SP,SK,KT] = SPEC_SHAPE_DESCR(A,F,Fs) returns the spectral centroid CT,
%   spectral spread SP, spectral skewness SK, and spectral kurtosis KT of
%   the spectral amplitudes A calculated at the frequencies F. A is amplitude
%   multidimensional array of size NBIN x NFRAME x NCHANNEL, where NBIN is
%   the number of bins of the FFT, NFRAME is the number of FFT frames, and
%   NCHANNEL is the number of channels. F is amplitude column vector with NBIN
%   rows (NBIN x 1).
%
%   [...] = SPEC_SHAPE_DESCR(A,F,Fs,TYPEFLAG) uses the logical flag TYPEFLAG to
%   determine if the amplitudes A are normalized before the calculation.
%   TYPEFLAG = TRUE normalizes and TYPEFLAG = FALSE does not. The default
%   is TYPEFLAG = TRUE. NOTE: TYPEFLAG = TRUE also normalizes the kurtosis
%   by subtracting 3 (the kurtosis of the normal distribution).
%
%   freq = linspace(0,20,1000)';
%   amp = pdf('Gamma',freq,9,.5);
%   [ct,sp,sk,kt] = tools.descr.spec_shape(amp,freq);
%   ct = 4.5; sp = 2.25; sk = 0.667; kt = 3.667;
%
%   See also SPEC_SHAPE_DESCR

% 2022 M Caetano SMT

% TODO: FIX & VECTORIZE SPECTRAL SLOPE
% TODO: FIX HELP

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,4);

% Check number of output arguments
nargoutchk(0,4);

if nargin == 3
    
    typeflag = 1;
    
end

validateattributes(amp,{'numeric'},{'real'},mfilename,'AMP',1)
validateattributes(freq,{'numeric'},{'real'},mfilename,'FREQ',2)
validateattributes(fs,{'numeric'},{'integer'},mfilename,'Fs',3)
validateattributes(typeflag,{'numeric'},{'integer'},mfilename,'TYPEFLAG',4)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch typeflag
    
    case 1
        % Linear Frequency
        % Linear Amplitude
        frequency = freq;
        amplitude = amp;
    case 2
        % Linear Frequency
        % Power Amplitude
        frequency = freq;
        amplitude = amp.^2;
    case 3
        % Linear Frequency
        % Log Amplitude
        frequency = freq;
        amplitude = log10(amp);
    case 4
        % Log Frequency
        % Linear Amplitude
        frequency = log2(freq);
        amplitude = amp;
    case 5
        % Log Frequency
        % Power Amplitude
        frequency = log2(freq);
        amplitude = amp.^2;
    case 6
        % Log Frequency
        % Log Amplitude
        frequency = log2(freq);
        amplitude = log10(amp);
    case 7
        % Mel Frequency
        % Mid Ear Filtered
        mid_ear.frequency 		= [0.0001, 20, 30, 50, 70, 100, 200, 300, 500, 700, 1000, 1250, 1650, 2000, 2500, 2900, 3650, 5000, 8000, 10000, 11025, 24000, 30000];
        mid_ear.amplitude 	= -[99, 39, 26, 18, 15, 12.5, 8, 6, 3.5, 2.75, 2.5, 2.75, 3.5, 8.5, 10.5, 8, 6, 5.5, 11.5, 10, 13, 40, 120];
        att  	= 10.^(interp1(mid_ear.frequency,mid_ear.amplitude,freq)/20);
        frequency = tools.mus.hertz2mel(freq,44100)';
        amplitude = (amp .* att)';
end

normflag = false;
[centroid,spread,skewness,kurtosis] = tools.descr.spec_shape(amplitude,frequency,normflag);

% Spectral slope
% slope = (1/sum_amp)*(nbin*norm_amp*frequency - sum(frequency)*sum(norm_amp)) / (nbin*sum(frequency .^ 2) - (sum(frequency)) ^ 2);
nbin = size(frequency,2);
slope = (1/sum(amplitude)).*(nbin*amplitude.*frequency - sum(frequency).*sum(amplitude)) ./ (nbin*sum(frequency .^ 2) - (sum(frequency)) .^ 2);

end
