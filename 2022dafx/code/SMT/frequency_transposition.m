function freq_out = frequency_transposition(freq_in,cents)
%FREQUENCY_TRANSPOSITION Transpose frequencies by interval in cents.
%   Detailed explanation goes here

% 2021 M Caetano SMT
% 2022 M Caetano SMT (revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,2);

% Check number of output arguments
nargoutchk(0,1);

validateattributes(freq_in,{'numeric'},{'real'},mfilename,'FIN',1)
validateattributes(cents,{'numeric'},{'real'},mfilename,'CENTS',2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

freq_out = tools.mus.cents2freq(cents,freq_in);

end
