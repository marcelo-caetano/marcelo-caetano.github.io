function fig = mkfigspec(plotdata,axeslim,axeslbl,figlayout)
%MKFIGSPEC Make the figure with the plot of the spectrum.
%   FIG = MKFIGSPEC(PLOTDATA,AXESLIM,AXESLBL,FIGLAYOUT)
%
%   Input arguments are structures with fields:
%
%   PLOTDATA.SPEC NFFT x NSPEC matrix containing the NSPEC spectra
%   PLOTDATA.FREQ NFFT vector with frequency in (Hz)
%
%   AXESLIM.FLIM [FMIN FMAX] minimum and maximum display frequency (Hz)
%   AXESLIM.DBLIM [DBMIN DBMAX] minimum and maximum display energy (dB power)
%
%   AXESLBL.FLBL frequency label string
%   AXESLBL.DBLBL energy label string
%   AXESLBL.TTL title string
%
%   FIGLAYOUT.FONT font name (DEFAULT 'Times New Roman')
%   FIGLAYOUT.AXESFS axes font size (DEFAULT 14)
%   FIGLAYOUT.TITLEFS title font size (DEFAULT 22)
%   FIGLAYOUT.LINWIDTH line width (DEFAULT 1.0)
%   FIGLAYOUT.BCKGDC background color (DEFAULT [1 1 1])
%   FIGLAYOUT.CMAP colormap (DEFAULT 'gray')
%   FIGLAYOUT.FIGSIZE figure size (DEFAULT [15 10])
%   FIGLAYOUT.FIGPOS figure position (DEFAULT [0.5 0.5 14.5 9.5])
%   FIGLAYOUT.FIGUNIT unit measurement of figure size (DEFAULT 'centimeters')
%   FIGLAYOUT.LINSTY line style (DEFAULT '-')
%   FIGLAYOUT.DISP figure visibility display (DEFAULT 'on')
%   FIGLAYOUT.PRINT renderer used to print figure (DEFAULT 'opengl')
%   FIGLAYOUT.LEGDISP legend display (DEFAULT repmat('Spectrum',1,NSPEC))
%   FIGLAYOUT.LEGFS legend font size (DEFAULT 12)
%   FIGLAYOUT.LEGORIENT legend orientation (DEFAULT 'vertical')
%
%   See also MKFIGWAV, MKFIGSPECTROGRAM, MKFIGPEAKGRAM, MKFIGPARTTRACK, MKFIGSPECTROPEAKGRAM

% 2020 MCaetano SMT 0.2.0

% https://www.mathworks.com/help/matlab/creating_plots/save-figure-at-specific-size-and-resolution.html
% https://www.mathworks.com/help/matlab/ref/matlab.ui.figure-properties.html
% PaperSize [width height]
% PaperPosition [left bottom width height]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(4,4);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PRE-PROCESSING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get number of waveforms to plot
[~,nspec] = size(plotdata.spec);

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

% Define background color
if ~isfield(figlayout,'bckgdc')
    figlayout.bckgdc = [1 1 1];
end

% Define colormap
if ~isfield(figlayout,'cmap')
    figlayout.cmap = 'gray';
end

% Define figure size
if ~isfield(figlayout,'figsize')
    figlayout.figsize = [15 10];
end

% Define figure position
if ~isfield(figlayout,'figpos')
    figlayout.figpos = [0.5 0.5 figlayout.figsize-0.5];
end

% Define figure unit
if ~isfield(figlayout,'figunit')
    figlayout.figunit = 'centimeters';
end

% Define line style
if ~isfield(figlayout,'linsty')
    figlayout.linsty = '-';
end

% Define line width
if ~isfield(figlayout,'linwidth')
    figlayout.linwidth = 1;
end

% Define display figure
if ~isfield(figlayout,'disp')
    figlayout.disp = 'on';
end

% Define figure renderer
if ~isfield(figlayout,'print')
    figlayout.print = 'opengl';
end

% Define display legend
if ~isfield(figlayout,'legdisp')
    figlayout.legdisp = repmat("Spectrum",1,nspec);
end

% Define legend font size
if ~isfield(figlayout,'legfs')
    figlayout.legfs = 12;
end

% Define legend orientation
if ~isfield(figlayout,'legorient')
    figlayout.legorient = 'vertical';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CREATE PLOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot first waveform
[fig,figaxes,spectrum,freqlbl,dblbl,titlelbl] = tools.plot.plotspec(plotdata.freq,plotdata.spec(:,1));

% If multiple waveforms
if nspec > 1
    
    % Hold on axis
    hold(figaxes,'on');
    
    for ispec = 2:nspec
        
        % Plot each waveform
        spectrum(ispec) = plot(plotdata.freq,plotdata.spec(:,ispec));
        
    end
    
    % Hold off axis
    hold(figaxes,'off');
    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET AXES LIMITS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Override default freq axis limits
if isfield(axeslim,'flim')
    set(figaxes,'XLim',axeslim.flim);
end

% Override default frequency axis limits
if isfield(axeslim,'dblim')
    set(figaxes,'YLim',axeslim.dblim);
end

% Display box around axes
box(figaxes,'on');

% Display axes grid
grid(figaxes,'off');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET AXES LABELS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Customize text of frequency label
if isfield(axeslbl,'flbl')
    set(freqlbl,'String',axeslbl.flbl);
end

% Customize text of energy label
if isfield(axeslbl,'dblbl')
    set(dblbl,'String',axeslbl.dblbl);
end

% Customize text of title
if isfield(axeslbl,'ttl')
    set(titlelbl,'String',axeslbl.ttl);
end

% Customize font name
if isfield(figlayout,'font')
    
    % Customize freq axis label font name
    set(freqlbl,'FontName',figlayout.font);
    
    % Customize frequency axis label font name
    set(dblbl,'FontName',figlayout.font);
    
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
    
    % Customize freq axis label font size
    set(freqlbl,'FontSize',figlayout.axesfs);
    
    % Customize frequency axis label font size
    set(dblbl,'FontSize',figlayout.axesfs);
    
    % Customize axes marker font size
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

% Set line style
set(spectrum,'LineStyle',figlayout.linsty);

% Set line width
set(spectrum,'LineWidth',figlayout.linwidth);

% For each waveform
for ispec = 1:nspec
    
    % Set waveform colors
    set(spectrum(ispec),'Color',mklincolor(ispec));
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET LEGEND LAYOUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Legend
if nspec > 1
    
    % Create legend
    figlegend = legend(spectrum,figlayout.legdisp);
    
    % Set legend orientation
    set(figlegend,'Orientation',figlayout.legorient);
    
    % Set legend font name
    set(figlegend,'FontName',figlayout.font);
    
    % Set legend font size
    set(figlegend,'FontSize',figlayout.legfs);
    
end

end

% Private function to assign line colors
function lincolor = mklincolor(count)

% Define colors
col = [0 0 1;... % blue
    0.5 0.5 0.5;... % grey
    0 0 0;... % black
    1 0 0;... % red
    0.83 0.8 0.75;... % light grey
    1 1 0;... % yellow
    0.25 0.25 0.25;... % very dark grey
    1 0 1;... % magenta
    0.8 0.8 0.8;... % half tone
    0 1 1;... % cyan
    0.35 0.35 0.35;... % dark grey
    0 1 0;... % green
    0.95 0.95 0.95]'; % very light grey

% Assign color
lincolor = cyclethru(col,count);

end

% Private function to cycle through vector
function valvec = cyclethru(vec,ind)

% Number of elements (assumes column vector)
[~,nelem] = size(vec);

% Element counter
elemcount = rem(ind,nelem);

if elemcount == 0
    
    % Assign last element
    valvec = vec(:,nelem);
    
else
    
    % Assign element counter
    valvec = vec(:,elemcount);
    
end

end
