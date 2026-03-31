function [parameters] = FDLP(parameters,index,waveform,samplingrate,flag)
%FDLP Frequency domain linear prediction.
%
%   PARAM = FDLP(PARAM,IND,WAV,Fs,FLAG)

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

% Zeropad to nearest power of two
aux=[0;abs(waveform);zeros(2.^nextpow2(abs(waveform))-length(abs(waveform)),1)];

% Calculate signal
%ff=ifft([aux;aux(end-1:-1:2)],length([aux;aux(end-1:-1:2)]));
ff = dct(aux);
% Calculate Amplitude Envelope parameters
[parameters(index).(['lpc_ampenv_' flag]).lpc,parameters(index).(['lpc_ampenv_' flag]).err] = lpc(ff,ceil(samplingrate/parameters(index).f0(round(parameters(index).number_frames/2))));

% Extract Amplitude Envelope curve
res = abs(1./fft(parameters(index).(['lpc_ampenv_' flag]).lpc,length([aux;aux(end-1:-1:2)])));
parameters(index).(['lpc_ampenv_' flag]).env = sqrt(parameters(index).(['lpc_ampenv_' flag]).err)*res(1:length(waveform));

% switch flag
%
%     case {'total'}
%
%         % Calculate signal
%         %ff=ifft([aux;aux(end-1:-1:2)],length([aux;aux(end-1:-1:2)]));
%         ff=dct(aux);
%         % Calculate Amplitude Envelope parameters
%         [parameters(index).lpc_ampenv_total.lpc,parameters(index).lpc_ampenv_total.err] = lpc(ff,ceil(samplingrate/parameters(index).f0(round(parameters(index).number_frames/2))));
%
%         % Extract Amplitude Envelope curve
%         res = abs(1./fft(parameters(index).lpc_ampenv_total.lpc,length([aux;aux(end-1:-1:2)])));
%         parameters(index).lpc_ampenv_total.env = sqrt(parameters(index).lpc_ampenv_total.err)*res(1:length(waveform));
%
%     case {'partials'}
%
%         % Calculate signal
%         %ff=ifft([aux;aux(end-1:-1:2)],length([aux;aux(end-1:-1:2)]));
%         ff=dct(aux);
%         % Calculate Amplitude Envelope parameters
%         parameters(index).lpc_ampenv_partials.lpc = lpc(ff,ceil(samplingrate/parameters(index).f0(round(parameters(index).number_frames/2))));
%
%         % Extract Amplitude Envelope curve
%         res = abs(1./fft(parameters(index).lpc_ampenv_partials.lpc,length([aux;aux(end-1:-1:2)])));
%         parameters(index).lpc_ampenv_partials.env = res(1:length(waveform));
%
%     case {'noise'}
%
%         % Calculate signal
%         %ff=ifft([aux;aux(end-1:-1:2)],length([aux;aux(end-1:-1:2)]));
%         ff=dct(aux);
%         % Calculate Amplitude Envelope parameters
%         parameters(index).lpc_ampenv_noise.lpc = lpc(ff,ceil(samplingrate/parameters(index).f0(round(parameters(index).number_frames/2))));
%
%         % Extract Amplitude Envelope curve
%         res = abs(1./fft(parameters(index).lpc_ampenv_noise.lpc,length([aux;aux(end-1:-1:2)])));
%         parameters(index).lpc_ampenv_noise.env = res(1:length(waveform));
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
