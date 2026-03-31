function [hs,nws] = allcolahopsize(framelen,winflag)
%ALLCOLAHOPSIZE All COLA hop sizes for a window.
%   [H,M'] = ALLCOLAHOPSIZE(M,WINFLAG) returns all hop sizes H for which a
%   WINTYPE window of length M samples is COLA(H). M' is the maximum
%   window length with any COLA(
%
%   See also COLADEN, COLASUM, ISCOLA, COLAHOPSIZE, COLAWL, OVERLAP2HOPSIZE

% 2016 M Caetano
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2021 M Caetano SMT (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Number of input arguments
narginchk(2,2);

% Number of output arguments
nargoutchk(0,2);

validateattributes(framelen,{'numeric'},{'scalar','integer','positive'},mfilename,'FRAMELEN',1)
validateattributes(winflag,{'numeric'},{'scalar','integer','>=',1,'<=',14},mfilename,'WINFLAG',2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[maxhs,nws] = tools.ola.colahopsize(framelen,winflag);

k = 1:maxhs;

hs = k(rem(maxhs ./ k,1) == 0);

% Return column vector
hs = hs(:);

end
