function source = excitation_estimation(wav,lin_pred_coeff,order,framelen,hop,nsample,nchannel,causalflag,err,center_frame)
%EXCITATION_ESTIMATION Estimation of the excitation
%   Detailed explanation goes here

% Inverse filter (whiten original signal)
invfiltflag = true;
extsigflag = false;
source = filter_frame(wav,lin_pred_coeff,order,framelen,hop,nsample,nchannel,causalflag,invfiltflag,extsigflag,err,center_frame);

end
