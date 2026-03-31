function nsample = numsample(nframe,framelen,hop,causalflag)
%NSAMPLES Number of time samples.
%   NSAMPLE = NSAMPLES(NFRAME,M,H,CAUSALFLAG) returns the number of samples
%   NSAMPLE that a signal will have when NFRAME frames of size M each are
%   overlap-added with a hop size of H and first window centered by CAUSALFLAG.
%   CAUSALFLAG is a text flag that specifies the sample corresponding to
%   the center of the first analysis window. CAUSALFLAG can be 'NON',
%   'CAUSAL', or 'ANTI'. Use the OLA function to reconstruct the orginal
%   signal with the original duration.
%
%   See also NFRAME

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

% Offset for causal processing
offset = tools.dsp.tools.dsp.causal_offset(framelen,causalflag);

% Number of samples
nsample = hop*nframe - offset;

end
