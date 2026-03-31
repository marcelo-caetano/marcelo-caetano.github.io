function fft_frame = pos_spec2full_spec(posspec,nfft,nrgflag)
%POS_SPEC2FULL_SPEC From positive spectrum to full spectrum.
%   FFT = POS_SPEC2FULL_SPEC(PS) returns the NFFT-point
%   full FFT spectrum corresponding to the positive frequency half of the
%   spectrum PS. PS must be complex and length NFFT/2+1.
%
%   FFT = POS_SPEC2FULL_SPEC(PS,NFFT) uses NFFT for the size
%   of the FFT.
%
%   FFT = POS_SPEC2FULL_SPEC(PS,NFFT,NRGFLAG) uses the logical
%   flag NRGFLAG to specify if PS also contains the spectral energy of the
%   negative frequency bins. NRGFLAG = TRUE removes the negative spectral
%   energy from PS before returning the full FFT spectrum and NRGFLAG =
%   FALSE does not. The default is NRGFLAG = FALSE for the previous
%   syntaxes.
%
%   See also FULL_SPEC2POS_SPEC,
%   FFT2POS_MAG_SPEC, FFT2POS_PHASE_SPEC

% 2020 M Caetano SMT 0.1.2
% 2021 M Caetano SMT (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,3);

% Check number of output arguments
nargoutchk(0,1);

if isreal(posspec)
    error('PS must be complex')
end

% Defaults
if nargin == 1
    
    [nrow,~] = size(posspec);
    
    nfft = 2*(nrow - 1);
    
    nrgflag = false;
    
elseif nargin == 2
    
    % Do not compensate for the energy of negative frequencies
    nrgflag = false;
    
end

% Check that NFFT/2+1 == SIZE(POSSPEC,1)
[nrow,nframe,nchannel] = size(posspec);

if nfft ~= 2*(nrow - 1)
    
    warning('SMT:POS_SPEC2FULL_SPEC:wrongInputArgument',...
        ['Input argument NFFT does not match the dimensions of PS\n'...
        'PS must be NFFT/2+1 x NFRAME\nSize of PS entered was %d x %d\n'...
        'NFFT entered was %d\nUsing NFFT = %d'],nrow,nframe,nfft,2*(nrow - 1));
    
    nfft = 2*(nrow - 1);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nrgflag
    
    inyq = tools.spec.nyq_ind(nfft);
    
    posspec(2:inyq-1,:,:) = 0.5*posspec(2:inyq-1,:,:);
    
end

% CONCATENATE FLIPPED COMPLEX CONJUGATE: conj(flipud(posspec(2:nfft/2)))

% Nyquist index
inyq = tools.spec.nyq_ind(nfft);

% Flipped complex conjugate of negative half of FFT spectrum
flipped_conj_negspec = posspec(2:inyq-1,:,:);

% Complex conjugate of negative half of FFT spectrum
% conj_negspec = flipud(flipped_conj_negspec);
conj_negspec = flip(flipped_conj_negspec,1);

% Negative half of FFT spectrum
negspec = conj(conj_negspec);

% FFT spectrum
fft_frame = [posspec;negspec];

end
