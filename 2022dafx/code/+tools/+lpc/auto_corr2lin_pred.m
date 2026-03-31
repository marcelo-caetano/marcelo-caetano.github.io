function [lin_pred_coeff,pred_err,reflect_coeff] = auto_corr2lin_pred(acorr_coeff,order,nframe,nchannel,levflag)
%AUTO_CORR2LIN_PRED Linear prediction from autocorrelation coefficients.
%   LP = AUTO_CORR2LIN_PRED(ACORR,ORDER,NFRAME,NCHANNEL) returns the linear
%   prediction coefficients LP of order ORDER from the autocorrelation
%   coefficients ACORR calculated with an FFT os size NFFT. ACORR is size
%   NFFT x NFRAME x NCHANNEL, where NFFT is the size of the FFT, NFRAME is
%   the number of frames, and NCHANNEL is the number of audio channels.
%   LP is size ORDER+1 x NFRAME x NCHANNEL.
%
%   LP = AUTO_CORR2LIN_PRED(ACORR,ORDER,NFRAME,NCHANNEL,LEVFLAG) uses the
%   logical flag LEVFLAG to define if the normal equations are solved with
%   the Levinson-Durbin recursion or vectorized matrix inversion. LEVFLAG =
%   TRUE uses Levinson-Durbin recursion and LEVFLAG = FALSE uses matrix
%   inversion. The default is LEVFLAG = TRUE.
%
%   [LP,E] = AUTO_CORR2LIN_PRED(...) also returns the prediction error E.
%   E is size 1 x NFRAME x NCHANNEL.
%
%   [LP,E,RC] = AUTO_CORR2LIN_PRED(...) also returns the reflection
%   coefficients RC. The reflection coefficients RC require additional
%   calculation when LEVFLAG = FALSE, so only call it if strictly necessary.
%   RC is size ORDER x NFRAME x NCHANNEL.
%
%   See also LIN_PRED2AUTO_CORR

% 2021 M Caetano SMT
% 2022 M Caetano SMT (Revision)

% TODO: VALIDATE ARGUMENTS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(4,5);

% Check number of output arguments
nargoutchk(0,3);

if nargin == 4
    
    levflag = true;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if levflag
    
    if nchannel > 1
        
        lin_pred_coeff = zeros(nframe,order+1,nchannel);
        pred_err = zeros(nframe,nchannel);
        reflect_coeff = zeros(order,nframe,nchannel);
        
        for ichannel = 1:nchannel
            
            [lin_pred_coeff(:,:,ichannel),pred_err(:,ichannel),reflect_coeff(:,:,ichannel)] = levinson(acorr_coeff(:,:,ichannel),order);
            
        end
        
    else
        
        [lin_pred_coeff,pred_err,reflect_coeff] = levinson(acorr_coeff,order);
        
    end
    
    % Output LPC in columns
    lin_pred_coeff = permute(lin_pred_coeff,[2 1 3]);
    pred_err = permute(pred_err,[3 1 2]);
    
else
    
    [lin_pred_coeff,pred_err] = tools.lpc.acorr2lpc(acorr_coeff,order);
    
    % Only calculate reflection coefficients if explicitly asked for
    if nargout == 3
        
        linpred_cell = mat2cell(lin_pred_coeff,order+1,ones(1,nframe),ones(1,nchannel));
        
        reflect_coeff = cellfun(@poly2rc,linpred_cell,'UniformOutput',false);
        
        reflect_coeff = cell2mat(reflect_coeff);
        
    end
    
end

% Replace NaN from CAUSALFLAG to avoid error in ROOTS
lin_pred_coeff(isnan(lin_pred_coeff)) = 0;
pred_err(isnan(pred_err)) = 0;

if nargout == 3
    
    reflect_coeff(isnan(reflect_coeff)) = 0;
    
end

end
