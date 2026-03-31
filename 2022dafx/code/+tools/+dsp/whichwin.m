function win = whichwin(winflag)
% WIN = WHICHWIN(WINTYPE) returns the name of the window that corresponds to
% WINTYPE. WIN is a character array. The possibilities are:
%
%   1 - Rectangular
%   2 - Bartlett
%   3 - Hann
%   4 - Hanning
%   5 - Blackman
%   6 - Blackman-Harris
%   7 - Hamming
%
% See also INFOWIN

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

win = tools.dsp.infowin(winflag,'name');

end
