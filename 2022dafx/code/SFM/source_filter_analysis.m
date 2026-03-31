function [source,spec_env_coeff,err,lin_pred_coeff,order,center_frame,nsample,nframe,nchannel,spec_env_curve] = ...
    source_filter_analysis(wav,framelen,hop,nfft,fs,winflag,causalflag,normflag,zphflag,specenvflag,...
    cepswinflag,ref0,order,biasflag,levflag,maxit,maxdiff,logflag,stepflag,dsflag,posspecflag,nrgflag)
%SOURCE_FILTER_ANALYSIS Perform source-filter analysis.
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Source-Filter Analysis')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHORT-TIME FOURIER TRANSFORM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Short-Time Fourier Transform from namespace STFT
[fft_frame,center_frame,nsample,nframe,nchannel] = tools.stft.stft(wav,framelen,hop,nfft,winflag,causalflag,normflag,zphflag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SPECTRAL ENVELOPE ESTIMATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Order of the spectral envelope
if isempty(order)
    order = spec_env_order(ref0,fs,cepswinflag,specenvflag);
end

[spec_env_coeff,err,spec_env_curve] = spectral_envelope_estimation(fft_frame,order,nfft,nframe,nchannel,specenvflag,...
    biasflag,levflag,maxit,maxdiff,cepswinflag,logflag,stepflag,dsflag,posspecflag,nrgflag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SPECTRAL ENVELOPE CONVERSION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

realflag = true;
lin_pred_coeff = spectral_envelope_conversion(spec_env_coeff,order,nfft,nframe,nchannel,specenvflag,logflag,realflag,levflag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXCITATION ESTIMATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

source = excitation_estimation(wav,lin_pred_coeff,order,framelen,hop,nsample,nchannel,causalflag,err,center_frame);

end
