function [colahop,colalen] = colahopsize(framelen,winflag)
%COLAHOPSIZE Hop size COLA(H) for WINFLAG window of initial length FRAMELEN.
%   [H,WS] = COLAHOPSIZE(FRAMELEN,WINFLAG) generates H = WS/DEN for which a WINFLAG window is
%   COLA(H). Type WS = COLAWL(FRAMELEN,WINFLAG) for WS and DEN = COLADEN(WINFLAG) for DEN.
%   The possibilities for WINFLAG are:
%
%   1 - Rectangular
%   2 - Bartlett
%   3 - Hann
%   4 - Hanning
%   5 - Blackman
%   6 - Blackman-Harris
%   7 - Hamming
%
%   See also COLADEN, COLASUM, COLAWL, ISCOLA, ALLCOLAHOPSIZE, OVERLAP2HOPSIZE

% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0
% 2021 M Caetano SMT (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Number of input arguments
narginchk(2,2);

% Number of output arguments
nargoutchk(0,2);

validateattributes(framelen,{'numeric'},{'scalar','integer','positive'},mfilename,'FRAMELEN',1)
validateattributes(winflag,{'numeric'},{'scalar','integer','>=',1,'<=',7},mfilename,'WINFLAG',2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get COLA window length
colalen = tools.ola.colawinlen(framelen,winflag);

% Correct for odd FRAMELEN
if tools.misc.iseven(colalen)
    
    corr = 0;
    
else
    
    switch winflag
        
        case 1
            
            % Rectangular
            corr = 0;
            
        case 4
            
            % Hanning
            corr = 1;
            
        otherwise
            
            % Bartlett, Hann, Blackman, Blackman-Harris, Hamming
            corr = -1;
            
    end
    
end

den = tools.ola.coladen(winflag);

% Calculate COLA hopsize
colahop = (colalen + corr) / den;

end
