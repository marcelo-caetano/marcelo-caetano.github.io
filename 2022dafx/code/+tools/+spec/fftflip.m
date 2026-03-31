function flipped = fftflip(spec,nfft)
%FFTFLIP Flip left and right halves of the FFT.
%   W = FFTFLIP(S,NFFT) flips the zero frequency component of the DFT
%   spectrum S to the center by swapping the left and right halves of S
%   around the Nyquist bin NYQ. S is size NBIN x NFRAME x NCHANNEL, where
%   NBIN is the number of frequency bins, NFRAME is the number of frames,
%   and NCHANNEL is the number of channels. When NBIN > NFFT, the spectrum
%   S has been padded with NBIN - NFFT samples.
%
%   See also IFFTFLIP, FLEXPAD, MKFREQ, LIN2ZERO, ZERO2LIN

% 2020 MCaetano SMT 0.1.1
% 2020 MCaetano SMT 0.2.0 (Revised)
% 2021 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number if input arguments
narginchk(2,2);

% Check number if output arguments
nargoutchk(0,1);

% Validate SPEC
validateattributes(spec,{'numeric'},{'3d','nonempty','nonsparse'},mfilename,'SPEC',1)

% Validate NFFT
validateattributes(nfft,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NFFT',2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Total number of frequency bins
[nbin,~] = size(spec);

% Index of Nyquist frequency (Non-flipped spectrum)
inyq = tools.spec.nyq_ind(nfft);

% Flip zero frequency component to the center
flipped = [spec(inyq+1:nbin,:,:);spec(1:inyq,:,:)];

end
