% REMOVE DC VAUE

% Audio file
% origpath = fullfile(getenv('SDB'), {'Iowa','_Original','Pre 2012','Strings','Cello','arco','Cello.arco.ff.sulA.A3B3.aiff'});

origpath = makepath({'Users','mcaetano','Documents','Sound Database','Iowa','_Original','Post 2012','Strings','Cello','arco','Cello.arco.ff.sulA.A3.stereo.aif'});

% Load audio
[origs,fs] = audioread(origpath);

% Remove DC
y = tools.wav.remdc(origs);
