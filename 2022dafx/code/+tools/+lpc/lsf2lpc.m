function lpc = lsf2lpc(lsf,order,nframe,nchannel)
%LSF2LPC Line spectral frequencies to linear prediction coefficients.
%   LPC = LSF2LPC(LSF,ORDER,NFRAME,NCHANNEL) retuns the linear prediction
%   coefficients LPC corresponding to the line spectral frequencies LSF.
%   LSF is size ORDER x NFRAME x NCHANNEL and LPC is size ORDER+1 x NFRAME
%   x NCHANNEL.
%
%   See also TOOLS.LCP.LPC2LSF

% 2021 M Caetano SMT

% TODO: FIX HELP
% TODO: FIX CONVERSION FOR HIGH ORDER

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

% Convert to cell array
lsf_cell = mat2cell(lsf,order,ones(1,nframe),ones(1,nchannel));

% Apply LSF2POLY' to each cell in array
lpc_cell = cellfun(@(x) lsf2poly(x)',lsf_cell,'UniformOutput',false);

% Convert to array
lpc = cell2mat(lpc_cell);

end
