function opt = adjust_ceps_order(order,winflag)
%ADJUST_CEPS_ORDER Adjust cepstral order.
%   OPT = ADJUST_CEPS_ORDER(ORDER,WINFLAG) adjusts the cepstral order ORDER
%   for cepstral smoothing with WINFLAG. ORDER is the number of frequency
%   bins corresponding to the cutoff frequency for a rectangular window.
%   OPT is the optimal order for cepstral smoothing with the cepstral
%   window defined by WINFLAG. Type HELP WHICHWIN for information about the
%   available windows.
%
%   See also TOOLS.SPEC.ORDER_SPEC_ENV

% 2020 MCaetano SMT 0.1.1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,2);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Adjust cepstral order to WINFLAG (ORDER is positive frequency band)
opt = ceil(tools.dsp.infowin(winflag,'csf')*order);

end
