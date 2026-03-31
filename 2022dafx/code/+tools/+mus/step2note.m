function note = step2note(step)
%STEP2NOTE Convert number of steps to note in German system.
%   NOTE = STEP2NOTE(N) converts N steps in the equal tempered scale to the
%   corresponding note in the German system using A4 as reference. N must
%   be an integer number of steps.
%
%   See also NOTE2STEP, NOTE2FREQ, FREQ2STEP, FREQ2NOTE

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0
% 2021 M Caetano SMT (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,1);

% Check number of output arguments
nargoutchk(0,1);

% Check input argument type
if ~isnumeric(step)
    
    error('TypeInArg:wrongType',['Wrong Type of Input Argument.\n'...
        'NOTE must be class CHAR not %s.\n'...
        'Type HELP STEP2NOTE for more information.\n'],class(step))
    
end

% Check if number of steps is integer
if rem(step,1) ~= 0
    
    error('SMT:STEP2NOTE:wrongInputArg',['Wrong Type of Input Argument.\n'...
        'STEP must be an integer.\n'...
        'Type HELP STEP2NOTE for more information.\n'])
    
end

% Check that pitch class is between A(=65) and G(=71)
if step < -57 || step > 50
    
    error('SMT:STEP2NOTE:InputArgOutBound',['Input argument out of bounds.\n'...
        'STEP must be between -57 and 50.\n'...
        'Type HELP STEP2NOTE for more information.\n'])
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

freqtable = readtable('ScaleFreqs.txt');

match = table2array(freqtable(:,2)) == step;

note = table2cell(freqtable(match,1));

end
