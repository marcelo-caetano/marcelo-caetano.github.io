function eudist = euclidist(v1,v2,dim,normflag)
%EUCLIDIST Euclidean distance.
%   D = EUCLIDIST(V1,V2) returns the Euclidean distance D between the
%   columns of the multidimensional arrays V1 and V2. The Euclidean
%   distance is calculated as D = sqrt(sum((V1 - V2).^2)). V1 and V2 must
%   have the same size NROW x NCOL x NPAGE and D is size 1 x NCOL x NPAGE.
%
%   D = EUCLIDIST(V1,V1,DIM) returns the Euclidean distance D along the
%   dimension DIM as D = sqrt(sum((V1 - V2).^2,DIM)). DIM must be an
%   integer scalar.
%
%   D = EUCLIDIST(V1,V2,DIM,NORMFLAG) uses the logical flag NORMFLAG to
%   normalize D by the magnitudes of V1 and V2. The magnitude is calculated
%   with VECNORM.
%
%   See also DOT, VECNORM, COSDIST

% 2021 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,4);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 2
    
    dim = 1;
    
    normflag = false;
    
elseif nargin == 3
    
    normflag = false;
    
end

validateattributes(v1,{'numeric'},{},mfilename,'V1',1)

validateattributes(v2,{'numeric'},{},mfilename,'V2',2)

validateattributes(dim,{'numeric'},{'scalar','finite','nonnan','integer','positive'},mfilename,'DIM',3)

validateattributes(normflag,{'numeric','logical'},{'scalar','finite','nonnan','binary'},mfilename,'NORMFLAG',4)

% Check if sizes are compatible
if ~isequal(size(v1),size(v2))
    
    [nrow1,ncol1,npage1,nd1] = size(v1);
    [nrow2,ncol2,npage2,nd2] = size(v2);
    
    error('SMT:EUCLIDIST:inputSizeMismatch',...
        ['Dimensions of inputs must match.\n'...
        'V1 is %d x %d x %d x %d\nV2 is %d x %d x %d x %d\n'],...
        nrow1,ncol1,npage1,nd1,nrow2,ncol2,npage2,nd2)
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if normflag
    
    % Magnitude of V1
    %     mag_v1 = sqrt(sum(v1.^2,dim));
    mag_v1 = tools.math.vecnorm(v1,dim);
    
    % Normalize V1
    v1 = v1./mag_v1;
    
    % Magnitude of V2
    %     mag_v2 = sqrt(sum(v2.^2,dim));
    mag_v2 = tools.math.vecnorm(v2,dim);
    
    % Normalize V2
    v2 = v2./mag_v2;
    
end

% Euclidean distance of V1 and V2
eudist = sqrt(sum((v1 - v2).^2,dim));

end
