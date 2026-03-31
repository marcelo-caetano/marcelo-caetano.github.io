function filtered = filter(excitation,filter_coeff,filter_order,framelen,hop,nsample,nchannel,causalflag,invfiltflag)
%FILTER Frame-by-frame filtering.
%
%   F = FILTER(X,COEFF,ORD,M,H,L,NCHANNEL,CAUSALFLAG,INVFILTFLAG) filters
%   the excitation X with the all-pole filter COEFF of order ORD obtained
%   via linear prediction. The filter COEFF is specified for each frame of
%   the excitation X, resulting in a time-varying filtering operation. X is
%   size L x NCHANNEL, where L is the number of time samples and NCHANNEL
%   is the number of audio channels. COEFF is size ORD+1 x NFRAME x NCHANNEL,
%   where NFRAME is the number of frames of length M obtained with a hop
%   size of H. The logical flag INVFILTFLAG controls the direction of the
%   filtering operation. INVFILTFLAG = TRUE performs inverse filtering and
%   INVFILTFLAG = FALSE performs filtering. The filtered signal F is size
%   L x NCHANNEL.
%
%   NOTE: Linear Prediction
%
%   Estimation: S_n = Z_n + G*U_n, where S_n is the original signal, Z_n is
%   the model given by Z_n = -sum(a_k*S_(n-k)), G is the gain, and U_n is
%   an unknown input signal. The prediction error is E_n = S_n - Z_n.
%
%   Inverse filtering "whitens" S_n to obtain the prediction error E_n,
%   whereas forward filtering "reconstructs" S_n from E_n and Z_n. Thus
%
%   Inverse filtering: X = S_n and F = E_n. The filtering equation is below
%   E_n = S_n - [-sum(a_k * S_(n-k))] = S_n - Z_n
%
%   Forward filtering: X = E_n and F = S_n. The filtering equation is below
%   S_n = E_n + [-sum(a_k * S_(n-k))] = E_n + Z_n
%
%   See also FILTER_FRAME

% 2022 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(9,9);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize
filtered = zeros(nsample,nchannel);
filtered(1,:) = excitation(1,:);

% Round off frame number (sample2frame)
roundflag = true;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 1: APPLY FILTER TO EACH SAMPLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Linear prediction estimation
% S_n = Z_n + G*U_n
% S_n: original signal
% Z_n = -sum(a_k*S_(n-k))
% G: gain
% U_n: unknown input

% Linear prediction error
% E_n = S_n - Z_n

for isample = 2:nsample
    
    % Frame number corresponding to ISAMPLE
    iframe = tools.dsp.sample2frame(isample,framelen,hop,causalflag,roundflag);
    
    order = min(filter_order, isample-1);
    
    if invfiltflag
        
        % INVFILTFLAG == TRUE
        % EXCITATION = S_n
        % FILTERED = E_n
        % E_n = S_n - [-sum(a_k * S_(n-k))] = S_n - Z_n
        filtered(isample,:) = excitation(isample,:) - applyFilterCoeff(excitation);
        
    else
        
        % INVFILTFLAG == FALSE
        % EXCITATION = E_n
        % FILTERED = S_n
        % S_n = E_n + [-sum(a_k * S_(n-k))] = E_n + Z_n
        filtered(isample,:) = excitation(isample,:) + applyFilterCoeff(filtered);
        
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NESTED FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NESTED FUNCTION TO PERFORM FILTERING OPERATION
    function filtSig = applyFilterCoeff(sig)
        
        filtCoeff = permute(filter_coeff(2:order+1,iframe,:),[1 3 2]);
        
        filtProd = filtCoeff .* sig(isample-1:-1:isample-order,:);
        
        filtSig = -sum(filtProd);
        
    end

end
