function note = freq2note(freq,ref)
%FREQ2NOTE From frequency in Hertz to note using German notation.
%   NOTE = FREQ2NOTE(F,REF) returns the note in German notation
%   corresponding to the frequency F in Hz using the conversion F = REF*A^N,
%   where A = 2^(1/12) for the equal tempered scale and REF is in Hz.
%
%   NOTE = FREQ2NOTE(F) uses REF = 440 Hz as reference for A4.
%
%   NOTE is a character array in the following format: LETTER(OPT)NUMBER
%   LETTER specifies the pitch class between A and G
%   OPT specifies that the pitch class is sharp (omit otherwise)
%   NUMBER specifies the octave between 0 and 8
%
%   Examples: A#3, G7, D0, F#6
%
%   See also NOTE2FREQ, FREQ2STEP, STEP2FREQ, STEP2NOTE, NOTE2STEP

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
    
    error('SMT:FREQ2NOTE:wrongTypeInputArg',['Wrong Type of Input Argument.\n'...
        'F must be NUMERIC not %s.\n'...
        'Type HELP FREQ2NOTE for more information.\n'],class(freq))
    
end

% Check input argument type
if ~isnumeric(ref)
    
    error('SMT:FREQ2NOTE:wrongTypeInputArg',['Wrong Type of Input Argument.\n'...
        'REF must be NUMERIC not %s.\n'...
        'Type HELP FREQ2NOTE for more information.\n'],class(ref))
    
end


% Check max and min number of steps
if freq < 16 || freq > 8000
    
    error('SMT:FREQ2NOTE:inputArgOutBound',['Input argument out of bounds.\n'...
        'F must be between 16 Hz and 8 kHz.\n'...
        'Type HELP FREQ2NOTE for more information.\n'])
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Convert frequency in Hertz to number of steps in equal tempered scale
step = tools.mus.freq2step(freq,ref);

% Convert from number of steps in equal tempered scale to note (German notation)
note = tools.mus.step2note(step);

end
