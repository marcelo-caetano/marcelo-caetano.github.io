% TEST ISONPATH

% NOTE: ISONPATH WORKS FOR ANY FILE TYPE (WITH AN EXTENSION)

%%%%%%%%%%%%%%%%%%%%%%%%
% ABS PATH
%%%%%%%%%%%%%%%%%%%%%%%%

dev = getenv('DEV');

dev_home = getenv('DEV_HOME');

curr_dir = pwd;

% File that exists and is on the path
absFileExistOnPath = fullfile(dev,'OLA\ola.m');

% File that exists but is not on the path
absFileExistNotOnPath = fullfile(dev_home,'MATLAB\_thesis\add_echo.m');

% File does not exist
absFileNotExist = fullfile(dev,'OLA\iscoca.m');

% File in the current folder not on the path
absFileCurrDirNotOnPath = fullfile(curr_dir,'test_isfunction.m');

%%%%%%%%%%%%%%%%%%%%%%%%
% REL PATH
%%%%%%%%%%%%%%%%%%%%%%%%

% File that exists and is on the path
relFileExistOnPath = 'ola.m';

% File that exists but is not on the path
relFileExistNotOnPath = 'add_echo.m';

% File does not exist
relFileNotExist = 'iscoca.m';

% File in the current folder not on the path
relFileCurrDirNotOnPath = 'test_isfunction.m';

%%%%%%%%%%%%%%%%%%%%%%%%
% JAVA MEHODS
%%%%%%%%%%%%%%%%%%%%%%%%

% Name of java method
nameOfJavaMethod = 'java.util.Date';

% Try method: setMonth
meth = java.util.Date;

loadJavaMethod = 'setMonth';

%%%%%%%%%%%%%%%%%%%%%%%%
% VARIABLE
%%%%%%%%%%%%%%%%%%%%%%%%

variable = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UNIT TESTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%
% ABS PATH
%%%%%%%%%%%%%%%%%%%%%%%%

% EXIST & ON PATH
if tools.iofun.isfileonpath(absFileExistOnPath)
    fprintf(1,'File %s passed EXIST & ON PATH\n',absFileExistOnPath)
else
    warning('File %s failed EXIST & ON PATH\n',absFileExistOnPath)
end

% EXIST & NOT ON PATH
if ~tools.iofun.isfileonpath(absFileExistNotOnPath)
    fprintf(1,'File %s passed EXIST & NOT ON PATH\n',absFileExistNotOnPath)
else
    warning('File %s failed EXIST & NOT ON PATH\n',absFileExistNotOnPath)
end

% NOT EXIST
if ~tools.iofun.isfileonpath(absFileNotExist)
    fprintf(1,'File %s passed NOT EXIST\n',absFileNotExist)
else
    warning('File %s failed NOT EXIST\n',absFileNotExist)
end

% EXIST IN CURR DIR & NOT ON PATH
if ~tools.iofun.isfileonpath(absFileCurrDirNotOnPath)
    fprintf(1,'File %s passed EXIST IN CURR DIR & NOT ON PATH\n',absFileCurrDirNotOnPath)
else
    warning('File %s failed EXIST IN CURR DIR & NOT ON PATH\n',absFileCurrDirNotOnPath)
end

%%%%%%%%%%%%%%%%%%%%%%%%
% REL PATH
%%%%%%%%%%%%%%%%%%%%%%%%

% EXIST & ON PATH
if tools.iofun.isfileonpath(relFileExistOnPath)
    fprintf(1,'File %s passed EXIST & ON PATH\n',relFileExistOnPath)
else
    warning('File %s failed EXIST & ON PATH\n',relFileExistOnPath)
end

% EXIST & NOT ON PATH
if ~tools.iofun.isfileonpath(relFileExistNotOnPath)
    fprintf(1,'File %s passed EXIST & NOT ON PATH\n',relFileExistNotOnPath)
else
    warning('File %s failed EXIST & NOT ON PATH\n',relFileExistNotOnPath)
end

% NOT EXIST
if ~tools.iofun.isfileonpath(relFileNotExist)
    fprintf(1,'File %s passed NOT EXIST\n',relFileNotExist)
else
    warning('File %s failed NOT EXIST\n',relFileNotExist)
end

% EXIST IN CURR DIR & NOT ON PATH
if ~tools.iofun.isfileonpath(relFileCurrDirNotOnPath)
    fprintf(1,'File %s passed EXIST IN CURR DIR & NOT ON PATH\n',relFileCurrDirNotOnPath)
else
    warning('File %s failed EXIST IN CURR DIR & NOT ON PATH\n',relFileCurrDirNotOnPath)
end

%%%%%%%%%%%%%%%%%%%%%%%%
% JAVA MEHODS
%%%%%%%%%%%%%%%%%%%%%%%%

% EXIST JAVA METHOD
if ~tools.iofun.isfileonpath(nameOfJavaMethod)
    fprintf(1,'File %s passed EXIST JAVA METHOD\n',nameOfJavaMethod)
else
    warning('File %s failed EXIST JAVA METHOD\n',nameOfJavaMethod)
end

% LOADED JAVA METHOD
if ~tools.iofun.isfileonpath(loadJavaMethod)
    fprintf(1,'File %s passed LOADED JAVA METHOD\n',loadJavaMethod)
else
    warning('File %s failed LOADED JAVA METHOD\n',loadJavaMethod)
end

%%%%%%%%%%%%%%%%%%%%%%%%
% VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%

% EXIST VARIABLE
if ~tools.iofun.isfileonpath(variable)
    fprintf(1,'File %s passed EXIST VARIABLE\n',string(variable))
else
    warning('File %s failed EXIST VARIABLE\n',string(variable))
end

% Clear all variables created
clear
