function phase = mkpolyph(ph_param,fs,nsample)
%MKPOLYPH Make polynomial phase.
%   P = MKPOLYPH(PARAM,Fs,NSAMPLE) returns the polynomial phase P
%   corresponding to the phase parameters PARAM. PARAM is size NPART x ORDER
%   where NPART is the number of partials and ORDER is the order of the
%   polynomial phase. For example, ORDER == 4 determines cubic phase as:
%
%   P = P0 + 2*pi*P1*TIME + (2*pi*P2*TIME)^2 + (2*pi*P3*TIME)^3 + ...
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
narginchk(3,3);

% Check the number of output arguments
nargoutchk(0,1);

validateattributes(ph_param,{'numeric'},{'finite'},mfilename,'PARAM',1)

validateattributes(fs,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'Fs',2)

validateattributes(nsample,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NSAMPLE',3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[npart,order] = size(ph_param);

if order < 2
    
    error('SMT:MKPOLYPH:InvalidInputArgument',...
        ['Invalid input argument.\n'...
        'ORDER must be >= 2.\n'...
        'ORDER entered was %d.\n'],order)
    
end

time = tools.plot.mktime(nsample,fs);

interm_ph = zeros(nsample,npart,order-1);

for iord = 2:order
    
    ang_freq = 2*pi*ph_param(:,iord);
    
    % Uses implicit array expansion (all inputs must be column vectors)
    interm_ph(:,:,iord-1) = (time.*ang_freq').^(iord-1);
    
end

% Add initial phase using implicit array expansion
phase = ph_param(:,1)' + sum(interm_ph,3);

end
