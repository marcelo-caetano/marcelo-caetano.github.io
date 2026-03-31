function overlap = hopsize2overlap(hop,framelen)
%HS2OL Hop size in samples to overlap in percentage.
%   OVERLAP = HS2OL(H,WINLEN) finds the OVERLAP in % that corresponds to
%   the hop size H in samples for a window of length WINLEN.
%
%   See also OVERLAP2HOPSIZE

% 2016 M Caetano
% 2020 MCaetano SMT 0.1.1 (Revised)

overlap = 100 * (framelen - hop) ./ framelen;

end
