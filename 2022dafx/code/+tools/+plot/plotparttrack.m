function [fig,figaxes,parttrack,timelbl,freqlbl,titlelbl] = plotparttrack(timepeak,freqpeak)
%PLOTPARTTRACK Plot partial tracks.
%   [FIG,FIGAXES,PARTTRACK,TIMELBL,FREQLBL,TTL] = PLOTPARTTRACK(T,F)
%
%   Input arguments:
%
%   T time vector (s)
%   F peak frequency matrix (Hz)
%
%   Output arguments:
%
%   FIG handle to the figure with spectrogram
%   FIGAXES axes objects associated with FIG
%   PARTTRACK handle to the line plot object
%   TIMELBL handle to the text object used as time label
%   FREQLBL handle to the text object used as frequency label
%   TTL handle to the text object used as title
%
%   See also PLOTWAV, PLOTSPEC, PLOTSPECTROGRAM, PLOTPEAKGRAM, PLOTSPECTROPEAKGRAM

% 2020 MCaetano SMT 0.2.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,2);

% Check number of output arguments
nargoutchk(0,6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFAULT PARAMETERS OF THE PLOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % Font Name ( type 'listfonts' for available system fonts)
% font = 'Times';

% Background color
bckgdc = [1 1 1]; % white

% Marker size
msize = 6;

% Marker type
mtype = '.';

% Line style
linsty = '-';

% Line width
lwidth = 2.0;

% Time axis
tlbl = 'Time (s)';

% Frequency axis
flbl = 'Frequency (Hz)';

% Title
ttl = 'Partial Tracks';

% Time limits
tmin = timepeak(1);
tmax = timepeak(end);

% Frequency limits
fmin = min(freqpeak,[],'all','omitnan');
fmax = max(freqpeak,[],'all','omitnan');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   PLOT PARTIAL TRACKS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make figure
fig = figure('Color',bckgdc);

% Make axes
figaxes = axes('Parent',fig);

% Plot partial tracks
parttrack = plot(timepeak,freqpeak,'Parent',figaxes);

% Display box around axes
box(figaxes,'on');

% Display axes grid
grid(figaxes,'on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET DEFAULT PARAMETERS PEAKGRAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Limits of time axis
xlim(figaxes,[tmin tmax]);

% Limits of frequency axis
ylim(figaxes,[fmin fmax]);

set(parttrack,'Marker',mtype,'MarkerSize',msize,'LineStyle',linsty,'LineWidth',lwidth);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADD LABELS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add time label to axes
timelbl = xlabel(figaxes,tlbl);

% Add frequency label to axes
freqlbl = ylabel(figaxes,flbl);

% Add title to plot
titlelbl = title(figaxes,ttl);

end
