function f = mkfreq(nfft,fs,freqlimflag,frequnitflag)
%MKFREQ Make frequency vector in bins or in Hertz.
%   F = MKFREQ(NFFT,Fs) returns a frequency vector F in Hertz corresponding
%   to the positive half of the frequency spectrum.
%
%   F = MKFREQ(NFFT,Fs,FREQLIMFLAG) uses the text flag FREQLIMFLAG to
%   control the limits of the frequency axis. FREQLIMFLAG can be 'POS',
%   'FULL', or 'NEGPOS'. The default is FREQLIMFLAG = 'POS'.
%
%   FREQLIMFLAG = 'POS' generates frequencies from 0 to Nyquist. Use 'POS'
%   to get the positive half of the spectrum.
%
%   FREQLIMFLAG = 'FULL' generates frequencies from 0 to NFFT-1. Use 'FULL'
%   to get the full frequency range output by the FFT.
%
%   FREQLIMFLAG = 'NEGPOS' generates the negative and positive halves. Use
%   'NEGPOS' to get the full frequency range with the zero-frequency
%   component in the middle of the spectrum. Use FFTFLIP to plot the
%   spectrum.
%
%   F = MKFREQ(NFFT,Fs,FREQLIMFLAG,FUNITFLAG) uses the logical flag
%   FUNITFLAG to control the unit of the frequency vector. FUNITFLAG = TRUE
%   outputs frequencies in Hertz and FUNITFLAG = FALSE outputs frequencies
%   in bins of the FFT. The default is FUNITFLAG = TRUE for the previous
%   syntaxes.
%
%   See also MKTIME, NYQ_FREQ, FFTFLIP

% 2016 M Caetano
% 2020 MCaetano SMT 0.1.1 (Revised)

% TODO: CHECK FUNCTION ARGUMENTS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,4);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 2
    
    freqlimflag = 'pos';
    
    frequnitflag = true;
    
elseif nargin == 3
    
    frequnitflag = true;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Number of frames
nframe = 1;

% Number of channels
nchannel = 1;

% Create frequency vector
f = tools.spec.mkfreqbin(nfft,fs,nframe,nchannel,freqlimflag,frequnitflag);

end
