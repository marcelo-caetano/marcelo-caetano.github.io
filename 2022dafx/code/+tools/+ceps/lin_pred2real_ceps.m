function real_ceps = lin_pred2real_ceps(lin_pred,err,nfft,nframe,nchannel)
%LIN_PRED2REAL_CEPS From linear prediction to real cepstrum coefficients.
%   RC = LIN_PRED2REAL_CEPS(LP,ERR,NFFT,NFRAME,NCHANNEL) returns the real
%   cepstrum coeffients RC from the linear prediction coefficients LP. ERR
%   is the prediction error, NFFT is the size of the FFT used in the
%   conversion, NFRAME is the number of frames of the STFT, and NCHANNEL is
%   the number of audio channels.
%
%   See also REAL_CEPS2LIN_PRED

% 2022 M Caetano SMT

% TODO: VALIDATE ARGUMENTS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(5,5);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

posspecflag = false;
nrgflag = false;
magspec = tools.lpc.lin_pred2mag_spec(lin_pred,err,nfft,nframe,nchannel,posspecflag,nrgflag);

logflag = 'dbp';
nanflag = false;
real_ceps = tools.ceps.mag_spec2real_ceps(magspec,nfft,logflag,nanflag);

end
