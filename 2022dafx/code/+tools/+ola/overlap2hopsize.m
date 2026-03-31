function hop = overlap2hopsize(framelen,overlap)
%OVERLAP2HOPSIZE Overlap in percentage to hop size in samples.
%   H = OVERLAP2HOPSIZE(OVERLAP,WINLEN) finds the hop size H in samples that corresponds
%   to OVERLAP in % for a window of length WINLEN.
%
%   See also HS2OL

% 2016 M Caetano
% 2020 MCaetano SMT 0.1.1 (Revised)

% TODO: Check that OVERLAP < WINLEN
% NOTE: Edge case due to precision: tools.ola.overlap2hopsize(100,99.99999999999999)

%hop = framelen - framelen .* overlap/100;
hop = ceil(framelen .* (1 - overlap/100));

end
