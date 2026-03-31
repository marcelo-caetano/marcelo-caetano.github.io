function [fig,figaxes,specgram,nrglbl,timelbl,freqlbl,titlelbl] = plotspectrogram(logmagspec,time,frequency)
%PLOTSPECTROGRAM Plot spectrogram.
%   [FIG,FIGAXES,SPECGRAM,NRGLBL,TIMELBL,FREQLBL,TTL] = PLOTSPECTROGRAM(LMS,T,F)
%
%   Input arguments:
%
%   LMS log magnitude spectrum (dB power)
%   T time vector (s)
%   F frequency vector (Hz)
%
%   Output arguments:
%
%   FIG handle to the figure with spectrogram
%   FIGAXES axes objects associated with FIG
%   SPECGRAM handle to the surface plot object
%   NRGLBL handle to the text object used as energy label
%   TIMELBL handle to the text object used as time label
%   FREQLBL handle to the text object used as frequency label
%   TTL handle to the text object used as title
%
%   See also PLOTPEAKGRAM, PLOTSPECTROPEAKGRAM, PLOTPARTTRACK

% 2020 MCaetano SMT 0.2.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(3,3);

% Check number of output arguments
nargoutchk(0,7);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFAULT PARAMETERS OF THE PLOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % Font Name ( type 'listfonts' for available system fonts)
% font = 'Times'; 

% Background color
bgc = [1 1 1]; % white

% Line width
lwidth = 1.0;

% Face color
facec = 'interp';

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
ttl = 'Spectrogram';

% Colormap
cmap = 'jet';

% Time limits
tmin = time(1);
tmax = time(end);

% Frequency limits
fmin = frequency(1);
fmax = frequency(end);

% Spectral energy limits
dbmin = -120;
dbmax = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT SPECTROGRAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make figure
fig = figure('Color',bgc);

% Make axes
figaxes = axes('Parent',fig);

% Plot spectrogram
specgram = mesh(time,frequency,logmagspec,'Parent',figaxes);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET DEFAULT PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Limits of time axis
xlim(figaxes,[tmin tmax]);

% Limits of frequency axis
ylim(figaxes,[fmin fmax]);

% Limits of amplitude axis
caxis(figaxes,[dbmin dbmax]);

% Set colormap
colormap(figaxes,cmap);

% Set line width
set(specgram,'LineWidth',lwidth,'FaceColor',facec);

% Set view (from above)
view(figaxes,[az el]);

% Fit plot box tightly around data
%axis(figaxes,'image');

% Draw box around plot
box(figaxes,'on');

% Do not draw grid in plot background
grid(figaxes,'off');

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

end
