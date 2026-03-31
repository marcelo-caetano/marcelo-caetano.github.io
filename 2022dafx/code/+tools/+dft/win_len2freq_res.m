function delta = win_len2freq_res(sr,framelen,winflag)
%WIN_LEN2FREQ_RES Window length to frequency resolution.
%   DELTA = WIN_LEN2FREQ_RES(SR,WINSIZE,WINTYPE) returns the minimum separation in
%   frequency DELTA that a length M WINTYPE window can resolve
%   in the Fourier spectrum. DELTA = F2 - F1, where F1 and F2 are the
%   frequencies in Hertz.
%
%   See also FREQ_RES2WIN_LEN

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

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
main_lobe = tools.dsp.infowin(winflag,'mlw');

% Convert MAIN_LOBE_WIDTH to frequency resolution
delta = main_lobe*sr/framelen;

end
