function order = spec_env_order(f0,fs,cepswinflag,specenvflag)
%SPEC_ENV_ORDER Order of the spectral envelope.
%   ORDER = SPEC_ENV_ORDER(F0,Fs) returns the optimal ORDER of the
%   spectral envelope estimated via cepstral smoothing with a rectangular
%   window. ORDER is the number of frequency bins corresponding to the
%   cutoff frequency for the rectangular lowpass filter. ORDER is
%   calculated as ORDER = Fs/(2*F0) where F0 is the fundameltal
%   frequency and Fs is the sampling frequency.
%
%   ORDER = SPEC_ENV_ORDER(F0,Fs,CEPSWINFLAG) uses the window specified by
%   CEPSWINFLAG to lifter the log magnitude spectrum. CEPSWINFLAG is an
%   integer between 1 and 14 that specifies the window type. Type HELP
%   INFOWIN for more information. CEPSWINFLAG = 1 is the default for the
%   rectangular window. CEPSWINFLAG > 1 adjusts the optimal ORDER for
%   cepstral smoothing with CEPSWINFLAG.
%
%   ORDER = SPEC_ENV_ORDER(F0,Fs,CEPSWINFLAG,SPECENVFLAG) uses the text flag
%   SPECENVFLAG to define the spectral envelope estimation method.
%   SPECENVFLAG can be either the default 'CEPS' or 'LPC'
%   FACT is an integer that
%   depends
%   SPECENVFLAG specifies CONST as
%   SPECENVFLAG = 'CEPS' sets CONST = 2 and
%   SPECENVFLAG = 'LPC' sets CONST = 4
%
%   Note: SPECENVFLAG is class CHAR
%
%   See also TOOLS.CEPS.ADJUST_CEPS_ORDER

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0
% 2021 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,4);

% Check number of output arguments
nargoutchk(0,1);

% Default SPECENVFLAG & CEPSWINFLAG
if nargin == 2
    
    cepswinflag = 1;
    
    specenvflag = 'tenv';
    
elseif nargin == 3
    
    specenvflag = 'tenv';
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Call low-level function TOOLS.SPEC.ORDER_SPEC_ENV
order = tools.ceps.order_spec_env(f0,fs,cepswinflag,specenvflag);

end
