function lin_pred = real_ceps2lin_pred(rc,order,nfft,nframe,nchannel,logflag,realflag,levflag)
%REAL_CEPS2LIN_PRED From linear prediction to real cepstrum coefficients
%   LP = REAL_CEPS2LIN_PRED(RC,ORDER,NFFT,NFR,NCH,LOGFLAG,REALFLAG,LEVFLAG)
%   returns
%
%   See also LIN_PRED2REAL_CEPS

% 2022 M Caetano SMT

% TODO: VALIDATE ARGUMENTS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(5,8);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 5
    
    logflag = 'dbp';
    realflag = true;
    levflag = true;
    
elseif nargin == 6
    
    realflag = true;
    levflag = true;
    
elseif nargin == 7
    
    levflag = true;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Avoid unnecessary conversion from raw to biased autocorrelation
% coefficients in MAGSPEC2AUTO_CORR because it is undone in
% AUTO_CORR2LIN_PRED
biasflag = false;

mag_spec = tools.ceps.real_ceps2mag_spec(rc,nfft,logflag,realflag);

acorr_coeff = tools.lpc.mag_spec2auto_corr(mag_spec,nfft,biasflag);

lin_pred = tools.lpc.auto_corr2lin_pred(acorr_coeff,order,nframe,nchannel,levflag);

end
