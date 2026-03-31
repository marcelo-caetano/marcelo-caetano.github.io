function [coeff,err,spec_env] = spectral_envelope_estimation(fftframe,order,nfft,nframe,nchannel,specenvflag,...
    biasflag,levflag,maxit,maxdiff,cepswinflag,logflag,stepflag,dsflag,posspecflag,nrgflag,realflag)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% 2022 M Caetano SMT

% TODO: FIX HELP

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(6,17);

% Check number of output arguments
nargoutchk(0,3);

if nargin == 6
    
    biasflag = false;
    levflag = true;
    maxit = 100;
    maxdiff = 0.005;
    cepswinflag = 7;
    logflag = 'dbp';
    stepflag = true;
    dsflag = false;
    posspecflag = false;
    nrgflag = false;
    realflag = true;
    
elseif nargin == 7
    
    levflag = true;
    maxit = 100;
    maxdiff = 0.005;
    cepswinflag = 7;
    logflag = 'dbp';
    stepflag = true;
    dsflag = false;
    posspecflag = false;
    nrgflag = false;
    realflag = true;
    
elseif nargin == 8
    
    maxit = 100;
    maxdiff = 0.005;
    cepswinflag = 7;
    logflag = 'dbp';
    stepflag = true;
    dsflag = false;
    posspecflag = false;
    nrgflag = false;
    realflag = true;
    
elseif nargin == 9
    
    maxdiff = 0.005;
    cepswinflag = 7;
    logflag = 'dbp';
    stepflag = true;
    dsflag = false;
    posspecflag = false;
    nrgflag = false;
    realflag = true;
    
elseif nargin == 10
    
    cepswinflag = 7;
    logflag = 'dbp';
    stepflag = true;
    dsflag = false;
    posspecflag = false;
    nrgflag = false;
    realflag = true;
    
elseif nargin == 11
    
    logflag = 'dbp';
    stepflag = true;
    dsflag = false;
    posspecflag = false;
    nrgflag = false;
    realflag = true;
    
elseif nargin == 12
    
    stepflag = true;
    dsflag = false;
    posspecflag = false;
    nrgflag = false;
    realflag = true;
    
elseif nargin == 13
    
    dsflag = false;
    posspecflag = false;
    nrgflag = false;
    realflag = true;
    
elseif nargin == 14
    
    posspecflag = false;
    nrgflag = false;
    realflag = true;
    
elseif nargin == 15
    
    nrgflag = false;
    realflag = true;
    
elseif nargin == 16
    
    realflag = true;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch lower(specenvflag)
    
    case 'lpc'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % LINEAR PREDICTION
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Linear prediction: COEFF == LPC
        [coeff,err] = linear_prediction(fftframe,order,nfft,nframe,nchannel,biasflag,levflag);
        
        % Linear prediction envelope
        spec_env = tools.lpc.lin_pred2mag_spec(coeff,err,nfft,nframe,nchannel,posspecflag,nrgflag);
        
    case 'lsf'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % LINE SPECTRAL FREQUENCIES
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Linear prediction: LP_COEFF == LPC
        [lp_coeff,err] = linear_prediction(fftframe,order,nfft,nframe,nchannel,biasflag,levflag);
        
        % LPC -> LSF
        coeff = poly2lsf(lp_coeff);
        % Linear prediction envelope
        spec_env = tools.lpc.lin_pred2mag_spec(lp_coeff,err,nfft,nframe,nchannel,posspecflag,nrgflag);
        
    case 'rc'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % REFLECTION COEFFICIENTS
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Linear prediction: COEFF == RC
        [~,err,coeff] = linear_prediction(fftframe,order,nfft,nframe,nchannel,biasflag,levflag);
        
        % RC -> LPC
        lp_coeff = rc2poly(coeff);
        % Spectral envelope
        spec_env = tools.lpc.lin_pred2mag_spec(lp_coeff,err,nfft,nframe,nchannel,posspecflag,nrgflag);
        
    case 'lar'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % LOG AREA RATIO
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Linear prediction: REFLECT_COEFF == RC
        [~,err,reflect_coeff] = linear_prediction(fftframe,order,nfft,nframe,nchannel,biasflag,levflag);
        
        % RC -> LAR
        coeff = rc2lar(reflect_coeff);
        % RC -> LPC
        lp_coeff = rc2poly(reflect_coeff);
        % Spectral envelope
        spec_env = tools.lpc.lin_pred2mag_spec(lp_coeff,err,nfft,nframe,nchannel,posspecflag,nrgflag);
        
    case 'isp'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % INVERSE SINE PARAMETERS
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Linear prediction: COEFF == RC
        [~,err,reflect_coeff] = linear_prediction(fftframe,order,nfft,nframe,nchannel,biasflag,levflag);
        
        % RC -> IS
        coeff = rc2is(reflect_coeff);
        % RC -> LPC
        lp_coeff = rc2poly(reflect_coeff);
        % Spectral envelope
        spec_env = tools.lpc.lin_pred2mag_spec(lp_coeff,err,nfft,nframe,nchannel,posspecflag,nrgflag);
        
    case 'acs'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % AUTO-CORRELATION SEQUENCE
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Linear prediction: COEFF == AC
        coeff = tools.lpc.fft2auto_corr(fftframe,nfft,biasflag);
        
        coeff(order+1:nfft,:,:) = [];
        
        % Linear prediction error
        [~,err,~] = linear_prediction(fftframe,order,nfft,nframe,nchannel,biasflag,levflag);
        
        % Spectral envelope
        spec_env = tools.lpc.auto_corr2mag_spec(coeff,nfft,biasflag,posspecflag,nrgflag);
        
    case 'ceps'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % CEPSTRAL SMOOTHING
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        maxit = 1;
        maxdiff = 0.005;
        stepflag = false;
        dsflag = false;
        posspecflag = false;
        nrgflag = false;
        
        coeff = true_envelope(fftframe,nfft,nframe,nchannel,order,maxit,maxdiff,cepswinflag,logflag,stepflag,dsflag,posspecflag,nrgflag);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%
        % ERROR
        %%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Force LPC to be real
        % realflag = true;
        lp_coeff = tools.ceps.real_ceps2lin_pred(coeff,order,nfft,nframe,nchannel,logflag,realflag,levflag);
        
        err = tools.lpc.lin_pred_err(lp_coeff,fftframe,order,nfft,biasflag);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%
        % SPECTRAL ENVELOPE
        %%%%%%%%%%%%%%%%%%%%%%%%%
        
        % REALFLAG = TRUE (force SPEC_ENV real)
        spec_env = tools.ceps.real_ceps2mag_spec(coeff,nfft,logflag,realflag);
        
    case 'tenv'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % TRUE ENVELOPE CEPSTRAL SMOOTHING
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        coeff = true_envelope(fftframe,nfft,nframe,nchannel,order,maxit,maxdiff,cepswinflag,logflag,stepflag,dsflag,posspecflag,nrgflag);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%
        % ERROR
        %%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Force LPC to be real
        % realflag = true;
        lp_coeff = tools.ceps.real_ceps2lin_pred(coeff,order,nfft,nframe,nchannel,logflag,realflag,levflag);
        
        err = tools.lpc.lin_pred_err(lp_coeff,fftframe,order,nfft,biasflag);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%
        % SPECTRAL ENVELOPE
        %%%%%%%%%%%%%%%%%%%%%%%%%
        
        % REALFLAG = TRUE (force SPEC_ENV real)
        spec_env = tools.ceps.real_ceps2mag_spec(coeff,nfft,logflag,realflag);
        
end
