function mono = downmix(multichannel)
%DOWNMIX Dowmix multichannel audio to mono.
%   M = tools.wav.downmix(Y) downmixes multichannel audio in Y into mono audio in M.
%
%   Y has one channel per column as returned by audioread. So Y is L by N,
%   where L is the length of the audio file (total number of samples) and
%   N is the number of channels.
%
%   M = S when N = 1. When N > 1, M recursively sums all channels weighed
%   by the inverse of N as M = (1/N)*Y(:,Ch), where Ch = [1:N].
%
%   See also tools.wav.stereo2mono, audioread

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

[~,nchannel] = size(multichannel);

if isequal(nchannel,1)
    
    % Bypass
    mono = multichannel;
    
else
    
    mono = (1/nchannel)*multichannel(:,1);
    
    for ichannel = 2:nchannel
        
        mono = mono + (1/nchannel)*multichannel(:,ichannel);
        
    end
    
end

end
