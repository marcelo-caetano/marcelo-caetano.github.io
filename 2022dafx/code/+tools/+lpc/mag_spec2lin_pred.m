function [linpred_coeff,pred_err,reflect_coeff] = mag_spec2lin_pred(magspec,order,nfft,nframe,nchannel,biasflag,levflag)
%MAG_SPEC2LIN_PRED Linear prediction from magnitude spectrum.
%   LP = MAG_SPEC2LIN_PRED(MS,ORDER,NFFT,NFRAME,NCHANNEL,LEVFLAG) returns
%   the linear prediction coefficients LP of order ORDER for the magnitude
%   spectrum MS. MS is size NFFT x NFRAME x NCHANNEL, where NFFT is the
%   size of the FFT, NFRAME is the number of frames, and NCHANNEL is the
%   number of audio channels. LP is size O+1 x NFRAME x NCHANNEL. The
%   logical flag LEVFLAG defines if the normal equations are solved with
%   the Levinson-Durbin recursion or vectorized matrix inversion.
%   LEVFLAG = TRUE uses Levinson-Durbin recursion and LEVFLAG = FALSE uses
%   matrix inversion.
%
%   [LP,E] = MAG_SPEC2LIN_PRED(...) also returns the prediction error E. E is size
%   1 x NFRAME x NCHANNEL.
%
%   [LP,E,RC] = MAG_SPEC2LIN_PRED(...) also returns the reflection coefficients RC.
%   The reflection coefficients RC require additional calculation when
%   LEVFLAG = FALSE, so only call it if strictly necessary. RC is size
%   ORDER x NFRAME x NCHANNEL.
%
%   See also LIN_PRED2MAG_SPEC

% 2022 M Caetano SMT

% TODO: VALIDATE ARGUMENTS

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

% From MAGSPEC to AUTOCORR
acorr_coeff = tools.lpc.mag_spec2auto_corr(magspec,nfft,biasflag);

% From AUTOCORR to LPC
[linpred_coeff,pred_err,reflect_coeff] = tools.lpc.auto_corr2lin_pred(acorr_coeff,order,nframe,nchannel,levflag);

end
