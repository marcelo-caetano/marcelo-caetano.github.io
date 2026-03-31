function ceps_coeff = truenv(fft_frame,f0,fs,maxit,nfft,threshold,cepswinflag,logflag,stepflag,downsampleflag)
%TRUENV True envelope iterative cepstral smoothing.
% [CC,TE] = TRUENV(FFTFR,F0,SR,MAXIT,NFFT,THRES,CEPSWINFLAG,LOGFLAG,STEPFLAG,DOWNSAMPLE_LOG_MAG_SPECFLAG)
% FFTFR full-band FFT spectrum
% SR is the sampling frequency
% ORDER of cepstral smoothing
% MAXIT maximum number of estimations
% NFFT size of the DFT
% THRESHOLD maximum deviation of spectral envelope from MAGSPEC
% CEPSWINTYPE window for cepstral smoothing
% LOGFLAG flag for log scale
% STEPFLAG logical flag for inband/outband optimization
% DOWNSAMPLEFLAG logical flag to downsample magnitude spectrum
%
% CC are truncated up to ORDER

% 2020 MCaetano SMT 0.1.1

% TODO: FIX HELP
% TODO: CHECK INPUTS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(10,10);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOG MAGNITUDE SPECTRUM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Log magnitude spectrum
logmagspec = tools.fft2.fft2log_mag_spec(fft_frame,nfft,logflag,false);

% Number of frames
[~,nframe] = size(fft_frame);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DOWNSAMPLE ORIGINAL SPECTRUM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Optimal cepstral window order
order = tools.spec.order_spec_env(f0,fs,cepswinflag,'tenv');

% Downsample factor
dsfac = nfft/(2^nextpow2(2*order));

if downsampleflag && dsfac > 1
    
    % Log magnitude spectrum downsampling
    [ds_logmagspec,ds_nfft] = downsample_log_mag_spec(logmagspec,nfft,dsfac,nframe);
    
else
    
    % No log magnitude spectrum downsampling
    ds_logmagspec = logmagspec;
    
    % Size of the FFT of the downsampled log magnitude spectrum
    ds_nfft = nfft;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CEPSTRAL SMOOTHING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Cepstral smoothing filter
ceps_filt = mkcepsfilt(order,ds_nfft,cepswinflag);

% Iterative cepstral smoothing
ceps_coeff = ics(ds_logmagspec,ceps_filt,ds_nfft,maxit,threshold,order,stepflag);

end
