function cdist = cosdist(v1,v2,dim)
%COSDIST Cosine distance.
%   D = COSDIST(V1,V2) returns the cosine distance D between the
%   columns of the multidimensional arrays V1 and V2. The cosine
%   distance is calculated as D = 1 - dot(V1,V2)/(vecnorm(V1)*vecnorm(V2)).
%   V1 and V2 must have the same size NROW x NCOL x NPAGE and D is size
%   1 x NCOL x NPAGE.
%
%   D = COSDIST(V1,V1,DIM) returns the cosine distance D along the
%   dimension DIM as D = D = 1 - dot(V1,V2,DIM)/(vecnorm(V1)*vecnorm(V2)).
%   DIM must be an integer scalar.

% 2021 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,2);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 1
    
    dim = 1;
    
end

validateattributes(v1,{'numeric'},{},mfilename,'V1',1)

validateattributes(v2,{'numeric'},{},mfilename,'V2',2)

validateattributes(dim,{'numeric'},{'scalar','finite','nonnan','integer','positive'},mfilename,'DIM',3)

% Check if sizes are compatible
if ~isequal(size(v1),size(v2))
    
    [nrow1,ncol1,npage1,nd1] = size(v1);
    [nrow2,ncol2,npage2,nd2] = size(v2);
    
    error('SMT:COSDIST:inputSizeMismatch',...
        ['Dimensions of inputs must match.\n'...
        'V1 is %d x %d x %d x %d\nV2 is %d x %d x %d x %d\n'],...
        nrow1,ncol1,npage1,nd1,nrow2,ncol2,npage2,nd2)
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

normflag = true;

cdist = 1 - tools.math.dotprod(v1,v2,dim,normflag);

end
