function [freqcand,nfreqcand] = octspace(fmin,fmax,stepoct)
%OCTSPACE Linearly spaced frequencies in octaves.
%   Detailed explanation goes here

octmin = log2(fmin);
octmax = log2(fmax);

% Linear spacing in octaves
freqcand = pow2(octmin:stepoct:octmax)';

nfreqcand = length(freqcand);

end
