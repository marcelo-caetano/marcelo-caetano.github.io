function fig = mkfigspectrogram(plotdata,axeslim,axeslbl,figlayout)
%MKFIGSPECTROGRAM Make the figure with the plot of the spectrogram.
%   FIG = MKFIGSPECTROGRAM(PLOTDATA,AXESLIM,AXESLBL,FIGLAYOUT)
%
%   Input arguments are structures with fields:
%
%   PLOTDATA.LOGMAGSPEC log magnitude spectrum matrix in (dB power) with
%   NFREQ rows and NFRAME columns, where NFREQ is the positive frequency
%   band of the spectrum and NFRAME  is the number of frames.
%   PLOTDATA.TIME time vector in (s) with NFRAME rows.
%   PLOTDATA.FREQUENCY frequency vector in (Hz) with NFREQ rows.
%
%   AXESLIM.TLIM [TMIN TMAX] minimum and maximum display time (s)
%   AXESLIM.FLIM [FMIN FMAX] minimum and maximum display frequency (Hz)
%   AXESLIM.DBLIM [DBMIN DBMAX] minimum and maximum display energy (dB)
%
%   AXESLBL.TLBL time label string
%   AXESLBL.FLBL frequency label string
%   AXESLBL.DBLBL energy label string
%   AXESLBL.TTL title string
%
%   FIGLAYOUT.FONT font name (DEFAULT 'Times New Roman')
%   FIGLAYOUT.AXESFS axes font size (DEFAULT 14)
%   FIGLAYOUT.TITLEFS title font size (DEFAULT 22)
%   FIGLAYOUT.LWIDTH line width (DEFAULT 1.0)
%   FIGLAYOUT.BCKGDC background color (DEFAULT [1 1 1])
%   FIGLAYOUT.CMAP colormap (DEFAULT 'jet')
%   FIGLAYOUT.FIGSIZE figure size (DEFAULT [15 10])
%   FIGLAYOUT.FIGPOS figure position (DEFAULT [0.5 0.5 14.5 9.5])
%   FIGLAYOUT.FIGUNIT unit measurement of figure size (DEFAULT 'centimeters')
%   FIGLAYOUT.FACEC how colormap fills the mesh grid (DEFAULT 'interp')
%   FIGLAYOUT.DISP figure visibility display (DEFAULT 'on')
%   FIGLAYOUT.PRINT renderer used to print figure (DEFAULT 'opengl')
%
%   See also MKFIGWAV, MKFIGSPEC, MKFIGPEAKGRAM, MKFIGPARTTRACK, MKFIGSPECTROPEAKGRAM

% 2020 MCaetano SMT 0.2.0

% https://www.mathworks.com/help/matlab/creating_plots/save-figure-at-specific-size-and-resolution.html
% https://www.mathworks.com/help/matlab/ref/matlab.ui.figure-properties.html
% PaperSize [width height]
% PaperPosition [left bottom width height]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFINE DEFAULT FIGURE LAYOUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define default font
if ~isfield(figlayout,'font')
    figlayout.font = 'Times New Roman';
end

% Define default axes font size
if ~isfield(figlayout,'axesfs')
    figlayout.axesfs = 14;
end

% Define default title font size
if ~isfield(figlayout,'titlefs')
    figlayout.titlefs = 22;
end

% Define line width
if ~isfield(figlayout,'lwidth')
    figlayout.lwidth = 1.0;
end

% Define background color
if ~isfield(figlayout,'bckgdc')
    figlayout.bckgdc = [1 1 1];
end

% Define colormap
if ~isfield(figlayout,'cmap')
    figlayout.cmap = 'jet';
end

% Define figure size
if ~isfield(figlayout,'figsize')
    figlayout.figsize = [15 10];
end

% Define figure position
if ~isfield(figlayout,'figpos')
    figlayout.figpos = [0.5 0.5 figlayout.figsize-0.5];
end

% Define figure size unit
if ~isfield(figlayout,'figunit')
    figlayout.figunit = 'centimeters';
end

% Define how colormap fills mesh grid
if ~isfield(figlayout,'facec')
    figlayout.facec = 'interp';
end

% Define display figure
if ~isfield(figlayout,'disp')
    figlayout.disp = 'on';
end

% Define figure renderer
if ~isfield(figlayout,'print')
    figlayout.print = 'opengl';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CREATE PLOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[fig,figaxes,specgram,nrglbl,timelbl,freqlbl,titlelbl] = tools.plot.plotspectrogram(plotdata.logmagspec,plotdata.time,plotdata.frequency);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET AXES LIMITS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Override default time axis limits
if isfield(axeslim,'tlim')
    set(figaxes,'XLim',axeslim.tlim);
end

% Override default frequency axis limits
if isfield(axeslim,'flim')
    set(figaxes,'YLim',axeslim.flim);
end

% Override default spectral energy axis limits
if isfield(axeslim,'dblim')
    set(figaxes,'CLim',axeslim.dblim);
end

% Display box around axes
box(figaxes,'on');

% Display axes grid
grid(figaxes,'on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET AXES LABELS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Customize text of time label
if isfield(axeslbl,'tlbl')
    set(timelbl,'String',axeslbl.tlbl);
end

% Customize text of frequency label
if isfield(axeslbl,'flbl')
    set(freqlbl,'String',axeslbl.flbl);
end

% Customize text of energy label
if isfield(axeslbl,'dblbl')
    lbl = get(nrglbl,'Label');
    lbl.String = axeslbl.dblbl;
end

% Customize text of title
if isfield(axeslbl,'ttl')
    set(titlelbl,'String',axeslbl.ttl);
end

% Customize font name
if isfield(figlayout,'font')
    
    % Customize time axis label font name
    set(timelbl,'FontName',figlayout.font);
    
    % Customize frequency axis label font name
    set(freqlbl,'FontName',figlayout.font);
    
    % Customize energy axis label font name
    set(nrglbl,'FontName',figlayout.font);
    
    % Customize axes marker font name
    set(figaxes,'FontName',figlayout.font);
    
    % Customize title font name
    set(titlelbl,'FontName',figlayout.font);
    
end

% Customize title font size
if isfield(figlayout,'titlefs')
    set(titlelbl,'FontSize',figlayout.titlefs);
end

% Customize axis font size
if isfield(figlayout,'axesfs')
    
    % Customize time axis label font size
    set(timelbl,'FontSize',figlayout.axesfs);
    
    % Customize frequency axis label font size
    set(freqlbl,'FontSize',figlayout.axesfs);
    
    % Customize energy axis label font size
    set(nrglbl,'FontSize',figlayout.axesfs);
    
    % Customize axes marks font size
    set(figaxes,'FontSize',figlayout.axesfs);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET FIGURE LAYOUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set fig display (visibility)
set(fig,'Visible',figlayout.disp);

% Set fig print (renderer)
set(fig,'Renderer',figlayout.print);

% Set background color
set(fig,'Color',figlayout.bckgdc);

% Customize colormap
colormap(figaxes,figlayout.cmap);

% Set Paper Position Mode
set(fig,'PaperPositionMode','Auto');

% Set Paper unit [centimeters/inches]
set(fig,'PaperUnit',figlayout.figunit);

% Set Paper Size [width height]
set(fig,'PaperSize',figlayout.figsize);

% Set Paper Position [left bottom width height]
set(fig,'PaperPosition',figlayout.figpos);

% Set face color (fill mesh grid)
set(specgram,'FaceColor',figlayout.facec);

% Set line width
set(specgram,'LineWidth',figlayout.lwidth);

end
