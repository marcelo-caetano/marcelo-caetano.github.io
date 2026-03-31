function erb = hertz2erb(freq)
%HERTZ2ERB From frequency in Hertz to ERB.
%   E = HERTZ2ERB(F) returns the equivalent rectangular bandwidth E that
%   corresponds to the frequency F in Hertz.
%   The conversion is E = 6.44*(log2(229+F)-7.84).
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

validateattributes(freq,{'numeric'},{'real'},mfilename,'F',1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

erb = 6.44 * (log2(229 + freq) - 7.84);

end
