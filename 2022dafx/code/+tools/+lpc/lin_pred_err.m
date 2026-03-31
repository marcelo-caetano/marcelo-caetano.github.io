function err = lin_pred_err(lp_coeff,fft_frame,order,nfft,biasflag)
%LIN_PRED_ERR Linear prediction squared error.
%   ERR = LIN_PRED_ERR(LP,FFT_FR,ORDER,NFFT,BIASFLAG) returns the linear
%   prediction squared error ERR corresponding to the linear prediction
%   coefficients LP of order ORDER calculated from the FFT frames FFT_FR.
%   LP is size ORDER+1 x NFRAME x NCHANNEL and ERR is size 1 x NFRAME x
%   NCHANNEL. The prediction error ERR is calculated as LP'*ACORR, where
%   ACORR are the autocorrelation coefficients corresponding to FFT_FR.
%
%   See also LINEAR_PREDICTION

% 2022 M Caetano SMT

% TODO: VALIDATE ARGUMENTS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(5,7);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

acorr_coeff = tools.lpc.fft2auto_corr(fft_frame,nfft,biasflag);

err = sum(lp_coeff.*acorr_coeff(1:order+1,:,:),1);

end
