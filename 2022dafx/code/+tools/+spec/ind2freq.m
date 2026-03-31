function freq = ind2freq(ind,fs,nfft,freqlimflag)
%IND2FREQ Convert array index to frequency in Hz.
%   F = IND2FREQ(IND,Fs,NFFT) converts the array index IND into
%   non-negative frequency F in Hertz for the sampling frequency given by
%   Fs and 1 <= IND <= NFFT, where NFFT is the size of the DFT. This syntax
%   returns F with negative frequencies on the right-hand size of the
%   spectrum.
%
%   F = IND2FREQ(IND,Fs,NFFT,FREQLIMFLAG) uses FREQLIMFLAG to specify if
%   the zero frequency component of the spectrum must be shifted to the
%   center of the spectrum. FREQLIMFLAG = TRUE shifts the zero frequency
%   component to the center and FREQLIMFLAG = FALSE does not.
%   FREQLIMFLAG = FALSE is the default so F = IND2FREQ(IND,Fs,NFFT,FALSE)
%   is equivalent to F = (IND,Fs,NFFT).
%
%   The DFT bins are Fs/NFFT Hertz apart, so the conversion is
%   F = ((IND-1)*Fs)/NFFT. Fractional indices will return an error. Use
%   BIN2FREQ for fractional bin number support.
%
%   See also FREQ2IND, FREQ2BIN, BIN2FREQ, BIN2IND, IND2BIN, NYQ

% 2020 MCaetano SMT 0.1.1
% 2021 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(3,4);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 3
    
    freqlimflag = false;
    
end

% Validate IND
validateattributes(ind,{'numeric'},{'nonempty','finite','nonnan','integer','real','positive','nrows',nfft},mfilename,'IND',1)

% Validate Fs
validateattributes(fs,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NFFT',2)

% Validate NFFT
validateattributes(nfft,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NFFT',3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if freqlimflag
    
    % Index to NEGPOS bin
    bin = tools.spec.ind2bin(ind,nfft);
    
    % Bin to frequency in Hz
    freq = tools.spec.bin2freq(bin,fs,nfft);
    
else
    
    % Index to FULL bin
    bin = tools.spec.ind2bin(ind);
    
    % Bin to frequency in Hz
    freq = tools.spec.bin2freq(bin,fs,nfft);
    
end

end
