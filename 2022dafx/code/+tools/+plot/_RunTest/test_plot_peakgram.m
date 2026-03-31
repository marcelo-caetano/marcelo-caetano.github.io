% TEST PLOT SPECROGRAM

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIGURE PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
% axes_lbl.ttl = '';

% Axes limits
axes_lim.flim = [0 8];
axes_lim.dblim = [-120 0];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ANALYSIS PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Maximum number of spectral peaks
maxnpeak = 150;

% Peak shape threshold (normalized)
% shapethres = 0;
shapethres = 0.8;

% Peak range threshold (dB power)
% rangethres = -inf(1);
rangethres = 20;

% Relative threshold (dB power)
% relthres = -inf(1);
relthres = -80;

% Absolute threshold (dB power)
% absthres = -inf(1);
absthres = -100;

% Duration threshold (ms)
% durthres = 0;
durthres = 20;

% Connect over (ms)
% gapthres = inf(1);
gapthres = 17.5;

% Hann analysis window
winflag = 3;

% Flag for causalflag of first window
causalflag = {'anti','non','causal'};
cf = 1;

% Flag for log magnitude spectrum
logflag = {'dbr','dbp','nep','oct','bel'};
lf = 2;

% Magnitude spectrum scaling
paramestflag = {'nne','lin','log','pow'};
pef = 3;

% Partial tracking
ptrackflag = {'','p2p'};
ptf = 2;

% Number of fundamental periods
nT0 = 4;

% Normalize analysis window
normflag = true;

% Use zero phase window
zphflag = true;

% Estimate frequencies in Hz
frequnitflag = true;

% MANPEAK spectral peaks
npeakflag = false;

% Fold full spectral energy into non-negative spectral band
nrgflag = true;

% Replace -Inf in spectrogram
nanflag = false;

noiseflag = true;

partselflag = true;

partdurflag = true;

% Display resynthesis info
dispflag = false;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% READ SOUND FILE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sound data base
sdb = getenv('SDB');

% Path to save figures
savimg = fullfile(sdb,'_Results','_tmp','img');

% List paths to all .wav files
listsound = tools.iofun.rsf(fullfile(sdb,'Misc','Musical_Instrument','Medium'),'wav');

nsound = length(listsound);

% Pick sound files
% Challenging files: 85-99

startsnd = 60;
endsnd = 65;

for isound = startsnd:endsnd
    
    fprintf(1,'Sound %d of %d\n',isound-startsnd+1,endsnd-startsnd+1);
    
    origs = listsound{isound};
    
    [fpath,fname,fext] = fileparts(origs);
    
    fprintf(1,'%s\n',strrep(fname,'_',' '));
    
    [audio_data,fs] = audioread(origs);
    
    wav = tools.wav.stereo2mono(audio_data);
    
    % Fundamental freq of source sound
    f0 = swipep_mod(wav,fs,[75 500],1000/fs,[],1/20,0.5,0.2);
    
    if all(isnan(f0))
        
        f0 = tools.mus.note2freq('C0');
        
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % SINUSOIDAL ANALYSIS PARAMETERS
    
    % Frame size = 3*T0
    framelen = tools.dsp.framesize(f0,fs,nT0);
    
    % 50% overlap
    hop = tools.dsp.hopsize(framelen,0.5);
    
    % FFT size
    nfft = tools.dsp.fftsize(framelen);
    
    % Reference f0
    ref0 = tools.f0.reference_f0(f0);
    
    % Frequency difference for peak matching (Hz)
    freqdiff = fix(ref0/2);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [amp,freq,~,center_frame,npartial,nsample,nframe] = sinusoidal_analysis(wav,framelen,hop,nfft,fs,maxnpeak,...
        shapethres,rangethres,relthres,absthres,durthres,gapthres,freqdiff,winflag,causalflag{cf},paramestflag{pef},...
        ptrackflag{ptf},normflag,zphflag,frequnitflag,npeakflag,partselflag,partdurflag);
    
    % plot_data.specpeak = tools.math.lin2log(cat(2,amp{:}),logflag{lmsf},nanflag);
    plot_data.specpeak = tools.math.lin2log(amp,logflag{lf},nanflag);
    
    plot_data.time = repmat(center_frame/fs,[1,npartial])';
    
    %plot_data.frequency = cat(2,freq{:})/1000;
    plot_data.frequency = freq/1000;
    
    % Time limits
    axes_lim.tlim = [plot_data.time(1,1) plot_data.time(1,end)];
    
    % Title
    axes_lbl.ttl = sprintf('%s',strrep(fname,'_',' '));
    
    % Make figure
    fig = tools.plot.mkfigpeakgram(plot_data,axes_lim,axes_lbl,fig_layout);
    
    % Save figure
    saveas(fig,fullfile(savimg,[fname '_peakgram']),'pdf');
    
end
