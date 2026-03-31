function synth = mkwav(f0,npartial,phase_shift,fs,duration,savpath)
%MKWAV Synthesize and save audio signal.
%   Detailed explanation goes here

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

% Time in signal reference
time = tools.plot.mktime(duration,fs);

% Initialize variables
partial = zeros(duration,npartial);
synth = zeros(duration,1);

for ipart = 1:npartial
    
    % Synthesize new partial
    partial(:,ipart) = cos(2*pi*ipart*f0.*time + phase_shift(ipart));
    % partial(:,ipart) = sin(2*pi*ipart*f0.*time + phase_shift(ipart));
    
    % Add partial to SIG
    synth = synth + partial(:,ipart);
    
end

% Normalize input signal
synth = synth/max(abs(synth));

fname = makepath(savpath);

audiowrite(fname,synth,fs);

end
