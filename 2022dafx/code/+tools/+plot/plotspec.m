function [fig,figaxes,spectrum,freqlbl,nrglbl,titlelbl] = plotspec(frequencybin,spec)
%PLOTSPEC Plot spectrum.
%   [FIG,FIGAXES,SPECTRUM,FREQLBL,DBLBL,TTL] = PLOTSPEC(F,S)
%
%   Input arguments:
%
%   F frequency bin vector (Hz)
%   S power spectral density (dB power)
%
%   Output arguments:
%
%   FIG handle to the figure with spectrum
%   FIGAXES axes objects associated with FIG
%   SPECTRUM handle to the line plot object
%   FREQLBL handle to the text object used as frequency label
%   DBLBL handle to the text object used as energy label
%   TTL handle to the text object used as title
%
%   See also PLOTWAV, PLOTSPECTROGRAM, PLOTPEAKGRAM, PLOTPARTTRACK, PLOTSPECTROPEAKGRAM

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

% Waveform color
grey = [0.5 0.5 0.5]; %grey

% Line style
linsty = '-';

% Line width
lwidth = 1;

% Frequency axis
flbl = 'Frequency (Hz)';

% Energy axis
dblbl = 'Spectral Energy (dB)';

% Title
ttl = 'Power Spectrum';

% Frequency limits
fmin = frequencybin(1);
fmax = frequencybin(end);

% Energy limits
dbmin = min(spec,[],'all','omitnan');
dbmax = max(spec,[],'all','omitnan');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT SPECTRUM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make figure
fig = figure('Color',bckgdc);

% Make axes
figaxes = axes('Parent',fig);

% Plot spectrogram
spectrum = plot(frequencybin,spec,'Parent',figaxes);

% Display box around axes
box(figaxes,'on');

% Display axes grid
grid(figaxes,'off');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET DEFAULT PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Limits of frequency axis
xlim(figaxes,[fmin fmax]);

% Limits of energy axis
ylim(figaxes,[dbmin dbmax]);

% Set default parameters
set(spectrum,'Color',grey,'LineStyle',linsty,'LineWidth',lwidth);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADD LABELS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add frequency label to axes
freqlbl = xlabel(figaxes,flbl);

% Add energy label to axes
nrglbl = ylabel(figaxes,dblbl);

% Add title to plot
titlelbl = title(figaxes,ttl);

end
