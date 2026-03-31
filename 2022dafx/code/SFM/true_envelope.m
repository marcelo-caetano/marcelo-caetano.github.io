function [ceps_coeff,spec_diff,itenv] = true_envelope(fft_frame,nfft,nframe,nchannel,order,maxit,threshold,cepswinflag,logflag,stepflag,downsampleflag,posspecflag,nrgflag)
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
% 2022 M Caetano SMT (revision)

% TODO: FIX HELP

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(5,13);

% Check number of output arguments
nargoutchk(0,3);

if nargin == 5
    
    maxit = 100;
    threshold = 0.005;
    cepswinflag = 7;
    logflag = 'dbp';
    stepflag = true;
    downsampleflag = false;
    posspecflag = false;
    nrgflag = false;
    
elseif nargin == 6
    
    threshold = 0.005;
    cepswinflag = 7;
    logflag = 'dbp';
    stepflag = true;
    downsampleflag = false;
    posspecflag = false;
    nrgflag = false;
    
elseif nargin == 7
    
    cepswinflag = 7;
    logflag = 'dbp';
    stepflag = true;
    downsampleflag = false;
    posspecflag = false;
    nrgflag = false;
    
elseif nargin == 8
    
    logflag = 'dbp';
    stepflag = true;
    downsampleflag = false;
    posspecflag = false;
    nrgflag = false;
    
elseif nargin == 9
    
    stepflag = true;
    downsampleflag = false;
    posspecflag = false;
    nrgflag = false;
    
elseif nargin == 10
    
    downsampleflag = false;
    posspecflag = false;
    nrgflag = false;
    
elseif nargin == 11
    
    posspecflag = false;
    nrgflag = false;
    
elseif nargin == 12
    
    nrgflag = false;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[ceps_coeff,spec_diff,itenv] = tools.ceps.truenv(fft_frame,nfft,nframe,nchannel,order,maxit,threshold,cepswinflag,logflag,stepflag,downsampleflag,posspecflag,nrgflag);

end
