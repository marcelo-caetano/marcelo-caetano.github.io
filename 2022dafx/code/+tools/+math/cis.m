function y = cis(x,posfreqflag)
%CIS Cisoid or complex exponential
%   Y = CIS(X) returns Y = cos(X) + j*sin(X).
%
%   Y = CIS(X,POSFREQFLAG) uses the logical flag POSFREQFLAG to generate
%   positive or negative frequency. POSFREQFLAG = TRUE is the default for
%   positive frequency and POSFREQFLAG = FALSE generates negative
%   frequencies as Y = COS(X) - j*SIN(X).
%
%   See also

% 2021 MCaetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check the number of input arguments
narginchk(1,2);

% Check the number of output arguments
nargoutchk(0,1);

if nargin == 1
    
    posfreqflag = true;
    
end

validateattributes(x,{'numeric'},{'finite'},mfilename,'X',1)

validateattributes(posfreqflag,{'numeric','logical'},{'scalar','finite','nonnan','binary'},mfilename,'POSFREQFLAG',2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Phase signal
if posfreqflag
    
    ph_sig = 1;
    
else
    
    ph_sig = -1;
    
end

y = exp(1j*ph_sig*x);

end
