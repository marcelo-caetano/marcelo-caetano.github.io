function wav = mksnd(amp,ph,fs,nsample,funcflag,posfreqflag)
%MKSND Make synthetic sound.
%   S = MKSND(A,P,Fs,NSAMPLE) returns the synthetic sound S as A*cos(PH),
%   where PH is the polynomial phase returned by the function MKPOLYPH
%   using the parameters in P. A is size NPART x 1 and P is size NPART x
%   ORDER, where NPART is the number of partials and ORDER is the order of
%   the polynomial phase. So ORDER == 2 is constant frequency plus initial
%   phase and ORDER == 4 is cubic phase. Type HELP TOOLS.SYNTH.MKPOLYPHASE
%   for further information.
%
%   S = MKSND(A,P,Fs,NSAMPLE,FUNCFLAG) uses the text flag FUNCFLAG to selet
%   the synthesis function. FUNCFLAG = 'COS' is the default to use cos(PH),
%   FUNCFLAG = 'SIN' uses sin(PH), and FUNCFLAG = 'CIS' uses a cisoid
%   (complex sinusoid) equivalent to cos(PH) + j*sin(PH).
%
%   S = MKSND(A,P,Fs,NSAMPLE,FUNCFLAG,POSFREQFLAG) uses the logical flag
%   POSFREQFLAG to determine if the cisoid should have positive or negative
%   frequency. POSFREQFLAG = TRUE is the default for positive frequency
%   and POSFREQFLAG = FALSE sets negative frequency. POSFREQFLAG only has
%   an effect when FUNCFLAG = 'CIS'.
%
%   See also MKPOLYPH, TOOLS.MATH.CIS

% 2021 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(4,6);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 4
    
    funcflag = 'cos';
    
    posfreqflag = true;
    
elseif nargin == 5
    
    posfreqflag = true;
    
end

validateattributes(amp,{'numeric'},{'finite','nonnan'},mfilename,'AMP',1)

validateattributes(ph,{'numeric'},{'finite','nonnan'},mfilename,'PH',2)

validateattributes(fs,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'Fs',3)

validateattributes(nsample,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NSAMPLE',4)

validateattributes(funcflag,{'char','string'},{'scalartext'},mfilename,'FUNCFLAG',5)

validateattributes(posfreqflag,{'numeric','logical'},{'scalar','binary'},mfilename,'POSFREQFLAG',6)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch lower(funcflag)
    
    case 'cos'
        
        synthFun = @cos;
        
    case 'sin'
        
        synthFun = @sin;
        
    case 'cis'
        
        synthFun = @(x) tools.math.cis(x,posfreqflag);
        
    otherwise
        
        warning('SMT:MKSND:InvalidArgument',['Invalid input argument.\n'...
            'FUNCFLAG must be ''COS'' ''SIN'' ''CIS''.\n'...
            'Value entered was FUNCFLAG = %s.\n'...
            'Using default FUNCFLAG = ''COS''.\n'],funcflag);
        
        synthFun = @cos;
        
end

phase = tools.synth.mkpolyph(ph,fs,nsample);

part = amp'.*synthFun(phase);

wav = sum(part,2);

end
