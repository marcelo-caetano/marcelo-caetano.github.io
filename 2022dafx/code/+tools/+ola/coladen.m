function den = coladen(winflag)
%COLADEN COLA denominator for different windows.
%   DEN = tools.ola.coladen(WINFLAG) returns DEN for a window of type WINFLAG.
%
%   A window W is COLA(H) if W has the constant overlap-add property at hop
%   size H = M/DEN, expressed as a fraction of the window size M. Type
%   WHICHWIN(WINFLAG) for the names of the different windows supported.
%
%   See also COLASUM, ISCOLA, COLAWL, COLAHOPSIZE, ALLCOLAHOPSIZE, OVERLAP2HOPSIZE

% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0
% 2021 M Caetano SMT (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Number of input arguments
narginchk(1,1);

% Number of output arguments
nargoutchk(0,1);

% Validate input
validateattributes(winflag,{'numeric'},{'scalar','integer','>=',1,'<=',7},mfilename,'WINFLAG',1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

den = tools.dsp.infowin(winflag,'den');

end
