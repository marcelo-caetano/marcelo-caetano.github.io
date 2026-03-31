function [amplitude,frequency,phase] = fft2spec_param(fft_frame,nfft,fs,nframe,nchannel,maxnpeak,pow,...
    logflag,paramestflag,freqlimflag,posspecflag,frequnitflag,npeakflag,nrgflag,nanflag)
%FFT2SPEC_PARAM From complex FFT to spectral parameters.
%   [A,F,P] = FFT2SPEC_PARAM(FFTFR,NFFT,Fs,NFRAME,NCHANNEL,MAXNPEAK,P,
%   LOGFLAG,PARAMESTFLAG,FREQLIMFLAG,POSSPECFLAG) returns the amplitudes A,
%   frequencies F, and phases P of the MAXNPEAK underlying sinusoids
%   (spectral peaks) for each frame of the STFT in FFTFR. MAXNPEAK is the
%   maximum number of spectral peaks to return, Fs is the sampling
%   frequency, NFRAME is the number of frames, NCHANNEL is the number of
%   channels.
%
%   PARAMESTFLAG is a text flag that indicates the amplitude  of the
%   magnitude spectrum when estimating the spectral parameters A, F, and P.
%   PARAMESTFLAG can be 'NNE', 'LIN', 'LOG', or 'POW'. Both 'NNE' and 'LIN'
%   use a linear scale, 'LOG' uses a logarithmic scale and 'POW' uses an
%   exponential scale. LOGFLAG is a text flag that determines the
%   logarithmic scale used. LOGFLAG can be 'DBR' for decibel root-power,
%   'DBP' for decibel power, 'BEL' for bels, 'NEP' for neper, and 'OCT' for
%   octave. DBR uses 10*log10, DBP uses 20*log10, BEL uses log10, NEP uses
%   ln, and OCT uses log2. P is the power scaling factor used when
%   PARAMESTFLAG = 'POW'. Typically, 0 < P < 1 for all window types.
%   Additionally, optimal values of P depend on ther window size M. Type
%   P = XQIFFT(M,WINFLAG) to get optimal P for the supported windows, where
%   WINFLAG is a numerical flag that determines the window type used.
%
%   The size of the multi-dimensional array FFTFR is M x NFFT x NCHANNEL,
%   where M is the frame length and NFFT is the size of the FFT. A, F, and
%   P are size NBIN x NFRAME x NCHANNEL with at most MAXNPEAK values per
%   column and NaN filling the remaining NBIN positive frequency bins. The
%   number of peaks NPEAK in a column can be NPEAK < MAXNPEAK if the frame
%   originally had fewer than MAXNPEAK values.
%
%   [A,F,P] = FFT2SPEC_PARAM(FFTFR,NFFT,Fs,NFRAME,NCHANNEL,MAXNPEAK,POW,
%   LOGFLAG,PARAMESTFLAG,FREQLIMFLAG,POSSPECFLAG,FREQUNITFLAG) uses the
%   logical flag FREQUNITFLAG to control the unit of the frequency
%   estimates in F. FREQUNITFLAG = TRUE outputs F in Hz and
%   FREQUNITFLAG = FALSE in frequency bin number. The default is
%   FREQUNITFLAG = TRUE for the previous syntaxes.
%
%   [A,F,P] = FFT2SPEC_PARAM(FFTFR,NFFT,Fs,NFRAME,NCHANNEL,MAXNPEAK,POW,
%   LOGFLAG,PARAMESTFLAG,FREQLIMFLAG,POSSPECFLAG,FREQUNITFLAG,NPEAKFLAG)
%   uses the logical flag NPEAKFLAG to specify whether the output should
%   have MAXNPEAK rows instead of NBIN rows. NPEAKFLAG = TRUE sets A, F,
%   and P to have size MAXNPEAK x NFRAME x NCHANNEL and NPEAKFLAG = FALSE
%   outputs NBIN rows. The default is NPEAKFLAG = FALSE for the previous
%   syntaxes. Note that A, F, and P might still have NaN across columns
%   that had fewer peaks than MAXNPEAK.
%
%   [A,F,P] = FFT2SPEC_PARAM(FFTFR,NFFT,Fs,NFRAME,NCHANNEL,MAXNPEAK,POW,
%   LOGFLAG,PARAMESTFLAG,FREQLIMFLAG,POSSPECFLAG,FREQUNITFLAG,NPEAKFLAG,
%   NRGFLAG) uses the logical flag NRGFLAG to control the spectral energy
%   of the amplitudes A. NRGFLAG = TRUE adds the negative frequency energy
%   to the positive frequency bins and NRGFLAG = FALSE does not. The
%   default is NRGFLAG = TRUE.
%
%   [A,F,P] = FFT2SPEC_PARAM(FFTFR,NFFT,Fs,NFRAME,NCHANNEL,MAXNPEAK,POW,
%   LOGFLAG,PARAMESTFLAG,FREQLIMFLAG,POSSPECFLAG,FREQUNITFLAG,NPEAKFLAG,
%   NRGFLAG,NANFLAG) uses the logical flag NANFLAG to handle the case
%   FFTFR = 0 for each scaling upon magnitude scaling conversion.
%   NANFLAG = TRUE replaces 0 in FFTFR and NANFLAG = FALSE does not. The
%   default is NANFLAG = TRUE. NANFLAG has little impact on FFT2SPEC_PARAM.
%
%   See also PARTIAL_TRACKING

% 2021 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(11,15);

% Check number of output arguments
nargoutchk(0,3);

if nargin == 11
    
    frequnitflag = true;
    
    npeakflag = false;
    
    nrgflag = true;
    
    nanflag = true;
    
elseif nargin == 12
    
    npeakflag = false;
    
    nrgflag = true;
    
    nanflag = true;
    
elseif nargin == 13
    
    nrgflag = true;
    
    nanflag = true;
    
elseif nargin == 14
    
    nanflag = true;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Scale the magnitude spectrum (Linear, Log, Power)
pos_mag_spec = tools.fft2.fft2scaled_mag_spec(fft_frame,nfft,pow,logflag,paramestflag,posspecflag,nrgflag,nanflag);

% Unwrap the phase spectrum
pos_ph_spec = tools.fft2.fft2unwrapped_phase_spec(fft_frame,nfft,posspecflag);

% Peak picking
[amp_peak,freq_peak,ph_peak] = peak_picking(pos_mag_spec,pos_ph_spec,nfft,fs,nframe,freqlimflag,frequnitflag);

% Estimate parameters
if strcmpi(paramestflag,'nne')
    
    % No interpolation for NNE (nearest neighbor estimation)
    amp = amp_peak.peak;
    freq = freq_peak.peak;
    ph = ph_peak.peak;
    
else
    
    % Magnitude interpolation (quadratic)
    [amp,freq] = interp_mag_spec(amp_peak,freq_peak);
    
    % Remove quadratic interpolation error introduced by DFT sampling rate
    % (NFFT) that results in 2 bins per side-lobe (i.e., parabolic interpolation
    % overshoots peak value)
    if strcmpi(paramestflag,'log')
        
        % Logical indices of interpolated peaks AMP that overshoot spectral
        % peaks AMP_PEAK.PEAK by more than 20dB
        bool = amp - amp_peak.peak > 20;
        
        % Replace with NaN
        freq(bool) = nan(1);
        amp(bool) = nan(1);
        
    end
    
    % Phase interpolation (linear)
    ph = interp_phase_spec(freq_peak,ph_peak,freq);
    
    % Revert magnitude spectrum scaling
    amp = tools.fft2.scaled_mag_spec2lin_mag_spec(amp,pow,logflag,paramestflag);
    
end

if posspecflag
    
    % Number of positive frequency bins
    nbin = tools.spec.pos_freq_band(nfft);
    
else
    
    nbin = nfft;
    
end

% Return MAXNPEAK peaks with highest energy
[amplitude,frequency,phase] = tools.sin.maxnumpeak(amp,freq,ph,maxnpeak,nbin,nframe,nchannel,npeakflag);

end
