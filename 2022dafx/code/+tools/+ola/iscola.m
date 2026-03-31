function bool = iscola(framelen,hop,winflag)
%ISCOLA TRUE when window is COLA(H)
%   BOOL = ISCOLA(M,H,WINFLAG) returns TRUE if a length M WINFLAG window
%   is COLA(H). A COLA(H) window ovelap-adds to a constant at hop size H.
%
%   See also COLADEN, COLASUM, COLAWINLEN, COLAHOPSIZE, ALLCOLAHOPSIZE, OVERLAP2HOPSIZE

% 2016 M Caetano
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2021 M Caetano SMT (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(3,3);

% Check number of output arguments
nargoutchk(0,1);

validateattributes(framelen,{'numeric'},{'scalar','integer','real','positive'},mfilename,'FRAMELEN',1)
validateattributes(hop,{'numeric'},{'scalar','integer','real','positive'},mfilename,'HOP',2)
validateattributes(winflag,{'numeric'},{'scalar','integer','>=',1,'<=',14},mfilename,'WINFLAG',3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Correct for odd FRAMELEN
if tools.misc.iseven(framelen)
    
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

colafrac = tools.ola.coladen(winflag);

colahop = tools.ola.colahopsize(framelen,winflag);

bool = rem(framelen + corr,colafrac) == 0 && rem(colahop,hop) == 0;

end
