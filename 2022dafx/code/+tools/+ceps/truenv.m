function [ceps_coeff,spec_diff,itenv] = truenv(fft_frame,nfft,nframe,nchannel,order,maxit,threshold,cepswinflag,logflag,stepflag,downsampleflag,posspecflag,nrgflag)
%TRUENV True envelope iterative cepstral smoothing.
% [CC,TE] = TRUENV(FFTFR,NFFT,ORDER,MAXIT,THRES,CEPSWINFLAG,LOGFLAG,STEPFLAG,DSFLAG)
% FFTFR full-band FFT spectrum
% NFFT size of the DFT
% ORDER of cepstral smoothing
% MAXIT maximum number of estimations
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
narginchk(13,13);

% Check number of output arguments
nargoutchk(0,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOG MAGNITUDE SPECTRUM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Log magnitude spectrum
logmagspec = tools.fft2.fft2log_mag_spec(fft_frame,nfft,logflag,posspecflag,nrgflag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DOWNSAMPLE ORIGINAL SPECTRUM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Downsample factor
dsfac = nfft/(2^nextpow2(2*order));

if downsampleflag && dsfac > 1
    
    % Log magnitude spectrum downsampling
    [ds_logmagspec,ds_nfft] = downsample_log_mag_spec(logmagspec,nfft,dsfac,nframe,nchannel);
    
else
    
    % No log magnitude spectrum downsampling
    ds_logmagspec = logmagspec;
    
    % Size of the FFT of the downsampled log magnitude spectrum
    ds_nfft = nfft;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CEPSTRAL SMOOTHING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if posspecflag
%     
%     nbin = tools.spec.pos_freq_band(ds_nfft);
%     
% else
%     
%     nbin = ds_nfft;
%     
% end

% Cepstral smoothing filter
% ceps_filt = mkcepsfilt(order,nbin,cepswinflag);
ceps_filt = repmat(mkcepsfilt(order,ds_nfft,cepswinflag),1,1,nchannel);

% Iterative cepstral smoothing
[ceps_coeff,spec_diff,itenv] = ics(ds_logmagspec,ceps_filt,ds_nfft,maxit,threshold,order,stepflag);

end
