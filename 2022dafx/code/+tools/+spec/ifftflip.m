function spec = ifftflip(flipped,nfft)
%IFFTFLIP Invert FFTFLIP.
%   S = IFFTFLIP(W,NFFT) flips the zero frequency component of the flipped
%   FFT spectrum W back to the beginning of S by swapping the left and
%   right halves of W around NFFT/2-1. S is size NBIN x NFRAME x NCHANNEL,
%   where NBIN is the number of frequency bins, NFRAME is the number of
%   frames, and NCHANNEL is the number of channels. When NBIN > NFFT, the
%   spectrum S has been padded with NBIN-NFFT samples.
%
%   See also FFTFLIP, MKFREQ, LIN2ZERO, ZERO2LIN

% 2020 MCaetano SMT 0.1.1
% 2021 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number if input arguments
narginchk(2,2);

% Check number if output arguments
nargoutchk(0,1);

% Validate SPEC
validateattributes(flipped,{'numeric'},{'3d','nonempty','nonsparse'},mfilename,'FLIPPED',1)

% Validate NFFT
validateattributes(nfft,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NFFT',2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Total number of frequency bins
[nbin,~,~] = size(flipped);

% Length of negative frequency band
neg = tools.spec.neg_freq_band(nfft);

% Flip negative band back to the right
spec = [flipped(neg+1:nbin,:,:);flipped(1:neg,:,:)];

% Nyquist bin
inyq = tools.spec.nyq_ind(nfft);

%TODO: Use ISFFTSYM and logical indexing to force Fourier symmetry.
% Overwrite only negative band bins thar are different than positive band
% Check that Nyquist bin is also in negative band (padded spectra)
if spec(inyq) ~= spec(nbin-neg)
    
    % Replicate Nyquist bin in negative frequency band
    spec(nbin-neg) = spec(inyq);
    
end

end
