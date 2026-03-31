function [fighandle,figaxes,specgram,nrglbl,timelbl,freqlbl,titlelbl] = spectrogram(wav,fs,framelen,hop,nfft,winflag,...
    logflag,freqlimflag,causalflag,normflag,zphflag,nrgflag,frequnitflag)
%SPECTROGRAM Plot spectrogram.
%   Detailed explanation goes here

% TODO: WRITE HELP
% TODO: VARARGOUT TO OUTPUT ONLY REQUESTED VARIABLES
% TODO: FIX NRG SCALE ACCORDING TO NORMALIZATION (NORMFLAG)

narginchk(1,13)

nargoutchk(0,7)

if nargin == 1
    
    fs = 44100;
    framelen = 2048;
    hop = tools.dsp.hopsize(framelen,0.5);
    nfft = 4096;
    winflag = 3;
    logflag = 'dbp';
    freqlimflag = 'pos';
    causalflag = 'non';
    normflag = false;
    zphflag = false;
    nrgflag = true;
    frequnitflag = true;
    
elseif nargin == 2
    
    framelen = 2048;
    hop = tools.dsp.hopsize(framelen,0.5);
    nfft = 4096;
    winflag = 3;
    logflag = 'dbp';
    freqlimflag = 'pos';
    causalflag = 'non';
    normflag = false;
    zphflag = false;
    nrgflag = true;
    frequnitflag = true;
    
elseif nargin == 3
    
    hop = tools.dsp.hopsize(framelen,0.5);
    nfft = 4096;
    winflag = 3;
    logflag = 'dbp';
    freqlimflag = 'pos';
    causalflag = 'non';
    normflag = false;
    zphflag = false;
    nrgflag = true;
    frequnitflag = true;
    
elseif nargin == 4
    
    nfft = 4096;
    winflag = 3;
    logflag = 'dbp';
    freqlimflag = 'pos';
    causalflag = 'non';
    normflag = false;
    zphflag = false;
    nrgflag = true;
    frequnitflag = true;
    
elseif nargin == 5
    
    winflag = 3;
    logflag = 'dbp';
    freqlimflag = 'pos';
    causalflag = 'non';
    normflag = false;
    zphflag = false;
    nrgflag = true;
    frequnitflag = true;
    
elseif nargin == 6
    
    logflag = 'dbp';
    freqlimflag = 'pos';
    causalflag = 'non';
    normflag = false;
    zphflag = false;
    nrgflag = true;
    frequnitflag = true;
    
elseif margin == 7
    
    freqlimflag = 'pos';
    causalflag = 'non';
    normflag = false;
    zphflag = false;
    nrgflag = true;
    frequnitflag = true;
    
elseif nargin == 8
    
    causalflag = 'non';
    normflag = false;
    zphflag = false;
    nrgflag = true;
    frequnitflag = true;
    
elseif nargin == 9
    
    normflag = false;
    zphflag = false;
    nrgflag = true;
    frequnitflag = true;
    
elseif nargin == 10
    
    zphflag = false;
    nrgflag = true;
    frequnitflag = true;
    
elseif nargin == 11
    
    nrgflag = true;
    frequnitflag = true;
    
elseif nargin == 12
    
    frequnitflag = true;
    
end

switch lower(freqlimflag)
    
    case 'pos'
        
        posfreqflag = true;
        
    case {'full','negpos'}
        
        posfreqflag = false;
        
    otherwise
        
        posfreqflag = false;
        
end

if framelen > nfft
    
    nfft = tools.dsp.fftsize(framelen,2);
    
end

% [fft_frame,center_frame,nsample,nframe,nchannel,dc] = tools.stft.stft(wav,framelen,hop,nfft,fs,winflag,causalflag,normflag,zphflag);
[fft_frame,center_frame] = tools.stft.stft(wav,framelen,hop,nfft,winflag,causalflag,normflag,zphflag);

logmagspec = tools.fft2.fft2log_mag_spec(fft_frame,nfft,logflag,posfreqflag,nrgflag);

frequency = tools.plot.mkfreq(nfft,fs,freqlimflag,frequnitflag);

time = center_frame/fs;

[fighandle,figaxes,specgram,nrglbl,timelbl,freqlbl,titlelbl] = tools.plot.plotspectrogram(logmagspec,time,frequency);

end
