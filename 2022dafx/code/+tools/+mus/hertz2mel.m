function mel = hertz2mel(freq,fs,freq_break)
%HERTZ2MEL Convert linear frequency in hertz to mel frequency in Hertz.
%   M = HERTZ2MEL(F,Fs,FBREAK) returns the mel frequencies M in Hertz
%   corresponding to the linear frequencies F in Hertz.
%
%  The formulae for the normalized mel scale warping is:
%
%  f_mel = freq/freq_break*C           for freq <= freq_break  and
%  f_mel = C*(1+log(F/freq_break))     for F >  freq_break
%
%   the linear break point of the mel frequency is located at FBREAK Hz
%   which in bin and for FFT size NFFT and sample rate Fs translates into
%
%   nb = mFreqBreak/Fs * NFFT
%
%   the scaling factor of the normalized mel scale is selected such that
%   the center bin of the linear frequency vector translates into the center bin of
%   the normalized mel scale. This gives
%
%   C = NFFT/2/(1+log(NFFT/2/nb)
%
%
%   INPUTS
%     F:    Input frequency values (linear scale)
%     fs:       Sampling frequency
%     freq_break:   Frequency value stating the linear/logarithmic breakpoint
%
%   OUTPUTS
%     mel   mel scaled frequency values
%
%   See also HERTZ2CENTS, CENTS2FREQ, FREQ2CENTS

% 2022 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,3);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 2
    
    freq_break = 1000; %Hz
    
end

validateattributes(freq,{'numeric'},{'real'},mfilename,'FREQ',1)
validateattributes(fs,{'numeric'},{'integer','scalar'},mfilename,'Fs',2)
validateattributes(freq_break,{'numeric'},{'real','scalar'},mfilename,'FBREAK',3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nyq = fs/2;

alpha = nyq/(1+log(nyq/freq_break));

isbelowfreqbreak = freq <= freq_break;

mel(isbelowfreqbreak) = alpha * freq(isbelowfreqbreak)/freq_break;
mel(~isbelowfreqbreak) = alpha * (1+log(freq(~isbelowfreqbreak)/freq_break));

end
