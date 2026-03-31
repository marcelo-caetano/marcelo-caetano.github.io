function acorr_coeff = mag_spec2auto_corr(magspec,nfft,biasflag)
%MAG_SPEC2AUTO_CORR Autocorrelation coefficients from magnitude spectrum.
%   ACORR = MAG_SPEC2AUTO_COR(MS,NFFT,BIASFLAG) returns the autocorrelation
%   coefficients ACORR corresponding to the magnitude spectrum MS converted
%   with an FFT of size NFFT. The conversion is ACORR = IFFT(MS.^2,NFFT).
%
%   See also AUTO_CORR2MAG_SPEC

% 2022 M Caetano SMT

% TODO: VALIDATE ARGUMENTS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(3,3);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Power spectral density: POW == 2
pow = 2;
% NANFLAG only relevant when POW < 0
nanflag = false;
% Power spectral density
powmagspec = tools.math.lin2pow(magspec,pow,nanflag);

% Use REAL to guarantee that ACORR_COEFF is real
acorr_coeff = real(ifft(powmagspec,nfft));

% Biased AUTOCORR: Random (stochastic) process
if biasflag
    
    acorr_coeff = acorr_coeff/nfft;
    
end

end
