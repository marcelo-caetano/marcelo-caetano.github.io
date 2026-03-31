function [ferb,nfreqerb] = erbspace(fmin,fmax,steperb)
%ERBSPACE Linearly spaced frequencies in ERB.
%   Detailed explanation goes here

minerb = tools.mus.hertz2erb(fmin);
maxerb = tools.mus.hertz2erb(fmax);

% Create ERB-scale uniformly-spaced frequencies (in Hertz)
ferb = tools.mus.erb2hertz(minerb:steperb:maxerb)';

nfreqerb = length(ferb);

end
