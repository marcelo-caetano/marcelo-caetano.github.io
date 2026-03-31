function acorr_coeff = fft2auto_corr(fft_frame,nfft,biasflag)
%FFT2AUTO_CORR Auto correlation from frames of the FFT.
%   ACORR = FFT2AUTO_CORR(FFTFR,NFFT,BIASFLAG) returns the autocorrelation
%   coefficients ACORR for the frames of the FFT in the columns of FFTFR.
%   The logical flag BIASFLAG
%   FFTFR is size NFFT x NFRAME x NCHANNEL, where NFFT is the size of the
%   FFT, NFRAME is the number of frames, and NCHANNEL is the number of
%   audio channels. ACORR is size NFFT x NFRAME x NCHANNEL.
%
%   See also FFT2LPC

% 2021 M Caetano SMT

% TODO: SANITIZE AUTOCORR(AUTOCORR==0)=REALMIN
% TODO: SANITIZE AUTOCORR: REPLACE NAN: ADD NANFLAG

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(3,3);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% From FFT_FRAME to Power Spectral Density (PSD)
powmagspec = tools.fft2.fft2pow_mag_spec(fft_frame);

% From POWMAGSPEC to raw AUTOCORR: deterministic signal
% Use REAL to guarantee that ACORR_COEFF is real
acorr_coeff = real(ifft(powmagspec,nfft));

% Biased AUTOCORR: Random (stochastic) process
if biasflag
    
    acorr_coeff = acorr_coeff/nfft;
    
end

end
