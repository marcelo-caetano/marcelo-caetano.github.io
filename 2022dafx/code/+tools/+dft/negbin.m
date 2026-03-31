function bin_neg = negbin(bin,bincenter,nfft)
%NEGBIN Negative frequency bins.
%   N = NEGBIN(BIN,BC,NFFT) shifts the frequency bins BIN towards the
%   negative end of the spectrum by NFFT-BC.
%
%   See also POSBIN

% 2021 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check the number of input arguments
narginchk(3,3);

% Check the number of output arguments
nargoutchk(0,1);

validateattributes(bin,{'numeric'},{'finite','nonnan','real'},mfilename,'BIN',1)

validateattributes(bincenter,{'numeric'},{'3d','finite','real','nonnegative'},mfilename,'BC',2)

validateattributes(nfft,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NFFT',3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bin_neg = bin - (nfft-bincenter);

end
