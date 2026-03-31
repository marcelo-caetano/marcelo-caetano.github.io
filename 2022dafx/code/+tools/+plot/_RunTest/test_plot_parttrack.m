% TEST PLOT PARTIALGRAM

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIGURE PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Figure layout
fig_layout.font = 'Times New Roman';
fig_layout.axesfs = 14;
fig_layout.titlefs = 22;
fig_layout.lwidth = 1.0;
fig_layout.bckgdc = [1 1 1];
fig_layout.cmap = 'jet';
fig_layout.figsize = [15 10];
fig_layout.figpos = [0.5 0.5 fig_layout.figsize-0.5];
fig_layout.figunit = 'centimeters';
fig_layout.msize = 4;
fig_layout.mtype = 'x';
fig_layout.linsty = '-';
fig_layout.meshsty = 'both';
fig_layout.facec = 'interp';
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

% SPECTRAL ANALYSIS
% Analysis window
winflag = 6;
overlap = 0.5;
% Display name of analysis window in the terminal
fprintf(1,'%s analysis window\n',tools.dsp.infowin(winflag,'name'));
% Flag for causality of first window
causalflag = {'causal','non','anti'};
cf = 1;
% Normalize analysis window
normflag = true;
% Use zero phase window
zphflag = true;

% Flag for log magnitude spectrum
logflag = {'dbr','dbp','nep','oct','bel'};
lmsf = 2;

% PARAMETER ESTIMATION
% Magnitude spectrum scaling
paramestflag = {'nne','lin','log','pow'};
pef = 4;
% Maximum number of peaks to retrieve from analysis
maxnpeak = 150;
% Return MAXNPEAK frequency bins
npeakflag = true;

% Replace -Inf in spectrogram
nanflag = false;

% PARTIAL TRACKING
ptrackflag = true;
ptrackalgflag = {'','p2p'};
ptf = 2;

% PEAK SELECTION
peakselflag = true;
% Peak shape threshold (normalized)
% shapethres = 0;
shapethres = 0.8;
% Peak range threshold (dB power)
% rangethres = 20;
rangethres = 5;
% Relative threshold (dB power)
% relthres = -inf(1);
relthres = -90;
% Absolute threshold (dB power)
% absthres = -inf(1);
absthres = -100;

if peakselflag
    % Number of fundamental periods
    nT0 = 6;
    % Oversampling factor
    osfac = 4;
else
    % Number of fundamental periods
    nT0 = 4;
    % Oversampling factor
    osfac = 2;
end

% TRACK DURATION SELECTION
trackdurflag = true;
% Duration threshold (ms)
durthres = 100;
% Connect over (ms)
% gapthres = inf(1);
gapthres = 50;

% HARMONIC SELECTION
harmselflag = true;
tvarf0flag = true;
% Maximum harmonic deviation (cents)
max_harm_dev = 100;
harm_thresh = 0.8;
harmpartflag = 'count';

% Resynthesis flag
synthflag = {'OLA','PI','PRFI'};
rf = 2;

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
    
    % Fundamental frequency of source sound
    f0 = swipep_mod(wav,fs,[75 500],1000/fs,[],1/20,0.5,0.2);
    
    if all(isnan(f0))
        
        f0 = tools.mus.note2freq('C0');
        
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % SINUSOIDAL ANALYSIS PARAMETERS
    
    % Reference f0
    ref0 = tools.f0.reference_f0(f0);
    
    % Frame size = 3*T0
    framelen = tools.dsp.framesize(f0,fs,nT0);
    
    % 50% overlap
    hop = tools.dsp.hopsize(framelen,overlap);
    
    % FFT size
    nfft = tools.dsp.fftsize(framelen);
    
    % Frequency difference for peak matching (Hz)
    freqdiff = tools.dsp.freq_diff4peak_matching(ref0);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % SPECTRAL PEAKS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [amplitude,frequency,phase,center_frame,npartial,nframe,nchannel,nsample,dc] = sinusoidal_analysis(wav,framelen,hop,nfft,fs,...
                winflag,causalflag{cf},normflag,zphflag,paramestflag{pef},maxnpeak,npeakflag,...
                ptrackflag,ptrackalgflag{ptf},freqdiff,...
                peakselflag,shapethres,rangethres,relthres,absthres,...
                trackdurflag,durthres,gapthres,...
                harmselflag,ref0,tvarf0flag,max_harm_dev,harm_thresh,harmpartflag);
    
    % plot_data.timepeak = repmat(center_frame/fs,[1,maxnpeak])';
    plot_data.timepeak = center_frame/fs;
       
    %plot_data.freqpeak = cat(2,frequency{:})/1000;
    plot_data.freqpeak = frequency/1000;
    
    % Time limits
    axes_lim.tlim = [plot_data.timepeak(1) plot_data.timepeak(end)];
    
    % Title
    axes_lbl.ttl = sprintf('%s',strrep(fname,'_',' '));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % PLOT FIGURE
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Make figure
    fig = tools.plot.mkfigparttrack(plot_data,axes_lim,axes_lbl,fig_layout);
    
    % Save figure
    saveas(fig,fullfile(savimg,[fname '_parttrack']),'pdf');
    
end
