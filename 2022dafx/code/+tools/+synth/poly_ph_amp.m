function [amp_model,ph_model,order] = poly_ph_amp(amp_coeff,ph_coeff,fs,nsample)
%MKPOLYPH Make polynomial phase.
%   P = MKPOLYPH(PARAM,Fs,NSAMPLE) returns the polynomial phase P
%   corresponding to the phase parameters PARAM. PARAM is size NPART x ORDER
%   where NPART is the number of partials and ORDER is the order of the
%   polynomial phase. For example, ORDER == 4 determines cubic phase as:
%
%   P = P0 + 2*pi*P1*TIME + 2*pi*(P2*TIME)^2 + 2*pi*(P3*TIME)^3 + ...
%   where TIME = (0:NSAMPLE-1)/Fs
%
%   Note that PARAM is always interpreted as:
%   PARAM(:,1) => P0 (initial phase in radians)
%   PARAM(:,2) => P1 (linear frequency in Hertz)
%   PARAM(:,3) => P2 (quadratic frequency in Hertz)
%   :
%   :
%   Thus ORDER < 2 will return an error.
%
%   See also MKSND

% 2020 MCaetano SMT 0.2.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check the number of input arguments
narginchk(4,4);

% Check the number of output arguments
nargoutchk(0,3);

validateattributes(ph_coeff,{'numeric'},{'finite'},mfilename,'PARAM',1)

validateattributes(fs,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'Fs',2)

validateattributes(nsample,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NSAMPLE',3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[npart,order] = size(ph_coeff);

if order < 2
    
    error('SMT:MKPOLYPH:InvalidInputArgument',...
        ['Invalid input argument.\n'...
        'ORDER must be >= 2.\n'...
        'ORDER entered was %d.\n'],order)
    
end

time_sample = repmat((0:nsample-1)',1,1,npart);

aux_ph = permute(ph_coeff(:,2:order),[3 2 1]).*time_sample.^(1:order-1);
aux_amp = permute(amp_coeff(:,2:order),[3 2 1]).*time_sample.^(1:order-1);

% Add initial phase using implicit array expansion
ph_model = ph_coeff(:,1)' + squeeze(sum(aux_ph,2));
amp_model = amp_coeff(:,1)' + squeeze(sum(aux_amp,2));

end
