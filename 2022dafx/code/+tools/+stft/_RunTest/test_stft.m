% test_stft_audio

% Import package STFT to create namespace
% import STFT.*

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAKE SIGNAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIGNAL PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sampling rate
fs = 16000;

% Fundamental frequency
freq = [412; 621];

% Number of partials
npartial = length(freq);

% Phase shift
phi_left = [0; pi/2];
phi_right = [-pi/2; 0];

% Amplitude
amp = [0.8; 0.5];

% Signal length nsample
nsample = 16000;

% Input signal
% wav_left = tools.synth.mkinharmsnd(amp,freq,phi_left,npartial,fs,nsample);
% wav_right = tools.synth.mkinharmsnd(amp,freq,phi_right,npartial,fs,nsample);

wav_left = tools.synth.mksnd(amp,[phi_left freq],fs,nsample);
wav_right = tools.synth.mksnd(amp,[phi_right freq],fs,nsample);

wav = [wav_left,wav_right];

% Signal name
fname = 'Synthetic Inharmonic Sinusoids';

% Fundamental frequency
F0 = freq(1);

% Frame size
framelen = tools.dsp.framesize(F0,fs,4);

% Hop size
hop = tools.dsp.hopsize(framelen,0.75);

% FFT size
nfft = tools.dsp.fftsize(framelen);

% Normalize window during analysis (sum(window)==1) and preserve energy upon resynthesis
normflag = true;

% Use zero phase window
zphflag = true;

% Hann analysis window
winflag = 3;

% Flag for causalflag of first window
causalflag = {'causal','non','anti'};
cf = 3;

[fft_frame,center_frame,nsample,nframe,nchannel,dc] = tools.stft.stft(wav,framelen,hop,nfft,winflag,causalflag{cf},normflag,zphflag);

[istft_synth,olawin] = tools.stft.istft(fft_frame,framelen,hop,nfft,winflag,nsample,center_frame,nframe,nchannel,dc,causalflag{cf},normflag,zphflag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT WAVEFORM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

err = wav - istft_synth;

srer_db = tools.wav.srer(wav,err);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIGURE PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot data
plot_wav.time = tools.plot.mktime(nsample,fs);
% plot_wav.wav(:,1:nchannel) = wav;
% plot_wav.wav(:,nchannel+1:2*nchannel) = istft_synth;
% plot_wav.wav(:,2*nchannel+1:3*nchannel) = err;
plot_wav.wav = wav(:,1);
plot_wav.wav(:,2) = istft_synth(:,1);
plot_wav.wav(:,3) = err(:,1);

% Figure layout
fig_layout.font = 'Times New Roman';
fig_layout.axesfs = 14;
fig_layout.titlefs = 22;
fig_layout.bckgdc = [1 1 1];
fig_layout.cmap = 'gray';
fig_layout.figsize = [15 10];
fig_layout.figpos = [0.5 0.5 fig_layout.figsize-0.5];
fig_layout.figunit = 'centimeters';
fig_layout.linsty = '-'; %'none'
fig_layout.linwidth = 1;
fig_layout.disp = 'on';
fig_layout.print = 'opengl';
fig_layout.legdisp = ["Original";"ISTFT";"Residual"];

% Axes label
axes_lbl.tlbl = 'Time (s)';
axes_lbl.albl = 'Amplitude (Normalized)';
axes_lbl.ttl = sprintf('SRER: %2.2fdB %s',srer_db,fname);

% Axes limits
axes_lim.tlim = [plot_wav.time(1) plot_wav.time(end)];
axes_lim.alim = [min(plot_wav.wav,[],'all','omitnan') max(plot_wav.wav,[],'all','omitnan')];

% Make figure
tools.plot.mkfigwav(plot_wav,axes_lim,axes_lbl,fig_layout);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT SPECTROGRAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIGURE PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot data
plot_part.logmagspec = tools.fft2.fft2log_mag_spec(fft_frame(:,:,1),nfft,'dbp',true);
plot_part.time = center_frame/fs;
plot_part.frequency = tools.plot.mkfreq(nfft,fs,'pos',true)/1000;

% Figure layout
fig_layout.font = 'Times New Roman';
fig_layout.axesfs = 14;
fig_layout.titlefs = 22;
fig_layout.bckgdc = [1 1 1];
fig_layout.cmap = 'jet';
fig_layout.figsize = [15 10];
fig_layout.figpos = [0.5 0.5 fig_layout.figsize-0.5];
fig_layout.figunit = 'centimeters';
fig_layout.msize = 7;
fig_layout.mtype = '.';
fig_layout.linsty = '-'; %'none'
fig_layout.meshsty = 'row'; %'both'
fig_layout.disp = 'on';
fig_layout.print = 'opengl';

% Axes label
axes_lbl.tlbl = 'Time (s)';
axes_lbl.flbl = 'Frequency (kHz)';
axes_lbl.dblbl = 'Spectral Energy (dB)';
axes_lbl.ttl = 'Spectrogram';

% Axes limits
axes_lim.flim = [0 8];
axes_lim.dblim = [-120 0];
axes_lim.tlim = [plot_part.time(1) plot_part.time(end)];

% Make figure
tools.plot.mkfigspectrogram(plot_part,axes_lim,axes_lbl,fig_layout);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT POWER SPECTRUM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIGURE PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot data
plot_spec.freq = tools.plot.mkfreq(nfft,fs,'pos',true)/1000;
plot_spec.spec = plot_part.logmagspec(:,round(nframe/4));
plot_spec.spec(:,2) = plot_part.logmagspec(:,round(nframe/2));
plot_spec.spec(:,3) = plot_part.logmagspec(:,3*round(nframe/4));

% Figure layout
fig_layout.font = 'Times New Roman';
fig_layout.axesfs = 14;
fig_layout.titlefs = 22;
fig_layout.bckgdc = [1 1 1];
fig_layout.cmap = 'gray';
fig_layout.figsize = [15 10];
fig_layout.figpos = [0.5 0.5 fig_layout.figsize-0.5];
fig_layout.figunit = 'centimeters';
fig_layout.linsty = '-'; %'none'
fig_layout.linwidth = 1;
fig_layout.disp = 'on';
fig_layout.print = 'opengl';
fig_layout.legdisp = ["Beginning";"Middle";"End"];

% Axes label
axes_lbl.flbl = 'Frequency (kHz)';
axes_lbl.dblbl = 'Spectral Energy (dB power)';
axes_lbl.ttl = 'Power Spectrum';

% Axes limits
axes_lim.flim = [plot_spec.freq(1) plot_spec.freq(end)];
axes_lim.dblim = [min(plot_spec.spec,[],'all','omitnan') max(plot_spec.spec,[],'all','omitnan')];

% Make figure
tools.plot.mkfigspec(plot_spec,axes_lim,axes_lbl,fig_layout);
