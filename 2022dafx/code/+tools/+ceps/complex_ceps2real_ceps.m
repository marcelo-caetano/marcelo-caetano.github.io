function rc = complex_ceps2real_ceps(cc,order,nfft,nframe,nchannel)
%CC2CEPS Complex cepstrum to real cepstrum.
%   Detailed explanation goes here

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

rc = zeros(nfft,nframe,nchannel);
rc(1:order,:,:) = cc;
rc(nfft:-1:nfft-(order-2),:,:) = cc(2:order,:,:);

end
