function [fig,figaxes,specgram,peakgram,nrglbl,timelbl,freqlbl,titlelbl] = plotspectropeakgram(logmagspec,timespec,freqspec,timepeak,freqpeak)
%PLOTSPECTROPEAKGRAM Plot spectro-peakgram.
%   [FIG,FIGAXES,SPECGRAM,PEAKGRAM,NRGLBL,TIMELBL,FREQLBL,TTL] = PLOTSPECTROPEAKGRAM(LMS,TS,FS,TP,FP)
%
%   Input arguments:
%
%   LMS log magnitude spectrum (dB power)
%   TS spectrum time vector (s)
%   FS spectrum frequency vector (Hz)
%   TP spectral peak time vector (s)
%   FP spectral peak frequency vector (Hz)
%
%   Output arguments:
%
%   FIG handle to the figure with spectrogram
%   FIGAXES axes objects associated with FIG
%   SPECGRAM handle to the mesh plot object
%   PEAKGRAM handle to the line plot object
%   NRGLBL handle to the text object used as energy label
%   TIMELBL handle to the text object used as time label
%   FREQLBL handle to the text object used as frequency label
%   TTL handle to the text object used as title
%
%   See also PLOTWAV, PLOTSPEC, PLOTSPECTROGRAM, PLOTPEAKGRAM, PLOTPARTTRACK

% 2020 MCaetano SMT 0.2.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(5,5);

% Check number of output arguments
nargoutchk(0,8);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFAULT PARAMETERS OF THE PLOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % Font Name ( type 'listfonts' for available system fonts)
% font = 'Times';

% Background color
bckgdc = [1 1 1]; % white

% Marler color
mkrc = [0 0 0]; % black

% Marker size
msize = 6;

% Marker type
mtype = '.';

% Line style
linsty = 'none';

% Mesh style
meshsty = 'both';

% Face color
facec = 'interp';

% Line width
lwidth = 1.0;

% Azimuth
az = 0.5;

% Elevation
el = 90;

% Spectral energy axis
dblbl = 'Energy Spectral Density (dB)';

% Time axis
tlbl = 'Time (s)';

% Frequency axis
flbl = 'Frequency (Hz)';

% Title
ttl = 'Spectro-Peakgram';

% Colormap
cmap = 'jet';

% Time limits
tmin = timespec(1);
tmax = timespec(end);

% Frequency limits
fmin = freqspec(1);
fmax = freqspec(end);

% Spectral energy limits
dbmin = -120;
dbmax = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   PLOT SPECTROGRAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make figure
fig = figure('Color',bckgdc);

% Make axes
figaxes = axes('Parent',fig);

% Plot spectrogram
specgram = mesh(timespec,freqspec,logmagspec,'Parent',figaxes);

hold(figaxes,'on');

% Display box around axes
box(figaxes,'on');

% Display axes grid
grid(figaxes,'on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET DEFAULT PARAMETERS SPECTROGRAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Limits of time axis
xlim(figaxes,[tmin tmax]);

% Limits of frequency axis
ylim(figaxes,[fmin fmax]);

% Limits of amplitude axis
caxis(figaxes,[dbmin dbmax]);

% Set colormap
colormap(figaxes,cmap);

% Set marker type/marker size/line style/mesh style
% set(specgram,'Marker',mtype,'MarkerSize',msize,'LineStyle',linsty,'MeshStyle',meshsty);

% Set line width
set(specgram,'LineWidth',lwidth,'MeshStyle',meshsty,'FaceColor',facec);

% Set view (from above)
view(figaxes,[az el]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   PLOT SPECTRAL PEAKS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot spectrogram
peakgram = plot(timepeak,freqpeak,'Parent',figaxes);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET DEFAULT PARAMETERS PEAKGRAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(peakgram,'Marker',mtype,'Color',mkrc,'MarkerSize',msize,'LineStyle',linsty);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADD LABELS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add colorbar with scale in dB to plot
nrglbl = colorbar(figaxes);

% Add amplitude label to axes
lbl = get(nrglbl,'Label');
lbl.String = dblbl;

% Add time label to axes
timelbl = xlabel(figaxes,tlbl);

% Add frequency label to axes
freqlbl = ylabel(figaxes,flbl);

% Add title to plot
titlelbl = title(figaxes,ttl);

hold(figaxes,'off');

end
