function [phpeak,a,b] = phase_interp_ls(freq,ph,freqpeak)
%PHASE_INTERP_LS Least squares linear interpolation of phase.
%   Detailed explanation goes here

% 2016 M Caetano
% 2019 MCaetano SMT 0.1.0 (Revised)
% 2020 MCaetano SMT 0.2.0

% LINEAR FIT USING LEAST SQUARES FOR ALL 3 POINTS
a = (3*(freq(:,:,1).*ph(:,:,1) + freq(:,:,2).*ph(:,:,2) + freq(:,:,3).*ph(:,:,3))...
    - (freq(:,:,1) + freq(:,:,2) + freq(:,:,3)).*(ph(:,:,1) + ph(:,:,2) + ph(:,:,3)))...
    ./ (3*(freq(:,:,1).^2 + freq(:,:,2).^2 + freq(:,:,3).^2)...
    - (freq(:,:,1) + freq(:,:,2) + freq(:,:,3)).^2);

b = ((ph(:,:,1) + ph(:,:,2) + ph(:,:,3))...
    - a.*(freq(:,:,1) + freq(:,:,2) + freq(:,:,3)))/3;

phpeak = a.*freqpeak + b;

end
