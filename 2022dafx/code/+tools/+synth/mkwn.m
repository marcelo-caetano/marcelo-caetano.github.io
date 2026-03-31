function wn = mkwn(nsample,nchannel)
%MKWN Make white noise.
%   W = MKWN(NSAMPLE,NCHANNEL) returns white noise in W. W is NSAMPLE x
%   NCHANNEL, where NSAMPLE is the length of W and NCHANNEL is the number
%   of channels (1 for mono, 2 for stereo, etc).
%
%   See also MKSND, MKPOLYPH

% 2022 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,2);

% Check number of output arguments
nargoutchk(0,1);

validateattributes(nsample,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NSAMPLE',1)
validateattributes(nchannel,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NCHANNEL',2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

wn = rand(nsample,nchannel) - 0.5;

end
