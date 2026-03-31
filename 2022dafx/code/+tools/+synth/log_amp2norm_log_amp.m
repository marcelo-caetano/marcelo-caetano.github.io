function amp_coeff = log_amp2norm_log_amp(amp_param,fs,order)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

amp_coeff = [amp_param(:,1) (amp_param(:,2:end)/fs).^(1:order-1)];
isnegamp_coeff = amp_coeff < 0;
isnegtau = amp_param < 0;
bool_corr_amp = isnegtau & ~isnegamp_coeff;
amp_coeff(bool_corr_amp) = -bool_corr_amp(bool_corr_amp).*amp_coeff(bool_corr_amp);

end

