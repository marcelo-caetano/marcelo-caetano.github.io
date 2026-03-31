function [interp_log_mag_spec,freq] = interpmagspec(ds_log_mag_spec,dsnfft,nfft,fs)
%INTERPMAGSPEC Interpolate magnitude spectrum.
%   [I,F] = INTERPMAGSPEC(D,DSNFFT,NFFT,SR)

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

% Original frequencies
freq = tools.plot.mkfreq(nfft,fs,'full',true);

% Downsampled frequencies
dsfreq = tools.plot.mkfreq(dsnfft,fs,'full',true);

% Linear interpolation
interp_log_mag_spec = interp1(dsfreq,ds_log_mag_spec,freq,'linear');

end
