function framelen = freq_res2win_len(fs,delta,winflag)
%FREQ_RES2WIN_LEN Frequency resolution to window length.
%   M = FREQ_RES2WIN_LEN(Fs,DELTA,WINTYPE) returns the minimum window
%   length M in samples necessary to resolve two sinusoids sampled at Fs
%   samples/s whose frequencies differ by DELTA = F1 - F2 in Hertz.
%
%   Only the absolute value of the difference matters because internally
%   ABS(DELTA) is used.
%
%   See also WIN_LEN2FREQ_RES

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0
% 2021 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(3,3);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get main lobe width
mlw = tools.dsp.infowin(winflag,'mlw');

% Convert DELTA to window length
framelen = mlw*fs/abs(delta);

end
