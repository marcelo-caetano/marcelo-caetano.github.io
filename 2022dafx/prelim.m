% PRELIMINARY STEPS FOR ALL SCRIPTS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADD FOLDER FROM CURRENTLY RUNNING SCRIPT TO MATLAB PATH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get full path & name of executing file
exeFile = mfilename('fullpath');

% Get full path of executing directory
exeDir = fileparts(exeFile);

% Change directoeirs to EXEDIR
cd(exeDir);

% If EXEDIR is not on the path
if ~tools.iofun.isdironpath(exeDir)
    
    % Add EXEDIR (and all subfolders) to Matlab path
    tools.iofun.add2path(exeDir);
    
end

% Create environment variable DAFX with the absolute path to the base folder
setenv('DAFX',exeDir)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COLORS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nord Color Scheme
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Polar Night
col.nord0 = tools.plot.hex2rgb('#2e3440');
col.nord1 = tools.plot.hex2rgb('#3b4252');
col.nord2 = tools.plot.hex2rgb('#434c5e');
col.nord3 = tools.plot.hex2rgb('#4c566a');

% Snow Storm
col.nord4 = tools.plot.hex2rgb('#d8dee9');
col.nord5 = tools.plot.hex2rgb('#e5e9f0');
col.nord6 = tools.plot.hex2rgb('#eceff4');

% Frost
col.nord7 = tools.plot.hex2rgb('#8fbcbb');
col.nord8 = tools.plot.hex2rgb('#88c0d0');
col.nord9 = tools.plot.hex2rgb('#81a1c1');
col.nord10 = tools.plot.hex2rgb('#5e81ac');

% Aurora
col.nord11 = tools.plot.hex2rgb('#bf616a');
col.nord12 = tools.plot.hex2rgb('#d08770');
col.nord13 = tools.plot.hex2rgb('#ebcb8b');
col.nord14 = tools.plot.hex2rgb('#a3be8c');
col.nord15 = tools.plot.hex2rgb('#b48ead');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Basic Colors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Grey
col.b = [0 0 0]; %black
col.vdg = [0.25 0.25 0.25]; %very dark grey
col.dg = [0.35 0.35 0.35]; %dark grey
col.g = [0.65 0.65 0.65]; %grey
col.ht = [0.75 0.75 0.75]; % half tone
col.lg = [0.85 0.85 0.85]; %light grey
col.vlg = [0.95 0.95 0.95]; %very light grey

% Blue
col.lb = tools.plot.hex2rgb('#8386F5'); % light blue
col.db = tools.plot.hex2rgb('#0E19EE'); % deep blue
col.nb = tools.plot.hex2rgb('#060865'); % navy blue

% Red
col.br = tools.plot.hex2rgb('#cc0000'); % boston red
