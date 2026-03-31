function step = freq2step(freq,ref)
%FREQ2STEP Frequency in Hertz to number of steps.
%   N = FREQ2STEP(F,REF) returns the number of steps N above the reference
%   frequency REF in Hertz corresponding to N steps using the conversion
%   N = 12*log2(F/REF) for the equal tempered scale with 12 semitones.
%
%   N = FREQ2STEP(F) uses REF = 440 Hz by default as reference for A4.
%
%   See also STEP2FREQ, NOTE2FREQ, FREQ2NOTE, STEP2NOTE, NOTE2STEP

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0
% 2021 M Caetano SMT (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,2);

% Check number of output arguments
nargoutchk(0,1);

% Default reference
if nargin == 1
    
    % A4 == 440 Hz
    ref = 440;
    
end

% Check input argument type
if ~isnumeric(freq)
    
    error('SMT:FREQ2STEP:wrongTypeInputArg',['Wrong Type of Input Argument.\n'...
        'X must be class NUMERIC not %s.\n'...
        'Type HELP FREQ2STEP for more information.\n'],class(freq))
    
end

% Check input argument type
if ~isnumeric(ref)
    
    error('SMT:FREQ2STEP:wrongTypeInputArg',['Wrong Type of Input Argument.\n'...
        'REF must be class NUMERIC not %s.\n'...
        'Type HELP FREQ2STEP for more information.\n'],class(ref))
    
end

% Check max and min frequency in Hz
if min(freq) < 16 || max(freq) > 8000
    
    error('SMT:FREQ2STEP:inputArgOutBound',['Input argument out of bounds.\n'...
        'FREQ must be between 16 Hz and 8 kHz.\n'...
        'Type HELP FREQ2STEP for more information.\n'])
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cents = tools.mus.hertz2cents(freq,ref);

step = tools.mus.cents2step(cents);

end
