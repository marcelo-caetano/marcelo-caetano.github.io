function linphase = zero_phase2lin_phase(zeroph,framelen)
%ZERO_PHASE2LIN_PHASE Zero phase to linear phase.
%   LP = ZERO_PHASE2LIN_PHASE(ZP,M) flips the zero phase signal ZP around
%   the center CW of the window with M samples. CW is the sample at the
%   center of the window obtained as CW = TOOLS.DSP.CENTERWIN(W,'CAUSAL').
%
%   See also LIN2ZERO, FFTFLIP, IFFTFLIP

% 2016 MCaetano
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2021 M Caetano SMT (Revised for stereo)

% TODO: VALIDATE INPUT ARGUMENTS
% TODO: CHECK HELP

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK FUNCTION INPUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,2);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Left half of the window
winleft = tools.dsp.leftwin(framelen);

% Flip back right and left halves of the window
linphase = [zeroph(end-winleft+1:end,:,:);zeroph(1:end-winleft,:,:)];

end
