function bin_pos = posbin(bin,bincenter)
%POSBIN Positive frequency bins.
%   P = POSBIN(BIN,BC) shifts the frequency bins BIN towards the positive
%   end of the frequency spectrum by BC.
%
%   See also NEGBIN

% 2021 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check the number of input arguments
narginchk(2,2);

% Check the number of output arguments
nargoutchk(0,1);

validateattributes(bin,{'numeric'},{'finite','nonnan','real'},mfilename,'BIN',1)

validateattributes(bincenter,{'numeric'},{'3d','finite','real','nonnegative'},mfilename,'BC',2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bin_pos = bin - bincenter;

end
