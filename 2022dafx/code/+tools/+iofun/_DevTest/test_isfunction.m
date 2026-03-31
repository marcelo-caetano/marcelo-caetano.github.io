% TEST IS FUNCTION

%%%%%%%%%%%%%%%%%%%%%%%%
% ABS PATH
%%%%%%%%%%%%%%%%%%%%%%%%

dev = getenv('DEV');

prod = getenv('PROD');

dev_home = getenv('DEV_HOME');

curr_dir = pwd;

% Function exists on the path
absFuncExistOnPath = fullfile(dev,'OLA\ola.m');

% Function exists not on the path
absFuncExistNotOnPath = fullfile(prod,'sinusoidal-model\OLA\ola.m');

% M-file not exist
absFileNotExist = fullfile(dev,'OLA\oca.m');

% Function in current folder not on the path
absFuncCurrDirNotOnPath = fullfile(curr_dir,'mockfun.m');

% Script exists on the path
absScriptExistOnPath = fullfile(dev,'SM\run\run_sm.m');

% Script exists not on the path
absScriptExistNotOnPath = fullfile(prod,'sinusoidal-model\run_sm.m');

% Script in current folder not on the path
absScriptCurrDirNotOnPath = fullfile(curr_dir,'test_isonpath.m');

%%%%%%%%%%%%%%%%%%%%%%%%
% REL PATH
%%%%%%%%%%%%%%%%%%%%%%%%

% Function exists on the path
relFuncExistOnPath = 'ola.m';

% Function exists not on the path
relFuncExistNotOnPath = 'auread.m';

% M-file not exist
relFileNotExist = 'oca.m';

% Function in current folder not on the path
relFuncCurrDirNotOnPath = 'mockfun.m';

% Script exists on the path
relScriptExistOnPath = 'run_sm.m';

% Script exists not on the path
relScriptExistNotOnPath = 'sm_run_sm.m';

% Script in current folder not on the path
relScriptCurrDirNotOnPath = 'test_isonpath.m';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UNIT TESTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%
% ABS PATH
%%%%%%%%%%%%%%%%%%%%%%%%

% EXIST & ON PATH
if tools.iofun.isfunction(absFuncExistOnPath)
    fprintf(1,'Absolute Function %s passed EXIST & ON PATH\n',absFuncExistOnPath)
else
    warning('Absolute Function %s failed EXIST & ON PATH\n',absFuncExistOnPath)
end

% EXIST & NOT ON PATH
if tools.iofun.isfunction(absFuncExistNotOnPath)
    fprintf(1,'Absolute Function %s passed EXIST & NOT ON PATH\n',absFuncExistNotOnPath)
else
    warning('Absolute Function %s failed EXIST & NOT ON PATH\n',absFuncExistNotOnPath)
end

% NOT EXIST
try tools.iofun.isfunction(absFileNotExist)
    warning('Absolute Function %s failed NOT EXIST\n',absFileNotExist)
catch
    fprintf(1,'Absolute Function %s passed NOT EXIST\n',absFileNotExist)
end

% EXIST IN CURR DIR & NOT ON PATH
if tools.iofun.isfunction(absFuncCurrDirNotOnPath)
    fprintf(1,'Absolute File %s passed EXIST IN CURR DIR & NOT ON PATH\n',absFuncCurrDirNotOnPath)
else
    warning('Absolute File %s failed EXIST IN CURR DIR & NOT ON PATH\n',absFuncCurrDirNotOnPath)
end

% EXIST & ON PATH
if ~tools.iofun.isfunction(absScriptExistOnPath)
    fprintf(1,'Absolute Script %s passed EXIST & ON PATH\n',absScriptExistOnPath)
else
    warning('Absolute Script %s failed EXIST & ON PATH\n',absScriptExistOnPath)
end

% EXIST & NOT ON PATH
if ~tools.iofun.isfunction(absScriptExistNotOnPath)
    fprintf(1,'Absolute Script %s passed EXIST & NOT ON PATH\n',absScriptExistNotOnPath)
else
    warning('Absolute Script %s failed EXIST & NOT ON PATH\n',absScriptExistNotOnPath)
end

% EXIST IN CURR DIR & NOT ON PATH
if ~tools.iofun.isfunction(absScriptCurrDirNotOnPath)
    fprintf(1,'Absolute Script %s passed EXIST IN CURR DIR & NOT ON PATH\n',absScriptCurrDirNotOnPath)
else
    warning('Absolute Script %s failed EXIST IN CURR DIR & NOT ON PATH\n',absScriptCurrDirNotOnPath)
end

%%%%%%%%%%%%%%%%%%%%%%%%
% REL PATH
%%%%%%%%%%%%%%%%%%%%%%%%

% EXIST & ON PATH
if tools.iofun.isfunction(relFuncExistOnPath)
    fprintf(1,'Relative Function %s passed EXIST & ON PATH\n',relFuncExistOnPath)
else
    warning('Relative Function %s failed EXIST & ON PATH\n',relFuncExistOnPath)
end

% EXIST & NOT ON PATH
try tools.iofun.isfunction(relFuncExistNotOnPath)
    warning('Relative Function %s failed EXIST & NOT ON PATH\n',relFuncExistNotOnPath)
catch
    fprintf(1,'Relative Function %s passed EXIST & NOT ON PATH\n',relFuncExistNotOnPath)
end

% NOT EXIST
try tools.iofun.isfunction(relFileNotExist)
    warning('Relative Function %s failed NOT EXIST\n',relFileNotExist)
catch
    fprintf(1,'Relative Function %s passed NOT EXIST\n',relFileNotExist)
end

% EXIST IN CURR DIR & NOT ON PATH
if tools.iofun.isfunction(relFuncCurrDirNotOnPath)
    fprintf(1,'Relative File %s passed EXIST IN CURR DIR & NOT ON PATH\n',relFuncCurrDirNotOnPath)
else
    warning('Relative File %s failed EXIST IN CURR DIR & NOT ON PATH\n',relFuncCurrDirNotOnPath)
end

% EXIST & ON PATH
if ~tools.iofun.isfunction(relScriptExistOnPath)
    fprintf(1,'Relative Script %s passed EXIST & ON PATH\n',relScriptExistOnPath)
else
    warning('Relative Script %s failed EXIST & ON PATH\n',relScriptExistOnPath)
end

% EXIST & NOT ON PATH
try tools.iofun.isfunction(relScriptExistNotOnPath)
    warning('Relative Script %s failed EXIST & NOT ON PATH\n',relScriptExistNotOnPath)
catch
    fprintf(1,'Relative Script %s passed EXIST & NOT ON PATH\n',relScriptExistNotOnPath)
end

% EXIST IN CURR DIR & NOT ON PATH
if ~tools.iofun.isfunction(relScriptCurrDirNotOnPath)
    fprintf(1,'Relative Script %s passed EXIST IN CURR DIR & NOT ON PATH\n',relScriptCurrDirNotOnPath)
else
    warning('Relative Script %s failed EXIST IN CURR DIR & NOT ON PATH\n',relScriptCurrDirNotOnPath)
end

% Clear workspace
clear
