function [lp,err,rc] = linear_prediction(fft_frame,order,nfft,nframe,nchannel,biasflag,levflag)
%LINEAR_PREDICTION Perform linear prediction on the frames of the FFT.
%   LP = LINEAR_PREDICTION(FFTFR,ORDER,NFFT,NFRAME,NCHANNEL) returns the
%   linear prediction coefficients LP of order ORDER calculated from the
%   frames of the FFT FFTFR with size NFFT x NFRAME x NCHANNEL, where NFFT
%   is the size of the FFT, NFRAME is the number of frames, and NCHANNEL is
%   the number of audio channels. LP is size O+1 x NFRAME x NCHANNEL.
%
%   LP = LINEAR_PREDICTION(FFTFR,ORDER,NFFT,NFRAME,NCHANNEL,BIASFLAG) uses
%   the logical flag BIASFLAG to determine the type of autocorrelation
%   coefficients used to calculate LP. BIASFLAG = TRUE uses biased
%   autocorrelation coefficients for stochastic processes and
%   BIASFLAG = FALSE uses unbiased (raw) autocorrelation coefficients for
%   deterministic signals. The default is BIASFLAG = FALSE for the previous
%   syntaxes.
%
%   LP = LINEAR_PREDICTION(FFTFR,ORDER,NFFT,NFRAME,NCHANNEL,BIASFLAG,
%   LEVFLAG) uses the logical flag LEVFLAG to define if the normal
%   equations are solved with the Levinson-Durbin recursion or vectorized
%   matrix inversion. LEVFLAG = TRUE uses Levinson-Durbin recursion and
%   LEVFLAG = FALSE uses matrix inversion. The default is LEVFLAG = TRUE
%   for the previous syntax because matrix inversion can fail when the
%   matrix is ill conditioned.
%
%   [LP,E] = LINEAR_PREDICTION(...) also returns the prediction error E.
%   E is size 1 x NFRAME x NCHANNEL.
%
%   [LP,E,RC] = LINEAR_PREDICTION(...) also returns the reflection
%   coefficients RC. Note that RC requires additional calculation when
%   LEVFLAG = FALSE, so only call it if strictly necessary. RC is size
%   ORDER x NFRAME x NCHANNEL.
%
%   See also TRUE_ENVELOPE, CEPSTRAL_SMOOTHING

% 2021 M Caetano SMT
% 2022 M Caetano SMT (revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(5,7);

% Check number of output arguments
nargoutchk(0,3);

% Default SPECENVFLAG & WINFLAG
if nargin == 5
    
    biasflag = false;
    levflag = true;
    
elseif nargin == 6
    
    levflag = true;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargout == 3
    
    % Linear prediction coefficients from the frames of the FFT
    [lp,err,rc] = tools.lpc.fft2lin_pred(fft_frame,order,nfft,nframe,nchannel,biasflag,levflag);
    
else
    
    % Linear prediction coefficients from the frames of the FFT
    [lp,err] = tools.lpc.fft2lin_pred(fft_frame,order,nfft,nframe,nchannel,biasflag,levflag);
    
end

end
