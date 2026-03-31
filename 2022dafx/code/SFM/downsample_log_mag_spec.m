function [ds_log_mag_spec,dsnfft] = downsample_log_mag_spec(logmagspec,nfft,dsfac,nframe,nchannel)
%DOWNSAMPLE_LOG_MAG_SPEC Downsample log magnitude spectrum.
%   Detailed explanation goes here

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number if input arguments
narginchk(5,5);

% Check number if output arguments
nargoutchk(0,2);

% Validate LOGMAGSPEC
validateattributes(logmagspec,{'numeric'},{'3d','nonempty','nonsparse'},mfilename,'LOGMAGSPEC',1)

% Validate NFFT
validateattributes(nfft,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NFFT',2)

% Validate DSFAC
validateattributes(dsfac,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'DSFAC',3)

% Validate NFRAME
validateattributes(nframe,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NFRAME',4)

% Validate NCHANNEL
validateattributes(nchannel,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NCHANNEL',5)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Downsampled spectral rate (MUST BE INTEGER)
dsnfft = nfft/dsfac;

% Reshape LOG_MAG_SPEC for MAX
log_mag_spec_max = reshape(logmagspec,[dsfac,dsnfft,nframe,nchannel]);

% Apply maximum filter across columns
log_mag_spec_max_filtered = max(log_mag_spec_max,[],1);

% Downsampled log magnitude spectrum (NO NEED TO IZPAD BECAUSE OF MAX FILTER)
ds_log_mag_spec = squeeze(log_mag_spec_max_filtered);

end
