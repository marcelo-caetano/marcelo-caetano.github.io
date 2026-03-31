function step = cents2step(cents)
%CENTS2STEP Number of steps corresponding to interval in cents.
%   S = CENTS2STEP(C) returns an integer number of steps corresponding to
%   the frequency interval C expressed in cents. The conversion is
%   S = ROUND(C/100), where the rounding is required to return an integer
%   number of steps.
%
%   See also STEPS2CENTS, CENTS2FREQ, FREQ2CENTS

% 2022 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,1);

% Check number of output arguments
nargoutchk(0,1);

validateattributes(cents,{'numeric'},{'real'},mfilename,'CENTS',1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

step = round(cents / 100);

end
