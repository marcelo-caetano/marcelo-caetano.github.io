function bin = ind2bin(ind,nfft)
%IND2BIN Convert array index into frequency bin.
%   K = IND2BIN(IND) converts the array indices IND into non-negative
%   frequency bin numbers K = IND - 1. IND can be a scalar, array, matrix,
%   or multidimensional array. However, IND must be positive integers
%   otherwise IND2BIN throws an error.
%
%   K = IND2BIN(IND,NFFT) converts IND into negative and positive bin
%   numbers by shifting the zero-frequency bin to the center of the
%   spectrum. The shift uses NFFT as reference for the Nyquist bin.
%
%   See also BIN2IND, IND2FREQ, FREQ2IND, FREQ2BIN, BIN2FREQ, BINSHIFT

% 2020 MCaetano SMT 0.1.1
% 2021 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,2);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 1
    
    % Invalid NFFT (unused)
    nfft = nan(1);
    
end

% Validate IND
validateattributes(ind,{'numeric'},{'nonempty','finite','nonnan','integer','real','positive'},mfilename,'IND',1)

% Additional validation when NFFT is also input argument
if ~isnan(nfft)
    
    % Additional constraint for IND
    validateattributes(ind,{'numeric'},{'nrows',nfft},mfilename,'IND',1)
    
    % Validate NFFT
    validateattributes(nfft,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NFFT',2)
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Conversion
bin = ind - 1;

% Shift zero-frequency bin to the center of the spectrum
if ~isnan(nfft)
    
    bin = tools.spec.binshift(bin,nfft);
    
end

end
