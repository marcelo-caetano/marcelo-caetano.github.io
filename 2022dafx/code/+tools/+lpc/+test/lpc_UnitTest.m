% LINEAR PREDICTION UNIT TESTS

% NOTE: SFM/_DevTest/test_estimation_linear _prediction_coefficients
% WARNING! Command to run UnitTest: res = runtests('tools.lpc.test.lpc_UnitTest')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHARED VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%initialize random number generator
rng default

% Number of samples of the auto-regressive process (ARP)
nsample = 100000; %5000000
nchannel = 2;

% Tolerance for ARP estimation
tol_arp = 0.07;

% Tolerance for VARIANCE
tol_var = 0.05;

% Tolerance for MAGSPEC
tol_spec = 1e-8;

% Coefficients of the filter that models the auto-regressive process (ARP)

% Original coefficients
arp_num = 1;
arp_den = [1 0.1 -0.8 -0.27; 1 0.2 -0.5 -0.45]';

% Order of the ARP (how many steps back)
[nrow,~] = size(arp_den);
order = nrow - 1;

% Generate a realization of ARP by filtering white noise of VARIANCE
% Use the last 4096 samples of the ARP output to avoid start-up transients

% Variance
variance = [0.4 0.22];

% Generate white noise
white_noise = sqrt(variance).*randn(nsample,nchannel);

% Filter white noise with ARP
clear auto_reg_proc
auto_reg_proc(:,1) = filter(arp_num,arp_den(:,1),white_noise(:,1));
auto_reg_proc(:,2) = filter(arp_num,arp_den(:,2),white_noise(:,2));

% % Select last NFFT samples of ARP
% auto_reg_proc = auto_reg_proc(end-nfft:end);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESTIMATE AUTO CORRELATION IN FREQUENCY DOMAIN

% fft_auto_reg_proc = fft(auto_reg_proc,nfft);

% Frame size
framelen = 4096;

% Size of the FFT
nfft = 4096;

% Hopsize
hop = 512;

% Rectangular window
winflag = 1;

% Causal processing
causalflag = 'causal';

% No energy normalization (See biased auto-correlation below)
normflag = false;

% Linear phase
zphflag = false;

[fft_auto_reg_proc,~,~,nframe,nchannel] = tools.stft.stft(auto_reg_proc,framelen,hop,nfft,winflag,causalflag,normflag,zphflag);

% From FFT_FRAME to MAGSPEC
mag_spec = tools.fft2.fft2mag_spec(fft_auto_reg_proc);

% From FFT_FRAME to POWMAGSPEC (Power Spectral Density)
pow_mag_spec = tools.fft2.fft2pow_mag_spec(fft_auto_reg_proc);

% From POWMAGSPEC to AUTOCORR
auto_corr = ifft(pow_mag_spec,nfft);

% Biased autocorrelation estimate: Random (stochastic) process
auto_corr_bias = auto_corr/nfft;

%% Test 1: tools.lpc.fft2auto_corr

biasflag = true;

auto_corr_bias_est = tools.lpc.fft2auto_corr(fft_auto_reg_proc,nfft,biasflag);

auto_corr_bias_est_diff = auto_corr_bias_est - auto_corr_bias;

assert(all(auto_corr_bias_est_diff(:)<tol_spec))

%% Test 2: tools.lpc.auto_corr2lin_pred

% Levinson-Durbin recursion
levflag = true;

% Estimate linear prediction coefficients
[lpc_est,err] = tools.lpc.auto_corr2lin_pred(auto_corr_bias,order,nframe,nchannel,levflag);

lpc_est_diff_lev = abs(repmat(reshape(arp_den,nrow,1,nchannel),1,nframe,1) - lpc_est);
err_est_diff_lev = abs(repmat(reshape(variance,1,1,nchannel),1,nframe,1) - err);

% Vectorized matrix inversion
levflag = false;

% Estimate linear prediction coefficients
[lpc_est,err] = tools.lpc.auto_corr2lin_pred(auto_corr_bias,order,nframe,nchannel,levflag);

lpc_est_diff = abs(repmat(reshape(arp_den,nrow,1,nchannel),1,nframe,1) - lpc_est);
err_est_diff = abs(repmat(reshape(variance,1,1,nchannel),1,nframe,1) - err);

assert(all(lpc_est_diff(:)<tol_arp))

assert(all(err_est_diff(:)<tol_var))

%% Test 3: tools.lpc.auto_corr2mag_spec

biasflag = true;
posspecflag = false;
nrgflag = false;

mag_spec_est = tools.lpc.auto_corr2mag_spec(auto_corr_bias,nfft,biasflag,posspecflag,nrgflag);

mag_spec_diff = mag_spec_est - mag_spec;

assert(all(mag_spec_diff(:)<tol_spec))

%% Test 4: tools.lpc.mag_spec2auto_corr

biasflag = true;

auto_corr_bias_est = tools.lpc.mag_spec2auto_corr(mag_spec,nfft,biasflag);

auto_corr_bias_est_diff = auto_corr_bias_est - auto_corr_bias;

assert(all(auto_corr_bias_est_diff(:)<tol_spec))
