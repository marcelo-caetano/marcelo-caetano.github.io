% TEST PLOT SPECROGRAM

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

% Number of fundamental periods
nT0 = 4;

% PARAMETER ESTIMATION
% Magnitude spectrum scaling
paramestflag = {'nne','lin','log','pow'};
pef = 4;

% Fold full spectral energy into non-negative spectral band
nrgflag = true;

% Replace -Inf in spectrogram
nanflag = false;

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
    
    %audio_data = tools.wav.stereo2mono(audio_data);
    
    % Fundamental freq of source sound
    f0 = swipep_mod(audio_data,fs,[75 500],1000/fs,[],1/20,0.5,0.2);
    
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [fft_frame,center_frame,nsample,nframe,nchannel,dc] = tools.stft.stft(audio_data,framelen,hop,nfft,winflag,causalflag{cf},normflag,zphflag);
    
    plot_data.logmagspec = tools.fft2.fft2log_mag_spec(fft_frame(:,:,1),nfft,logflag{lmsf},nrgflag,nanflag);
    
    plot_data.time = center_frame/fs;
    
    plot_data.frequency = tools.plot.mkfreq(nfft,fs,'pos',true)/1000;
    
    % Time limits
    axes_lim.tlim = [plot_data.time(1) plot_data.time(end)];
    
    % Title
    axes_lbl.ttl = sprintf('%s',strrep(fname,'_',' '));
    
    % Make figure
    fig = tools.plot.mkfigspectrogram(plot_data,axes_lim,axes_lbl,fig_layout);
    
    % Save figure
    saveas(fig,fullfile(savimg,[fname '_spectrogram']),'pdf');
    
end
