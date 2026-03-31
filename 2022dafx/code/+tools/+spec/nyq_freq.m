function bnyq = nyq_freq(nfft,fs)
%NYQ_FREQ Nyquist frequency in Hertz.
%   N = NYQ_FREQ(NFFT,Fs) returns the Nyquist frequency in Hertz for a
%   spectrum with an FFT of size NFFT and a sampling frequency Fs.
%
%   See also NYQ_IND, NYQ_BIN, NYQ

% 2020 MCaetano SMT 0.1.1
% 2021 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,2);

% Check number of output arguments
nargoutchk(0,1);

% Validate Fs
validateattributes(fs,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NFFT',2)

% Validate NFFT
validateattributes(nfft,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NFFT',3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

knyq = tools.spec.nyq_bin(nfft);

% Do NOT round off fractional Nyquist bin to keep KNYQ = NFFT/2
nnflag = false;

bnyq = tools.spec.bin2freq(knyq,fs,nfft,nnflag);

end
