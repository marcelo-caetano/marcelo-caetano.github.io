% UNIT TEST FFT2 CONVERSION FUNCTIONS

% WARNING! Command to run UnitTest: res = runtests('tools.fft2.test.tools_fft2_unit_test')

%TODO: STEREO SOUND

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHARED VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sampling rate
fs = 16000;
% Fundamental frequency
f0 = 4100;
% Phase shift
phi = pi/12;
% Amplitude
amp = 1;
% Signal length nsample
nsample = 16000;
% Time samples
time_sample = tools.plot.mktime(nsample,fs);
% Waveform (channels)
wav_left = amp*cos(2*pi*f0.*time_sample + phi);
wav_right = amp*cos(2*pi*f0.*time_sample - phi);
% Stereo
wav = [wav_left,wav_right];

% Tolerance for floating point conversion
tol = 1e-13;

framelen = tools.dsp.framesize(f0,fs,4);
hop = tools.dsp.hopsize(framelen,0.5);
nfft = tools.dsp.fftsize(framelen);
winflag = 3;

% Full spectrum
[spec,~,~,nframe,nchannel] = tools.stft.stft(wav,framelen,hop,nfft,winflag,'non');
% nframe = tools.dsp.numframe(nsample,framelen,hop,'non');
magspec = abs(spec);

% Positive spectrum
posspec = spec(1:nfft/2+1,:,:);

posspec_nrg = posspec;
posspec_nrg(2:nfft/2,:,:) = 2*posspec(2:nfft/2,:,:);

% Positive magnitude spectrum
posmagspec = magspec(1:nfft/2+1,:,:);

posmagspec_nrg = abs(posspec_nrg);

% Phase spectrum
phspec = angle(spec);

posphspec = phspec(1:nfft/2+1,:,:);

phspec_unwrap = unwrap(phspec);

posphspec_unwrap = phspec_unwrap(1:nfft/2+1,:,:);

% Log magnitude spectrum
logmagspec = 20*log10(magspec);

poslogmagspec = 20*log10(posmagspec);

poslogmagspec_nrg = 20*log10(posmagspec_nrg);

logmagspec_root = 10*log10(magspec);

logmagspec_bell = log10(magspec);

logmagspec_neper = log(magspec);

logmagspec_octave = log2(magspec);

% NANFLAG LOG
spec_nan = spec;
spec_nan(1,:,:) = zeros(1,nframe,nchannel);

magspec_nan = magspec;
magspec_nan(1,:,:) = zeros(1,nframe,nchannel);

logmagspec_inf = 20*log10(magspec_nan);

magspec_eps = magspec_nan;
magspec_eps(magspec_nan==0) = eps(0);

logmagspec_nan = 20*log10(magspec_eps);

% Power magnitude spectrum
pow2magspec = magspec.^2;

pospow2magspec = posmagspec.^2;

pospow2magspec_nrg = posmagspec_nrg.^2;

pow = 0.212864;
powmagspec = magspec.^pow;

pospowmagspec = posmagspec.^pow;

pospowmagspec_nrg = posmagspec_nrg.^pow;

% NANFLAG POW
pow2magspec_inf = magspec_nan.^(-2);

pow2magspec_nan = pow2magspec_inf;
pow2magspec_nan(isinf(pow2magspec_inf)) = realmax;

%% Test 1: tools.fft2.full_spec2pos_spec

% fft spectrum: 1 input argument
assert(isequal(posspec,tools.fft2.full_spec2pos_spec(spec)))

% fft spectrum: 2 input arguments
assert(isequal(posspec,tools.fft2.full_spec2pos_spec(spec,nfft)))

% fft spectrum: 2 input arguments (wrong NFFT)
assert(isequal(posspec,tools.fft2.full_spec2pos_spec(spec,nfft-3)))

% fft spectrum: 3 input arguments (no negative spectral energy)
assert(isequal(posspec,tools.fft2.full_spec2pos_spec(spec,nfft,false)))

% fft spectrum: 3 input arguments (add negative spectral energy)
assert(isequal(posspec_nrg,tools.fft2.full_spec2pos_spec(spec,nfft,true)))

% WARNING! Does it make sense for isolated magnitude?

% magnitude spectrum: 1 input argument
assert(isequal(posmagspec,tools.fft2.full_spec2pos_spec(magspec)))

% magnitude spectrum: 2 input arguments
assert(isequal(posmagspec,tools.fft2.full_spec2pos_spec(magspec,nfft)))

% magnitude spectrum: 2 input arguments (wrong NFFT)
assert(isequal(posmagspec,tools.fft2.full_spec2pos_spec(magspec,nfft-3)))

% magnitude spectrum: 3 input arguments (no negative spectral energy)
assert(isequal(posmagspec,tools.fft2.full_spec2pos_spec(magspec,nfft,false)))

% magnitude spectrum: 3 input arguments (add negative spectral energy)
assert(isequal(posmagspec_nrg,tools.fft2.full_spec2pos_spec(magspec,nfft,true)))

% WARNING! Does it make sense for isolated phase?

% phase spectrum: 1 input argument
assert(isequal(posphspec,tools.fft2.full_spec2pos_spec(phspec)))

% phase spectrum: 2 input arguments
assert(isequal(posphspec,tools.fft2.full_spec2pos_spec(phspec,nfft)))

% phase spectrum: 2 input arguments (wrong NFFT)
assert(isequal(posphspec,tools.fft2.full_spec2pos_spec(phspec,nfft-3)))

% phase spectrum: 3 input arguments (no negative spectral energy)
assert(isequal(posphspec,tools.fft2.full_spec2pos_spec(phspec,nfft,false)))

%% Test 2: tools.fft2.pos_spec2full_spec

% fft spectrum: 1 input argument
assert(isequal(spec,tools.fft2.pos_spec2full_spec(posspec)))

% fft spectrum: 2 input arguments
assert(isequal(spec,tools.fft2.pos_spec2full_spec(posspec,nfft)))

% fft spectrum: 2 input arguments (wrong NFFT)
assert(isequal(spec,tools.fft2.pos_spec2full_spec(posspec,nfft-3)))

% fft spectrum: 3 input arguments (no negative spectral energy)
assert(isequal(spec,tools.fft2.pos_spec2full_spec(posspec,nfft,false)))

% fft spectrum: 3 input arguments (add negative spectral energy)
assert(isequal(spec,tools.fft2.pos_spec2full_spec(posspec_nrg,nfft,true)))

%% Test 3: tools.fft2.fft2mag_spec

assert(isequal(magspec,tools.fft2.fft2mag_spec(spec)))

%% Test 4: tools.fft2.fft2phase_spec

% 1 input argument
assert(isequal(phspec,tools.fft2.fft2phase_spec(spec)))

%% Test 5: tools.fft2.fft2pos_mag_spec

% 1 input argument
assert(isequal(posmagspec,tools.fft2.fft2pos_mag_spec(spec)))

% 2 input arguments
assert(isequal(posmagspec,tools.fft2.fft2pos_mag_spec(spec,nfft)))

% 2 input arguments (wrong NFFT)
assert(isequal(posmagspec,tools.fft2.fft2pos_mag_spec(spec,nfft-3)))

% 3 input arguments (no negative spectral energy)
assert(isequal(posmagspec,tools.fft2.fft2pos_mag_spec(spec,nfft,false)))

% 3 input arguments (add negative spectral energy)
assert(isequal(posmagspec_nrg,tools.fft2.fft2pos_mag_spec(spec,nfft,true)))

%% Test 6: tools.fft2.fft2pos_phase_spec

% 1 input argument
assert(isequal(posphspec,tools.fft2.fft2pos_phase_spec(spec)))

% 2 input arguments
assert(isequal(posphspec,tools.fft2.fft2pos_phase_spec(spec,nfft)))

% 2 input arguments (wrong NFFT)
assert(isequal(posphspec,tools.fft2.fft2pos_phase_spec(spec,nfft-3)))

%% Test 7: tools.fft2.fft2lin_mag_spec

% 1 input argument
assert(isequal(magspec,tools.fft2.fft2lin_mag_spec(spec)))

% 2 input arguments
assert(isequal(magspec,tools.fft2.fft2lin_mag_spec(spec,nfft)))

% 2 input arguments (wrong NFFT)
assert(isequal(magspec,tools.fft2.fft2lin_mag_spec(spec,nfft-3)))

% 3 input arguments (full fft spectrum)
assert(isequal(magspec,tools.fft2.fft2lin_mag_spec(spec,nfft,false)))

% 3 input arguments (positive fft spectrum)
assert(isequal(posmagspec,tools.fft2.fft2lin_mag_spec(spec,nfft,true)))

% 4 input arguments (full fft spectrum & no negative spectral energy)
assert(isequal(magspec,tools.fft2.fft2lin_mag_spec(spec,nfft,false,false)))

% 4 input arguments (full fft spectrum & add negative spectral energy)
% Generates WARNING & overrides POSSPECFLAG
assert(isequal(posmagspec_nrg,tools.fft2.fft2lin_mag_spec(spec,nfft,false,true)))

% 4 input arguments (positive fft spectrum & no negative spectral energy)
assert(isequal(posmagspec,tools.fft2.fft2lin_mag_spec(spec,nfft,true,false)))

% 4 input arguments (positive fft spectrum & add negative spectral energy)
assert(isequal(posmagspec_nrg,tools.fft2.fft2lin_mag_spec(spec,nfft,true,true)))

%% Test 8: tools.fft2.fft2log_mag_spec

% 1 input argument
assert(isequal(logmagspec,tools.fft2.fft2log_mag_spec(spec)))

% 2 input arguments
assert(isequal(logmagspec,tools.fft2.fft2log_mag_spec(spec,nfft)))

% 2 input arguments (wrong NFFT)
assert(isequal(logmagspec,tools.fft2.fft2log_mag_spec(spec,nfft-3)))

% 3 input arguments (dB power)
assert(isequal(logmagspec,tools.fft2.fft2log_mag_spec(spec,nfft,'dbp')))

% 3 input arguments (dB root-power)
assert(isequal(logmagspec_root,tools.fft2.fft2log_mag_spec(spec,nfft,'dbr')))

% 3 input arguments (bel)
assert(isequal(logmagspec_bell,tools.fft2.fft2log_mag_spec(spec,nfft,'bel')))

% 3 input arguments (neper)
assert(isequal(logmagspec_neper,tools.fft2.fft2log_mag_spec(spec,nfft,'nep')))

% 3 input arguments (octave)
assert(isequal(logmagspec_octave,tools.fft2.fft2log_mag_spec(spec,nfft,'oct')))

% 4 input arguments (full fft spectrum)
assert(isequal(logmagspec,tools.fft2.fft2log_mag_spec(spec,nfft,'dbp',false)))

% 4 input arguments (positive fft spectrum)
assert(isequal(poslogmagspec,tools.fft2.fft2log_mag_spec(spec,nfft,'dbp',true)))

% 5 input arguments (no negative spectral energy)
assert(isequal(poslogmagspec,tools.fft2.fft2log_mag_spec(spec,nfft,'dbp',true,false)))

% 5 input arguments (add negative spectral energy)
assert(isequal(poslogmagspec_nrg,tools.fft2.fft2log_mag_spec(spec,nfft,'dbp',true,true)))

% 5 input arguments (add negative spectral energy trying to force full fft spectrum)
assert(isequal(poslogmagspec_nrg,tools.fft2.fft2log_mag_spec(spec,nfft,'dbp',false,true)))

% 6 input arguments (don't replace -Inf)
assert(isequal(logmagspec_inf,tools.fft2.fft2log_mag_spec(spec_nan,nfft,'dbp',false,false,false)))

% 6 input arguments (replace -Inf)
assert(isequal(logmagspec_nan,tools.fft2.fft2log_mag_spec(spec_nan,nfft,'dbp',false,false,true)))

%% Test 9: tools.fft2.fft2unwrapped_phase_spec

% 1 input argument
assert(isequal(phspec_unwrap,tools.fft2.fft2unwrapped_phase_spec(spec)))

% 2 input arguments
assert(isequal(phspec_unwrap,tools.fft2.fft2unwrapped_phase_spec(spec,nfft)))

% 2 input arguments (wrong NFFT)
assert(isequal(phspec_unwrap,tools.fft2.fft2unwrapped_phase_spec(spec,nfft-3)))

% 3 input arguments (full frequency phase spectrum)
assert(isequal(phspec_unwrap,tools.fft2.fft2unwrapped_phase_spec(spec,nfft,false)))

% 3 input arguments (positive frequency phase spectrum)
assert(isequal(posphspec_unwrap,tools.fft2.fft2unwrapped_phase_spec(spec,nfft,true)))

%% Test 10: tools.fft2.fft2pow_mag_spec

% 1 input argument
assert(isequal(pow2magspec,tools.fft2.fft2pow_mag_spec(spec)))

% 2 input arguments
assert(isequal(pow2magspec,tools.fft2.fft2pow_mag_spec(spec,nfft)))

% 2 input arguments (wrong NFFT)
assert(isequal(pow2magspec,tools.fft2.fft2pow_mag_spec(spec,nfft-3)))

% 3 input arguments
assert(isequal(pow2magspec,tools.fft2.fft2pow_mag_spec(spec,nfft,2)))

% 3 input arguments (rational power)
assert(isequal(powmagspec,tools.fft2.fft2pow_mag_spec(spec,nfft,pow)))

% 4 input arguments (full fft spectrum)
assert(isequal(pow2magspec,tools.fft2.fft2pow_mag_spec(spec,nfft,2,false)))

% 4 input arguments (full fft spectrum rational power)
assert(isequal(powmagspec,tools.fft2.fft2pow_mag_spec(spec,nfft,pow,false)))

% 4 input arguments (positive fft spectrum)
assert(isequal(pospow2magspec,tools.fft2.fft2pow_mag_spec(spec,nfft,2,true)))

% 4 input arguments (positive fft spectrum rational power)
assert(isequal(pospowmagspec,tools.fft2.fft2pow_mag_spec(spec,nfft,pow,true)))

% 5 input arguments (no negative energy)
assert(isequal(pospow2magspec,tools.fft2.fft2pow_mag_spec(spec,nfft,2,true,false)))

% 5 input arguments (no negative energy rational power)
assert(isequal(pospowmagspec,tools.fft2.fft2pow_mag_spec(spec,nfft,pow,true,false)))

% 5 input arguments (add negative energy)
assert(isequal(pospow2magspec_nrg,tools.fft2.fft2pow_mag_spec(spec,nfft,2,true,true)))

% 5 input arguments (add negative energy rational power)
assert(isequal(pospowmagspec_nrg,tools.fft2.fft2pow_mag_spec(spec,nfft,pow,true,true)))

% 6 input arguments (don't replace Inf in power spectrum)
assert(isequal(pow2magspec_inf,tools.fft2.fft2pow_mag_spec(spec_nan,nfft,-2,false,false,false)))

% 6 input arguments (replace Inf in power spectrum)
assert(isequal(pow2magspec_nan,tools.fft2.fft2pow_mag_spec(spec_nan,nfft,-2,false,false,true)))

%%%%%%%%%%%%%%%%%%%%%
% BACK AND FORTH
%%%%%%%%%%%%%%%%%%%%%

%% Test 11: full to pos back to full

% FFT spectrum: 1 input argument
assert(isequal(spec,tools.fft2.pos_spec2full_spec(tools.fft2.full_spec2pos_spec(spec))))

% FFT spectrum: 2 input arguments
assert(isequal(spec,tools.fft2.pos_spec2full_spec(tools.fft2.full_spec2pos_spec(spec,nfft),nfft)))

% FFT spectrum: 2 input arguments (wrong NFFT)
assert(isequal(spec,tools.fft2.pos_spec2full_spec(tools.fft2.full_spec2pos_spec(spec,nfft-3),nfft-3)))

% FFT spectrum: 3 input arguments (no spectral energy)
assert(isequal(spec,tools.fft2.pos_spec2full_spec(tools.fft2.full_spec2pos_spec(spec,nfft,false),nfft,false)))

% FFT spectrum: 3 input arguments (add spectral energy)
assert(isequal(spec,tools.fft2.pos_spec2full_spec(tools.fft2.full_spec2pos_spec(spec,nfft,true),nfft,true)))

%% Test 12: pos to full back to pos

% FFT spectrum: 1 input argument
assert(isequal(posspec,tools.fft2.full_spec2pos_spec(tools.fft2.pos_spec2full_spec(posspec))))

% FFT spectrum: 2 input arguments
assert(isequal(posspec,tools.fft2.full_spec2pos_spec(tools.fft2.pos_spec2full_spec(posspec,nfft),nfft)))

% FFT spectrum: 2 input arguments (wrong NFFT)
assert(isequal(posspec,tools.fft2.full_spec2pos_spec(tools.fft2.pos_spec2full_spec(posspec,nfft-3),nfft-3)))

% FFT spectrum: 3 input arguments (no spectral energy)
assert(isequal(posspec,tools.fft2.full_spec2pos_spec(tools.fft2.pos_spec2full_spec(posspec,nfft,false),nfft,false)))

% FFT spectrum: 3 input arguments (add spectral energy)
assert(isequal(posspec,tools.fft2.full_spec2pos_spec(tools.fft2.pos_spec2full_spec(posspec,nfft,true),nfft,true)))

%% Test 13: tools.fft2.fft2scaled_mag_spec

pow = 1;
logflag = 'dbp';

posspecflag = false;
nrgflag = false;

% Nearest neighbor estimation
assert(isequal(magspec,tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'nne',posspecflag,nrgflag)))

% Linear scale quadratic interpolation estimation
assert(isequal(magspec,tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'lin',posspecflag,nrgflag)))

% Log scale quadratic interpolation estimation
assert(isequal(logmagspec,tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'log',posspecflag,nrgflag)))

posspecflag = true;
nrgflag = false;

% Nearest neighbor estimation
assert(isequal(posmagspec,tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'nne',posspecflag,nrgflag)))

% Linear scale quadratic interpolation estimation
assert(isequal(posmagspec,tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'lin',posspecflag,nrgflag)))

% Log scale quadratic interpolation estimation
assert(isequal(poslogmagspec,tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'log',posspecflag,nrgflag)))

posspecflag = true;
nrgflag = true;

% Nearest neighbor estimation
assert(isequal(posmagspec_nrg,tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'nne',posspecflag,nrgflag)))

% Linear scale quadratic interpolation estimation
assert(isequal(posmagspec_nrg,tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'lin',posspecflag,nrgflag)))

% Log scale quadratic interpolation estimation
assert(isequal(poslogmagspec_nrg,tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'log',posspecflag,nrgflag)))

framelen = 512;
pow = xqifft(framelen,winflag);
hop = tools.dsp.hopsize(framelen,0.5);
nfft = tools.dsp.fftsize(framelen);
[spec,~,~,nframe,nchannel] = tools.stft.stft(wav,framelen,hop,nfft,winflag,'non');
magspec = abs(spec);
powmagspec = magspec.^pow;
posspec = spec(1:nfft/2+1,:,:);
posmagspec = abs(posspec);
pospowmagspec = posmagspec.^pow;
posspec_nrg = posspec;
posspec_nrg(2:nfft/2,:,:) = 2*posspec(2:nfft/2,:,:);
posmagspec_nrg = abs(posspec_nrg);
pospowmagspec_nrg = posmagspec_nrg.^pow;

posspecflag = false;
nrgflag = false;

% Power scale quadratic interpolation estimation
assert(isequal(powmagspec,tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'pow',posspecflag,nrgflag)))

posspecflag = true;
nrgflag = false;

% Power scale quadratic interpolation estimation
assert(isequal(pospowmagspec,tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'pow',posspecflag,nrgflag)))

posspecflag = true;
nrgflag = true;

% Power scale quadratic interpolation estimation
assert(isequal(pospowmagspec_nrg,tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'pow',posspecflag,nrgflag)))

%% Test 14: tools.fft2.scaled_mag_spec2lin_mag_spec

pow = 1;
logflag = 'dbp';

% Nearest neighbor estimation
assert(isequal(posmagspec_nrg,tools.fft2.scaled_mag_spec2lin_mag_spec(posmagspec_nrg,pow,logflag,'nne')))

% Linear scale quadratic interpolation estimation
assert(isequal(posmagspec_nrg,tools.fft2.scaled_mag_spec2lin_mag_spec(posmagspec_nrg,pow,logflag,'lin')))

% Conversion difference
float_diff = posmagspec_nrg - tools.fft2.scaled_mag_spec2lin_mag_spec(poslogmagspec_nrg,pow,logflag,'log');

% Log scale quadratic interpolation estimation
assert(all(float_diff(:)<tol))

framelen = 512;
hop = tools.dsp.hopsize(framelen,0.5);
nfft = tools.dsp.fftsize(framelen);
[spec,~,~,nframe,nchannel] = tools.stft.stft(wav,framelen,hop,nfft,winflag,'non');
magspec = abs(spec);
posspec = spec(1:nfft/2+1,:,:);
posspec_nrg = posspec;
posspec_nrg(2:nfft/2,:,:) = 2*posspec(2:nfft/2,:,:);
posmagspec = magspec(1:nfft/2+1,:,:);
posmagspec_nrg = abs(posspec_nrg);
pow = xqifft(framelen,winflag);
pospowmagspec_nrg = posmagspec_nrg.^pow;

% Conversion difference
float_diff = posmagspec_nrg - tools.fft2.scaled_mag_spec2lin_mag_spec(pospowmagspec_nrg,pow,logflag,'pow');

% Power scale quadratic interpolation estimation
assert(all(float_diff(:)<tol))

%% Test 15: scale and revert

pow = 1;
logflag = 'dbp';
posspecflag = true;
nrgflag = true;

% Nearest neighbor estimation
assert(isequal(posmagspec_nrg,tools.fft2.scaled_mag_spec2lin_mag_spec(tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'nne',posspecflag,nrgflag),pow,logflag,'nne')))

% Linear scale quadratic interpolation estimation
assert(isequal(posmagspec_nrg,tools.fft2.scaled_mag_spec2lin_mag_spec(tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'lin',posspecflag,nrgflag),pow,logflag,'lin')))

% Conversion difference
float_diff = posmagspec_nrg - tools.fft2.scaled_mag_spec2lin_mag_spec(tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'log',posspecflag,nrgflag),pow,logflag,'log');

% Log scale quadratic interpolation estimation
assert(all(float_diff(:)<tol))

framelen = 512;
hop = tools.dsp.hopsize(framelen,0.5);
nfft = tools.dsp.fftsize(framelen);
[spec,~,~,nframe,nchannel] = tools.stft.stft(wav,framelen,hop,nfft,winflag,'non');
magspec = abs(spec);
posspec = spec(1:nfft/2+1,:,:);
posspec_nrg = posspec;
posspec_nrg(2:nfft/2,:,:) = 2*posspec(2:nfft/2,:,:);
posmagspec = magspec(1:nfft/2+1,:,:);
posmagspec_nrg = abs(posspec_nrg);
pow = xqifft(framelen,winflag);
pospowmagspec_nrg = posmagspec_nrg.^pow;

% Conversion difference
float_diff = posmagspec_nrg - tools.fft2.scaled_mag_spec2lin_mag_spec(tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'pow',posspecflag,nrgflag),pow,logflag,'pow');

% Power scale quadratic interpolation estimation
assert(all(float_diff(:)<tol))

%% Test 16: mag_spec_scaling

logflag = 'dbp';

posspecflag = true;

nrgflag = true;

nanflag = true;

% Nearest neighbor estimation
assert(isequal(mag_spec_scaling(spec,framelen,nfft,winflag,'nne'),tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'nne',posspecflag,nrgflag,nanflag)))

% Linear scale quadratic interpolation estimation
assert(isequal(mag_spec_scaling(spec,framelen,nfft,winflag,'lin'),tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'lin',posspecflag,nrgflag,nanflag)))

% Log scale quadratic interpolation estimation
assert(isequal(mag_spec_scaling(spec,framelen,nfft,winflag,'log'),tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'log',posspecflag,nrgflag,nanflag)))

framelen = 512;
hop = tools.dsp.hopsize(framelen,0.5);
nfft = tools.dsp.fftsize(framelen);
spec = tools.stft.stft(wav,framelen,hop,nfft,winflag,'non');
pow = xqifft(framelen,winflag);

% Power scale quadratic interpolation estimation
assert(isequal(mag_spec_scaling(spec,framelen,nfft,winflag,'pow'),tools.fft2.fft2scaled_mag_spec(spec,nfft,pow,logflag,'pow',posspecflag,nrgflag,nanflag)))
