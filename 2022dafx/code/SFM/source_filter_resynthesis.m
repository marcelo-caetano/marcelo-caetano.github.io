function wav = source_filter_resynthesis(source,lin_pred_coeff,order,framelen,hop,nsample,nchannel,causalflag,...
    extsigflag,err,center_frame)
%SOURCE_FILTER_RESYNTHESIS Perform source-filter resynthesis.
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Source-Filter Resynthesis')

% Filter (color) source
invfiltflag = false;
wav = filter_frame(source,lin_pred_coeff,order,framelen,hop,nsample,nchannel,causalflag,invfiltflag,extsigflag,err,center_frame);

end
