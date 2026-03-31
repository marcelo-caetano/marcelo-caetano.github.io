function [onset,offset] = begin2end(framelen,causalflag)
%BEGIN2END Onset at beginning to offset at the end.
%
%   [ONSET,OFFSET] = BEGIN2END(WINSIZE,CENTER)
%
%   See also

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

switch lower(causalflag)
    
    case 'non'
        
        onset = 0;
        offset = 0;
        
    case 'causal'
        
        onset = tools.dsp.leftwin(framelen);
        offset = -tools.dsp.rightwin(framelen);
        
    case 'anti'
        
        onset = -(tools.dsp.rightwin(framelen)+1);
        offset = tools.dsp.leftwin(framelen)+1;
        
    otherwise
        
        warning('SMT:BEGIN2END:invalidFlag',...
            ['CAUSALFLAG must be CAUSAL, NON or ANTI.\n'...
            'CAUSALFLAG entered was %s.\n'
            'Using default CAUSALFLAG = NON'],...
            causalflag);
        
        onset = 0;
        offset = 0;
        
end

end
