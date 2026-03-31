function [norm_amp,norm_freq,norm_ph] = mindb(amp,freq,ph,threshold)
%MINDB only return peaks with minimum relative amplitude
%   Detailed explanation goes here
%
%   See also

% 2016 M Caetano
% 2019 MCaetano SMT 0.1.0 (Revised)
% 2020 MCaetano SMT 0.2.0

if isinf(threshold)
    
    norm_amp = amp;
    norm_freq = freq;
    norm_ph = ph;
    
elseif amp == 0
    
    norm_amp = amp;
    norm_freq = freq;
    norm_ph = ph;
    
else
    
    normampdb = tools.math.lin2log(amp/max(amp),'dbp');
    ind = normampdb > -abs(threshold);
    norm_amp = amp(ind);
    norm_freq = freq(ind);
    norm_ph = ph(ind);
    
end

end
