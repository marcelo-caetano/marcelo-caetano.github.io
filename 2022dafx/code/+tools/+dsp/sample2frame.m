function frame = sample2frame(sample,framelen,hop,causalflag,roundflag)
%SAMPLE2FRAME Convert time sample to frame number.
%   FR = SAMPLE2FRAME(S,M,H,CAUSALFLAG) returns the frame numbers FR
%   corresponding to the time samples S at the center of an M-sample long
%   window sliding by a hopsize of H samples. The text flag CAUSALFLAG
%   specifies the causality of the first window as 'NON', 'CAUSAL', or
%   'ANTI'. FR is an array the same size as S. NOTE: FR is an integer only
%   when S corresponds to the sample at the center of the frame. Otherwise,
%   FR will have a fractional part corresponding to the difference between
%   the sample number at the center of the frame and S. Use ROUNDFLAG to
%   manage the fractional part.
%
%   FR = SAMPLE2FLAG(S,M,H,CAUSALFLAG,ROUNDFLAG) uses the logical flag
%   ROUNDFLAG top round off the fractional part of FR whenever S does not
%   correspond to the sample at the center of a frame.
%
%   See also FRAME2SAMPLE

% 2016 M Caetano
% 2020 MCaetano SMT 0.1.1 (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(4,5);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 4
    
    roundflag = false;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

center_win = tools.dsp.centerwin(framelen,causalflag);

frame = (sample - center_win) ./ hop + 1;

if roundflag
    
    frame = round(frame);
    
end

end
