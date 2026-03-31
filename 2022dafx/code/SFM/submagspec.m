function [ssmagspec,dsnfft] = submagspec(logmagspec,nfft,specwinflag)
%SUBMAGSPEC Downsample log magnitude spectrum.
%
%   [DOWNSAMPLE_LOG_MAG_SPEC,DSNFFT] = SUBMAGSPEC(LMS,NFFT,SPECWINFLAG)

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0


% Main lobe width of (sinusoidal) spectral peak
main_lobe = tools.dsp.infowin(specwinflag,'main_lobe');

% Size of downsampled log spectrum
% dsnfft = 2^nextpow2(nfft/main_lobe);
dsnfft = tools.dsp.fftsize(nfft/main_lobe);

% Initialize
ssmagspec = zeros(dsnfft,1);

ind = 1;

for iss = 1:main_lobe:nfft
    
    ssmagspec(ind) = max(logmagspec(iss:iss+main_lobe-1));
    
    ind = ind + 1;
    
end

end
