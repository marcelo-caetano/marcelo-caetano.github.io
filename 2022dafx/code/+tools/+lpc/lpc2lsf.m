function lsf = lpc2lsf(lin_pred,order,nframe,nchannel)
%LPC2LSF Linear prediction coefficients to line spectral frequencies.
%   LSF = LPC2LSF(LPC,ORDER,NFRAME,NCHANNEL) retuns the line spectral
%   frequencies LSF corresponding to the linear prediction coefficients
%   LPC. LPC is size ORDER+1 x NFRAME x NCHANNEL and LSF is size ORDER x
%   NFRAME x NCHANNEL.
%
%   See also TOOLS.LCP.LSF2LPC

% 2021 M Caetano SMT

% TODO: FIX HELP

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

lp_cell = mat2cell(lin_pred,order+1,ones(1,nframe),ones(1,nchannel));

lsf_cell = cellfun(@poly2lsf,lp_cell,'UniformOutput',false);

lsf = cell2mat(lsf_cell);

end
