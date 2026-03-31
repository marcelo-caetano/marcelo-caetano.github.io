% UNIT TEST DFT FORMULA FOR SPECTRAL WINDOWS

% WARNING! Command to run UnitTest: res = runtests('tools.dft.test.tools_dft_unit_test')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHARED VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Normalize
normflag = true;

% Zero phase
zphflag = false;

% Phase unwrap flag
unwrapphflag = false;

% Modulate by cos
modulateflag = true;

% Real signal
realsigflag = true;

% Positive frequency
posfreqflag = true;

% Real signal flag takes precedence
if realsigflag
    posfreqflag = true;
end

% Window size
framelen = 181;
% framelen = 512;

% Rectangular = 1
% Hann = 3
% Hamming = 7
% Blackman = 5
% Blackman-Harris = 6
winflag = 6;

% Window
win = tools.win.mkwin(framelen,winflag);

% Window normalization
win0 = sum(win);

if normflag
    
    % Normalize window
    normwin = win/win0;
    
else
    
    normwin = win;
    
end

% Size of the DFT
nfft = 1024;

% Sampling frequency
fs = 44100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GENERATE SINUSOID
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nframe = 1;
nchannel = 1;

% Fractional part of bin center
binoffset = 0.123;
% binoffset = [0.123 0.046 -0.251]';

% Bin center
bincenter = 121;
% bincenter = [121 210 333]';

% Fractional bin number
fracbin = binoffset + bincenter;

% Amplitude
a0 = 1;
% a0 = [1 0.8 0.9]';

% Phase shift
phi0 = -1.307;
% phi0 = [-1.307 2.256 3.12]';

% Frequency in Hz corresponding to bins
f0 = tools.spec.bin2freq(fracbin,fs,nfft);

% Number of time domain samples
nsample = framelen;

% Time in signal reference (s)
time = tools.plot.mktime(nsample,fs);

if modulateflag
    
    if realsigflag
        wav = tools.synth.mksnd(a0,[phi0 f0],fs,nsample,'cos');
    else
        % Generate complex sinusoid
        wav = tools.synth.mksnd(a0,[phi0 f0],fs,nsample,'cis',posfreqflag);
    end
    
else
    
    a0 = 1;
    
    binoffset = 0;
    
    bincenter = 0;
    
    fracbin = 0;
    
    phi0 = 0;
    
    if realsigflag
        wav = ones(nsample,1);
    else
        wav = ones(nsample,1)+1i*realmin*ones(nsample,1);
    end
    
end

% Windowed waveform
windowed_wav = normwin.*wav;

% Zero padded waveform
zpadwin = tools.dsp.flexpad(windowed_wav,nfft);

if zphflag
    
    % Zero phase signal
    zph_wav = tools.dsp.lin_phase2zero_phase(zpadwin,framelen);
    
else
    
    % Linear phase signal
    zph_wav = zpadwin;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DISCRETE FOURIER TRANSFORM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Discrete Fourier Transform
fft_spec = fft(zph_wav,nfft);

% Magnitude scaling flag
logflag = 'dbp';
posspecflag = false;
nrgflag = false;

% Log magnitude spectrum
fft_log_mag_spec = tools.fft2.fft2log_mag_spec(fft_spec,nfft,logflag,posspecflag,nrgflag);

% Phase spectrum FFT
if unwrapphflag
    fft_ph_spec = tools.fft2.fft2unwrapped_phase_spec(fft_spec,nfft);
else
    fft_ph_spec = tools.fft2.fft2phase_spec(fft_spec);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FORMULA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Frequency bins
bin = tools.spec.mkbin(nfft,nframe,nchannel);

mlw = tools.dft.main_lobe_width(framelen,nfft,winflag);
mlw_hb = fix(mlw/2);
delta = 5;

% DFT of window
dft_spec = tools.dft.mkwin(fracbin,a0,phi0,reshape([0 nfft-1],[1 1 1 2]),nfft,framelen,nfft,winflag,posfreqflag,realsigflag,normflag,zphflag);

dft_spec = reshape(dft_spec,size(fft_spec));

% Log magnitude spectrum
dft_log_mag_spec = tools.fft2.fft2log_mag_spec(dft_spec,nfft,logflag,posspecflag,nrgflag);

% Phase spectrum DFT formula
if unwrapphflag
    dft_ph_spec = tools.fft2.fft2unwrapped_phase_spec(dft_spec,nfft);
else
    dft_ph_spec = tools.fft2.fft2phase_spec(dft_spec);
end

nbin = ceil(0.8*nfft/framelen);

if bincenter < 0
    bc = nfft + bincenter;
else
    bc = bincenter;
end

if modulateflag
    bin_ind = (bc-nbin:bc+nbin)+1;
else
    bin_ind = (bc:bc+nbin)+1;
end

% ibin = 1;

% Normalize dot product
normflagdot = true;

% spec_shape_fac = tools.math.dotprod(abs(fft_spec(bin_ind,ibin)),abs(dft_spec(bin_ind,ibin)),1,normflagdot);
spec_shape_fac = tools.math.dotprod(abs(fft_spec(bin_ind)),abs(dft_spec(bin_ind)),1,normflagdot);

nyq_ind = tools.spec.nyq_ind(nfft);
% nyq_ind = ceil((nfft+2)/2);
nyq_bin = nyq_ind-1;

%% Test 1: Log magnitude spectrum

% Window magnitude spectrum
figure(1)
plot(bin,fft_log_mag_spec,'+-b')
hold on
plot(bin,dft_log_mag_spec,'o--k')
stem(nyq_bin,dft_log_mag_spec(nyq_ind),'xr')
hold off
ttl = sprintf('M = %d, MLW = %2.5f bins, dot: %2.5f',framelen,mlw,spec_shape_fac);
title(ttl)
legend('FFT','DFT')
xticks(bin);

%% Test 2: (Wrapped) Phase spectrum

% Window phase spectrum
figure(2)
plot(bin,fft_ph_spec,'+-b')
hold on
plot(bin,dft_ph_spec,'o--k')
stem(nyq_bin,dft_ph_spec(nyq_ind),'xr')
hold off
ttl = sprintf('M = %d, MLW = %2.5f bins, dot: %2.5f',framelen,mlw,spec_shape_fac);
title(ttl)
legend('FFT','DFT')
xticks(bin);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RESYNTHESIZE SINUSOID FROM DFT (FORMULA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Test 3: Resynthesized sinusoid

% Inverse FFT
zph_synth = real(ifft(dft_spec,nfft));

% Linear phase windowed WAV
if zphflag
    
    windowed_synth = tools.dsp.zero_phase2lin_phase(zph_synth,framelen);
    
else
    
    windowed_synth = zph_synth;
    
end

% Remove zero-padding
normsynth = tools.dsp.izeropad(windowed_synth,framelen);

% Undo amplitude normalization
if normflag
    
    synth = win0*normsynth;
    orig = win0*real(windowed_wav);
    
else
    
    synth = normsynth;
    orig = real(windowed_wav);
    
end

% Residual
res = orig - synth;

srer = tools.wav.srer(orig,res);

% Plot
figure(3)
plot(time,orig,'b')
hold on
plot(time,synth,'--r')
hold off
ttl = sprintf('SRER: %2.5f',srer);
title(ttl)
legend('Orig','DFT')
