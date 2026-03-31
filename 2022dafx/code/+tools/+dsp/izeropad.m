function frame = izeropad(zpadframe,framelen)
%IZPAD Remove zero padding.
%   FR = IZPAD(ZP,WINLEN) returns the matxix FR without the trailing zeros
%   introduced by zero-padding. FR is the same as ZP with the columns
%   truncated to WINLEN.
%
%   See also ZPAD, FLEXPAD

% 2016 M Caetano
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2021 M Caetano SMT (Revised for stereo)

% TODO: CHECK IF WINLEN < SIZE(ZP,1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,2);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Remove zero padding by truncating
frame = zpadframe(1:framelen,:,:);

end
