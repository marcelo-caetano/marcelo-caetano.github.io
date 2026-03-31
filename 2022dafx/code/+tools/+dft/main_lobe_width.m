function mlw = main_lobe_width(framelen,nfft,winflag)
%MAIN_LOBE_WIDTH Main lobe width.
%   W = MAIN_LOBE_WIDTH(M,NFFT,WINFLAG) returns the width W of the main lobe
%   of the window specified by WINFLAG with M samples in the time domain
%   and an FFT of size NFFT. The window size M and the FFT size NFFT must
%   obey NFFT >= M. W is integer when M == NFFT and rational otherwise,
%   corresponding to a main lobe width between the bins of the FFT.
%
%   See also INFOWIN

% 2020 MCaetano SMT 0.1.1

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

bin = tools.spec.interp_bin(nfft,framelen);

mlw = tools.dsp.infowin(winflag,'mlw')*bin;

end
