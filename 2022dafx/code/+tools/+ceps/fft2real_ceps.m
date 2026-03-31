function real_ceps = fft2real_ceps(fft_frame,nfft,logflag)
%FFT2REAL_CEPS From complex FFT to real cepstrum.
%   RC = FFT2REAL_CEPS(FFTFR,NFFT,LOGFLAG) retuns the cepstral coefficients
%   RC of the complex Fourier spectrum FFTFR with length NFFT. FFTFR is the
%   NFFT x NFR matrix returned by STFT, where NFFT is the size of the FFT
%   and NFR is the number of frames. The string LOGFLAG controls the
%   log scale as 'DBR' for dB root-power, 'DBP' for dB power,
%   'NEP' for neper, 'OCT' for octave, and 'BEL' for bels.
%
%   See also FFT2LMS, LIN2LOG, LOG2LIN, RCEPS, CCEPS, ICCEPS

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

% Log magnitude spectrum
log_mag_spec = tools.fft2.fft2log_mag_spec(fft_frame,nfft,logflag);

% Cepstral coefficients
real_ceps = tools.ceps.log_mag_spec2real_ceps(log_mag_spec,nfft);

end
