function [lpcoeff,err] = acorr2lpc(acorr,order)
%ACORR2LPC From auto correlation to linear prediction coefficients
%   [LP] = ACORR2LPC(ACORR,ORDER) returns the linear prediction coefficient
%   coefficients LP from the auto correlation coefficients ACORR truncated
%   to ORDER. ACORR is an array of size NFFT x NFRAME x NCHANNEL, where
%   NFFT is the size of the FFT, NFRAME is the number of frames, and
%   NCHANNEL is the number of channels. ORDER is an integer that determines
%   the prediction order. LP is an ORDER+1 x NFRAME x NCHANNEL array.
%
%   [LP,ERR] = ACORR2LPC(ACORR,ORDER) also returns the minimum
%   total squared prediction error ERR.
%
%   NOTE: Same functionality as Matlab's LEVINSON. This is a low-level
%   implementation, use TOOLS.LPC.AUTO_CORR2LIN_PRED instead.
%
%   See also FFT2LPC, LEVINSON

% 2021 M Caetano SMT

% WARNING! EXPERIMENTAL FUNCTION: MUST FINISH IMPLEMENTATION WITH SCRIPT
% FUNCTION USED TO BENCHMARK LEVINSON RECURSION AGAINST MATRIX INVERSION
% FUNCTION USED TO TEST BIASED/UNBIASED AUTOCORRELATION

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,2);

% Check number of output arguments
nargoutchk(0,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Anonymous function to call with ORDER
autocorr = @(ac) (solveNormalEquation(ac,order));

% Size of ACORR
[nrow,ncol,npage] = size(acorr);

% Convert ACORR to class cell
acorr_cell = mat2cell(acorr,nrow,ones(1,ncol),ones(1,npage));

% Call @AUTOCORR for each cell
[l,e] = cellfun(autocorr,acorr_cell,'UniformOutput',false);

% Convert result of CELLFUN to class array
lpcoeff = cell2mat(l);
err = reshape(cell2mat(e),1,ncol,npage);

end

% LOCAL FUNCTION TO SOLVE LINEAR SYSTEM
function [linPredCoeff,predErr] = solveNormalEquation(autoCorr,predOrd)

% Auto correlation matrix
acorrMat = toeplitz(autoCorr(1:predOrd));

% Solve linear system
linPredMat = acorrMat \ autoCorr(2:predOrd+1);

% Linear Prediction Coefficients
linPredCoeff = [1; -linPredMat(1:predOrd)];

% Minimum total squared error
predErr = linPredCoeff' * autoCorr(1:predOrd+1);

end
