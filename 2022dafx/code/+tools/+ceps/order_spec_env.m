function order = order_spec_env(f0,fs,winflag,specenvflag)
%ORDER_SPEC_ENV Order of the spectral envelope.
%   ORDER = ORDER_SPEC_ENV(F0,Fs,WINFLAG,SPECENVFLAG) returns the optimal
%   ORDER of the spectral envelope calculated as ORDER = Fs/(FACT*F0),
%   where F0 is the fundamental frequency, Fs is the sampling frequency,
%   and FACT is an integer that depends on SPECENVFLAG. SPECENVFLAG is a
%   text flag that determines the spectral envelope estimation method used.
%   SPECENVFLAG can be 'LPC', 'CEPS', or 'TENV'. The constant FACT = 2 when
%   SPECENVFLAG = 'CEPS' or SPECENVFLAG = 'TENV' and FACT = 4 when
%   SPECENVFLAG = 'LPC'.
%
%   WINFLAG is an integer between 1 and 14 that specifies the window type.
%   WINFLAG = 1 is the default for the rectangular window. See HELP INFOWIN
%   for more information. WINFLAG > 1 adjust the optimal ORDER for cepstral
%   smoothing with WINFLAG.
%
%   ORDER is the number of frequency bins corresponding to the cutoff
%   frequency for the rectangular lowpass filter. For other windows, ORDER
%   increases proportionally to the width of the main lobe.
%
%   See also TOOLS.CEPS.ADJUST_CEPS_ORDER

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(4,4);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check WINFLAG
if winflag < 1 || winflag > 14
    
    warning('SMT:ORDER_SPEC_ENV:invalidInputArgument',...
        ['Invalid input argument WINFLAG\n'...
        'WINFLAG must be between 1 and 14\n'...
        'WINFLAG entered was %d\n'...
        'Using default WINFLAG = 1 for the rectangular window\n'],winflag);
    
    % Rectangular window
    winflag = 1;
    
end

switch lower(specenvflag)
    
    case {'ceps','tenv'}
        
        fact = 2;
        
    case {'lpc','lsf','rc','lar','isp','acs'}
        
        fact = 4;
        
    otherwise
        
        warning('SMT:ORDER_SPEC_ENV:invalidInputArgument',...
            ['Invalid input argument SPECENVFLAG\n'...
            'SPECENVFLAG must be LPC, CEPS, or TENV\n'...
            'SPECENVFLAG entered was %s\n'...
            'Using default SPECENVFLAG = TENV'],specenvflag);
        
        fact = 2;
        
end

% ORDER for rectangular window
order = fix(fs/(fact*f0));

% Adjust ORDER for other windows when SPECENVFLAG = CEPS | TENV
if any(strcmpi(specenvflag,["ceps" "tenv"])) && winflag > 1
    
    order = tools.ceps.adjust_ceps_order(order,winflag);
    
end

end
