function ceps_win = mkcepsfilt(order,nfft,cepswinflag)
%MKCEPSFILT Make cepstral filter.
%   CEPSWIN = MKCEPSFILT(ORDER,NFFT,CEPSWINFLAG)
%
%   See also ICS, TRUENV

% 2020 MCaetano SMT 0.1.1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(3,3);

% Check number of output arguments
nargoutchk(0,1);

% Validate ORDER < INYQ
validateattributes(order,{'numeric'},{'scalar','finite','nonnan','integer','real','positive','<',tools.spec.nyq_ind(nfft)},mfilename,'ORDER',1)

% Validate NFFT
validateattributes(nfft,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NFFT',2)

% Validate CEPSWINFLAG
validateattributes(cepswinflag,{'numeric'},{'scalar','finite','nonnan','integer','real','positive','>=',1,'<=',7},mfilename,'CEPSWINFLAG',3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Length of the cepstral window
cepsfiltlen = 2*(order-1);

% Make flipped full band cepstral window
fullband_win = flip(tools.win.mkwin(cepsfiltlen,cepswinflag));

% Zero pad above positive band
zpad_win = tools.dsp.flexpad(fullband_win,nfft);

% Flip negative band back to the right
ceps_win = tools.spec.ifftflip(zpad_win,2*order);

end
