function mag_spec = lin_pred2mag_spec(lin_pred,err,nfft,nframe,nchannel,posspecflag,nrgflag)
%LIN_PRED2MAG_SPEC From linear prediction coefficients to magnitude spectrum.
%   MS = LIN_PRED2MAG_SPEC(LP,ERR,NFFT,NFRAME,NCHANNEL) returns the
%   magnitude spectrum MS corresponding to the linear prediction
%   coefficients LP. MS is calculated with an FFT of size NFFT and
%   multiplied by the square root of the prediction error SQRT(ERR). LP is
%   size ORDER x NFRAME x NCHANNEL, where ORDER is the prediction order,
%   NFRAME is the number of frames, and NCHANNEL is the number of channels.
%   MS is size NFFT x NFRAME x NCHANNEL, so MS contains both positive and
%   negative frequencies.
%
%   MS = LIN_PRED2MAG_SPEC(LP,ERR,NFFT,NFRAME,NCHANNEL,POSSPECFLAG) uses
%   the logical flag POSSPECFLAG to determine if MS contains only the
%   positive frequency range or full frequency range. POSSPECFLAG = TRUE
%   outputs the __positive__ frequency range and POSSPECFLAG = FALSE
%   outputs the full frequency range. The default is POSSPECFLAG = FALSE.
%
%   MS = LIN_PRED2MAG_SPEC(LP,ERR,NFFT,NFRAME,NCHANNEL,POSSPECFLAG,NRGFLAG)
%   uses the logical flag NRGFLAG to determine if MS contains the spectral
%   energy of the negative frequencies added to the positive energy.
%   NRGFLAG = TRUE add the negative spectral energy to MS and NRGFLAG =
%   FALSE does not. The default is NRGFLAG = FALSE. The functionality of
%   NRGFLAG depends on POSSPECFLAG = TRUE. NRGFLAG is ignored with a
%   warning when POSSPECFLAG = FALSE.
%
%   See also MAG_SPEC2LIN_PRED, TOOLS.CEPS.REAL_CEPS2MAG_SPEC

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0
% 2022 M Caetano SMT (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(5,7);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 5
    
    posspecflag = false;
    
    nrgflag = false;
    
elseif nargin == 6
    
    nrgflag = false;
    
end

% Check dimensions of LP
[nrow,ncol,npage] = size(lin_pred);

if ncol ~= nframe || npage ~= nchannel
    
    warning('SMT:LIN_PRED2MAG_SPEC:invalidArrayDimensions',...
        ['Invalid array dimensions.\n LP must be size ORDER x %d x %d.\n'...
        'Dimensions of LP are %d x %d x %d.'],nframe,nchannel,nrow,ncol,npage)
    
end

% Check dimensions of ERR
[nrow,ncol,npage] = size(err);

if ncol ~= nframe || npage ~= nchannel
    
    warning('SMT:LIN_PRED2MAG_SPEC:invalidArrayDimensions',...
        ['Invalid array dimensions.\n ERR must be size 1 x %d x %d.\n'...
        'Dimensions of ERR are %d x %d x %d.'],nframe,nchannel,nrow,ncol,npage)
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% LPC -> MAG SPEC
mag_spec = sqrt(err)./abs(fft(lin_pred,nfft));

if posspecflag
    
    % Return positive spectrum
    mag_spec = tools.fft2.full_spec2pos_spec(mag_spec,nfft,nrgflag);
    
end

end
