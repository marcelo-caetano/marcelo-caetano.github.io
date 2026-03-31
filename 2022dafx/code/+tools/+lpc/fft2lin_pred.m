function [linpred_coeff,pred_err,reflect_coeff] = fft2lin_pred(fft_frame,order,nfft,nframe,nchannel,biasflag,levflag)
%FFT2LIN_PRED Linear prediction from frames of the FFT.
%   LP = FFT2LIN_PRED(FFTFR,ORDER,NFFT,NFRAME,NCHANNEL,BIASFLAG,LEVFLAG)
%   returns the linear prediction coefficients LP of order ORDER for the
%   STFT frames FFTFR. FFTFR is size NFFT x NFRAME x NCHANNEL, where NFFT
%   is the size of the FFT, NFRAME is the number of frames, and NCHANNEL is
%   the number of audio channels. LP is size O+1 x NFRAME x NCHANNEL. The
%   logical flag BIASFLAG determines the type of autocorrelation
%   coefficients used to calculate LP. BIASFLAG = TRUE uses biased
%   autocorrelation coefficients for stochastic processes and BIASFLAG =
%   FALSE uses unbiased (raw) autocorrelation coefficients for
%   deterministic signals. The logical flag LEVFLAG defines if the normal
%   equations are solved with the Levinson-Durbin recursion or vectorized
%   matrix inversion. LEVFLAG = TRUE uses Levinson-Durbin recursion and
%   LEVFLAG = FALSE uses matrix inversion.
%
%   [LP,E] = FFT2LIN_PRED(...) also returns the prediction error E. E is size
%   1 x NFRAME x NCHANNEL.
%
%   [LP,E,RC] = FFT2LIN_PRED(...) also returns the reflection coefficients RC.
%   The reflection coefficients RC require additional calculation when
%   LEVFLAG = FALSE, so only call it if strictly necessary. RC is size
%   ORDER x NFRAME x NCHANNEL.
%
%   See also TRUENV

% 2021 M Caetano SMT
% 2022 M Caetano SMT (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(7,7);

% Check number of output arguments
nargoutchk(0,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% From FFT_FRAME to AUTOCORR
acorr_coeff = tools.lpc.fft2auto_corr(fft_frame,nfft,biasflag);

% From AUTOCORR to LPC
[linpred_coeff,pred_err,reflect_coeff] = tools.lpc.auto_corr2lin_pred(acorr_coeff,order,nframe,nchannel,levflag);

end
