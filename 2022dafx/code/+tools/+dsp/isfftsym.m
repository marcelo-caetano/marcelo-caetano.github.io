function [fftsymm,ifft_test] = isfftsym(fft_frame,nfft,symmflag)
%ISFFTSYM True for Fourier symmetrical array.
%   F = ISFFTSYM(FFT_FRAME) checks if the columns of FFT_FRAME are
%   Fourier symmetrical. FFT_FRAME is an NFFT x NFRAME x NCHANNEL array
%   where NFFT is the size of the FFT, NFRAME is the number of frames,
%   and NCHANNEL is the number of channels. F is logical TRUE if
%   FFT_FRAME is Fourier symmetrical or FALSE otherwise.
%
%   F = ISFFTSYM(FFT_FRAME,NFFT) uses NFFT as the size of the DFT.
%
%   F = ISFFTSYM(FFT_FRAME,NFFT,SYMMFLAG) uses the text flag SYMMFLAG
%   to enforce the type of test for symmetry. SYMMFLAG can be 'EXTREME',
%   'STRICT', or 'TOLERANCE'. SYMMFLAG = 'EXTREME' uses isequal,
%   SYMMFLAG = 'STRICT' uses ==, and SYMMFLAG = 'TOLERANCE' uses
%   abs(diff) < tol. The default is SYMMFLAG = 'TOLERANCE' for the syntaxes
%   above.
%
%   [F,I] = ISFFTSYM(...) also returns the logical I, which is TRUE when
%   IFFT(FFT_FRAME) is real and FALSE otherwise.
%
%   See also FS2HS, HSAMPLE2FRAMES, FFT2MAG, FFT2PH

% 2020 MCaetano SMT 0.1.1
% 2021 M Caetano SMT

% TODO: UNIT TEST

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,3);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 1
    
    % Total number of frequency bins
    [nfft,~,~] = size(fft_frame);
    
    symmflag = 'tolerance';
    
elseif nargin == 2
    
    symmflag = 'tolerance';
    
end

% Validate FFT_FRAME
validateattributes(fft_frame,{'numeric'},{'3d','nonempty','nonsparse'},mfilename,'FFT_FRAME',1)

% Validate NFFT
validateattributes(nfft,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NFFT',2)

% Validate NNFLAG
validateattributes(symmflag,{'char','string'},{'scalartext','nonempty'},mfilename,'SYMMFLAG',3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Index of upper bound of positive frequency band (Nyquist bin)
inyq = tools.spec.pos_freq_band(nfft);

% Negative frequency band
nfb = tools.spec.neg_freq_band(nfft);

% INYQ is a frequency bin when NFFT is odd
if tools.misc.iseven(nfft)
    
    ipos = inyq - 1;
    
else
    
    ipos = inyq;
    
end

% Positive frequency band (Exclude DC)
pos = fft_frame(2:ipos,:,:);

% Negative frequency band (Include Nyquist frequency bin)
neg = fft_frame(nfft-nfb+1:nfft,:,:);

% Negative frequency band (Backwards to compare with POS)
neg_flip = flip(neg);

% Complex conjugate of Flipped negative band
conj_neg_flip = conj(neg_flip);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TESTS OF FOURIER SYMMETRY WITH DIFFERENT LEVELS OF TOLERANCE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch lower(symmflag)
    
    case 'extreme'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % LEVEL 1: EXTREME
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        fftsymm = isequal(pos,conj_neg_flip);
        
    case 'strict'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % LEVEL 2: STRICT
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        bool = pos == conj_neg_flip;
        
        fftsymm = all(bool(:));
        
    case 'tolerance'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % LEVEL 3: BELOW TOLERANCE
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        abs_diff = abs((pos - conj_neg_flip));
        
        tol = max(2*eps(pos));
        
        bool = abs_diff <= tol;
        
        fftsymm = all(bool(:));
        
    otherwise
        
        warning('SMT:ISFFTSYM:UnknownFlag',['Unknown flagh.\n'...
            'SYMMFLAG can be ''TOLERANCE'', ''STRICT'', or'...
            '''EXTREME''.\nSYMMFLAG entered was %s.\n'...
            'Using default SYMMFLAG = ''TOLERANCE''.'],symmflag)
        
        abs_diff = abs((pos - conj_neg_flip));
        
        tol = max(2*eps(pos));
        
        bool = abs_diff <= tol;
        
        fftsymm = all(bool(:));
        
end

ifft_test = isreal(ifft(fft_frame,nfft));

end
