function [peakval,peakloc] = peakfind(sequence,reachleft,reachright,negampflag)
%PEAKFIND   finds all the peaks in S.
%
%   [V,L] = PEAKFIND(S,RL,RR) returns the values V and locations L of all
%   the peaks in S. The peaks are defined as positive points in S where
%
%   S(i) > S(i-RL) & S(i) > S(i+RR)
%
%   The default value for RL and RR is 1 when [V,L] = PEAKFIND(S). PEAKFIND
%   returns empty V and L when no peaks are found in S.
%
%   Optionally, [V,L] = PEAKFIND(S,RL,RR,F) where F is a flag that can be
%   either true or false. F = false is the default behavior of returning
%   only peaks corresponding to positive V. F = true also returns negative
%   V.

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

% Parse function input
if nargin < 4
    
    switch nargin
        
        case 1
            
            reachleft = 1;
            reachright = 1;
            negampflag = false;
            
        case 2
            
            reachright = 1;
            negampflag = false;
            
        case 3
            
            negampflag = false;
            
    end
    
end

% Turn into column vector
sequence = sequence(:);

% All possible indices
loc = (1:length(sequence))';

% Initialize peak
peak = false(size(loc));

% True for peaks
% peak = [false(1,1) ; sequence(2:end-1) > sequence(1:end-2) & sequence(2:end-1) > sequence(3:end) ; false(1,1)];

for ind = reachleft+1:length(sequence)-(reachright+1)
    
    if negampflag
        
        peak(ind) = sequence(ind) > sequence(ind-reachleft) & sequence(ind) > sequence(ind+reachright);
        
    else
        
        if sequence(ind) <= 0
            
            continue
            
        else
            
            peak(ind) = sequence(ind) > sequence(ind-reachleft) & sequence(ind) > sequence(ind+reachright);
            
        end
        
    end
    
end

% Values at peak positions
peakval = sequence(peak);

% Location of peak positions
peakloc = loc(peak);


end
