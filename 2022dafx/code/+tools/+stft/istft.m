function [norm_synth,olawin] = istft(fft_frame,framelen,hop,nfft,winflag,nsample,center_frame,nframe,nchannel,dc,...
    causalflag,normflag,zphflag)
%ISTFT Inverse short-time Fourier transform
%   [S,W] = ISTFT(FFTFR,M,H,NFFT,WINFLAG,NSAMPLE,CFR,NFRAME,NCHANNEL,DC,CAUSALFLAG,NORMFLAG,ZPHFLAG)
%   overlap-adds the STFT generated with a WINTYPE window of length M and
%   hop size H and returns S with duration NSAMPLE scaled by DC.
%
%   See also STFT

% 2016 M Caetano; Revised 2019
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2021 M Caetano SMT (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(11,13);

% Check number of output arguments
nargoutchk(0,2);

if nargin == 11
    
    normflag = true;
    
    zphflag = true;
    
elseif nargin == 12
    
    zphflag = true;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Inverse FFT
if nfft < framelen
    
    nfft = tools.dsp.fftsize(framelen);
    
    zphfr = ifft(fft_frame,nfft);
    
else
    
    zphfr = ifft(fft_frame,nfft);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Only for the Phase Vocoder
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isreal(zphfr)
    
    zphfr = real(zphfr);
    
end

% Inverse zero phase
if zphflag
    
    % From zero phase to linear phase
    zpadfr = tools.dsp.zero_phase2lin_phase(zphfr,framelen);
    
else
    
    zpadfr = zphfr;
    
end

% Inverse zero padding
if nfft > framelen
    
    % Remove zero padding
    time_frame = tools.dsp.izeropad(zpadfr,framelen);
    
elseif nfft == framelen
    
    time_frame = zpadfr;
    
else
    
    % (STFT forces zero-padding when NFFT < WINSIZE)
    % Remove zero padding
    time_frame = tools.dsp.izeropad(zpadfr,framelen);
    
end

% Overlap-Add time_frame back together
[synth,olawin] = tools.ola.ola(time_frame,framelen,winflag,nsample,center_frame,nframe,nchannel,causalflag);

sc = tools.ola.colasum(winflag)*(framelen/2)/hop;

% Inverse normalization
if normflag
    
    % Scale back OLA signal
    norm_synth = synth*dc/sc;
    
else
    
    % Scale back OLA signal
    norm_synth = synth/sc;
    
end

end
