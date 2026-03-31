function ph_coeff = freq_hz2norm_ang_freq(ph_param,fs,order)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

ph_coeff = [ph_param(:,1) 2*pi*(ph_param(:,2:end)/fs).^(1:order-1)];
isnegph_coeff = ph_coeff < 0;
isnegfreq = ph_param < 0;
bool_corr_ph = isnegfreq & ~isnegph_coeff;
ph_coeff(bool_corr_ph) = -bool_corr_ph(bool_corr_ph).*ph_coeff(bool_corr_ph);

end
