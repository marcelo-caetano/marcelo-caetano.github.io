function colalen = colawinlen(framelen,winflag)
%COLAWINLEN COLA window length.
%   COLALEN = COLA(FRAMELEN,WINFLAG) returns the largest COLA window length
%   COLALEN for a WINFLAG window of initial length FRAMELEN.
%
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
%   See also COLADEN, COLASUM, ISCOLA, COLAHOPSIZE, ALLCOLAHOPSIZE, OVERLAP2HOPSIZE

% 2016 M Caetano
% 2021 M Caetano SMT (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Number of input arguments
narginchk(2,2);

% Number of output arguments
nargoutchk(0,1);

validateattributes(framelen,{'numeric'},{'scalar','integer','positive'},mfilename,'FRAMELEN',1)
validateattributes(winflag,{'numeric'},{'scalar','integer','>=',1,'<=',7},mfilename,'WINFLAG',2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch winflag
    
    case 1
        
        % Rectangular
        colalen = framelen;
        return
        
    case 4
        
        % Hanning
        corr = 1;
        
    otherwise
        
        % Bartlett, Hann, Blackman, Blackman-Harris, Hamming
        corr = -1;
        
end

if tools.misc.iseven(framelen)
    
    % Even numbers up to FRAMELEN
    num = 2:2:framelen;
    
    % COLA denominator for WINFLAG window
    den = tools.ola.coladen(winflag);
    
    % TRUE when NUM == k*DEN (k integer)
    bool_mult = rem(num,den) == 0;
    
    % Find all EVEN multiples of DEN
    mult = num(bool_mult);
    
    % Return largest
    colalen = mult(end);
    
else
    
    % Odd numbers up to FRAMELEN
    num = 1:2:framelen;
    
    % COLA denominator for WINFLAG window
    den = tools.ola.coladen(winflag);
    
    % TRUE when (NUM+CORR) == k*DEN (k integer)
    bool_mult = rem(num + corr,den) == 0;
    
    % Find all ODD multiples of DEN
    mult = num(bool_mult);
    
    % Return largest
    colalen = mult(end);
    
end

end
