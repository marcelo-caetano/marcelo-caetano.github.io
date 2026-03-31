function freq = erb2hertz(erb)
%ERB2HERTZ From ERB to frequency in Hertz.
%   F = ERB2HERTZ(E) returns the the frequency F in Hertz that
%   corresponds to the equivalent rectangular bandwidth E.
%   The conversion is F = pow2(E/6.44+7.84)-229.
%
%   See also ERB2HERTZ, HERTZ2CENTS, CENTS2HERTZ

% 2022 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,1);

% Check number of output arguments
nargoutchk(0,1);

validateattributes(erb,{'numeric'},{'real'},mfilename,'E',1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

freq = pow2(erb./6.44 + 7.84) - 229;

end
