function filtered = filter_frame(excitation,filter_coeff,filter_order,framelen,hop,nsample,nchannel,causalflag,invfiltflag,extsigflag,err,center_frame)
%FILTER_FRAME Apply filter frame by frame.
%
%   F = FILTER_FRAME(X,COEFF,ORD,M,H,L,NCHANNEL,CAUSALFLAG,INVFILTFLAG)
%   filters the excitation X with the all-pole filter COEFF of order ORD
%   obtained via linear prediction. The filter COEFF is specified for each
%   frame of the excitation X, resulting in a time-varying filtering
%   operation. X is size L x NCHANNEL, where L is the number of time samples
%   and NCHANNEL is the number of audio channels. COEFF is size ORD+1 x
%   NFRAME x NCHANNEL, where NFRAME is the number of frames of length M
%   obtained with a hop size of H. The logical flag INVFILTFLAG controls
%   the direction of the filtering operation. INVFILTFLAG = TRUE performs
%   inverse filtering and INVFILTFLAG = FALSE performs filtering. The
%   filtered signal F is size L x NCHANNEL.
%
%   F = FILTER_FRAME(X,COEFF,ORD,M,H,L,NCHANNEL,CAUSALFLAG,INVFILTFLAG,
%   EXTFLAG) uses the logical flag EXTFLAG to indicate that X is an external
%   excitation signal. EXTFLAG = TRUE means that the filter COEFF does not
%   correspond to LPC analysis of X, whereas EXTFLAG = FALSE means that
%   COEFF is indeed the result of LPC analysis of X. Setting EXTFLAG = TRUE
%   causes the linear prediction error E to be applied to F, thus E must
%   also be supplied as input to FILTER_FRAME. The function issues a
%   warning and forces EXTFLAG = FALSE if it is called with only 10 input
%   arguments.
%
%   F = FILTER_FRAME(X,COEFF,ORD,M,H,L,NCHANNEL,CAUSALFLAG,INVFILTFLAG,
%   EXTFLAG,E) applies the error E to F when EXTFLAG = TRUE and E is not
%   empty. The function throws a warning before recreating the vector with
%   the positions of the center of the frames CFR because it expects CFR as
%   the last argument in the syntax below. Additionally, the function
%   throws a warning when EXTFLAG = FALSE and E is supplied before ignoring
%   E. Similarly, the function throws a warning when EXTFLAG = TRUE and E
%   is empty before forcing EXTFLAG = FALSE.
%
%   F = FILTER_FRAME(X,COEFF,ORD,M,H,L,NCHANNEL,CAUSALFLAG,INVFILTFLAG,
%   EXTFLAG,E,CFR) uses CFR as the center of the frames to apply E to F
%   when filtering external signals. See syntaxes above for further
%   details.
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
%   See also SPECTRAL_ENVELOPE_ESTIMATION, TOOLS.LPC.FILTER

% 2022 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(9,12);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 9
    
    extsigflag = false;
    err = [];
    center_frame = [];
    
elseif nargin == 10 && ~extsigflag
    
    err = [];
    center_frame = [];
    
elseif nargin == 10 && extsigflag
    
    warning('Forcing EXTSIGFLAG to be FALSE');
    extsigflag = false;
    err = [];
    center_frame = [];
    
elseif nargin == 11 && ~extsigflag
    
    warning('Ignoring input E')
    center_frame = [];
    
elseif nargin == 11 && extsigflag && isempty(err)
    
    warning('Forcing EXTSIGFLAG to be FALSE')
    extsigflag = false;
    center_frame = [];
    
elseif nargin == 11 && extsigflag && ~isempty(err)
    
    warning('Making CFR')
    nframe = tools.dsp.numframe(nsample,framelen,hop,causalflag);
    center_frame = tools.dsp.frame2sample((1:nframe)',framelen,hop,causalflag);
    
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filtered = tools.lpc.filter(excitation,filter_coeff,filter_order,framelen,hop,nsample,nchannel,causalflag,invfiltflag);

% Modulate white-noise excitation by frame energy
if extsigflag
    
    % Modulate by energy for Random (stochastic) process
    filtered = upSampleNRG.*filtered;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NESTED FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NESTED FUNCTION TO UPSAMPLE FRAME ENERGY TO TIME-SAMPLE ENERGY
    function Err = upSampleNRG
        
        % Reshape squared error (sqErr == NRG)
        sqErr = permute(err,[2 3 1]);
        
        % NRG -> Log NRG (dB power)
        logNRG = 10*log10(sqErr);
        
        % Resample LOGNRG from NFRAME to NSAMPLE
        logNRGUp = interp1(center_frame,logNRG,(1:nsample)','linear','extrap');
        
        % Log NRG (dB power) -> Err
        Err = tools.math.log2lin(logNRGUp,'dbp');
        
    end

end
