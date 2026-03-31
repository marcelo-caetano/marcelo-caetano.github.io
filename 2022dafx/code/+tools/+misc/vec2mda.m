function mda = vec2mda(vec,nrow,ncol,npage)
%VEC2MDA Vector to multi-dimensional array.
%   Detailed explanation goes here
%
%   See also MAT2MDA

% 2020 MCaetano SMT 0.2.1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(4,4);

% Check number of output arguments
nargoutchk(0,1);

if ~ismember(length(vec),[nrow ncol npage])
    
    error('SMT:VEC2MDA:dimensionMismatch',...
        ['The length of VEC must coincide with'...
        ' one of the dimensions for MDA.\nVEC entered is length %d and the'...
        ' dimensions for MDA entered were NROW %d x NCOL %d x NPAGE %d'],...
        length(vec),nrow,ncol,npage);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make sure VEC is column vector
vec = vec(:);

% Final dimensions of MDA
dim = [nrow ncol npage];

% Index of non-singleton dimension: TRUE where DIM coincides with LENGTH(VEC)
ind = ismember(dim,length(vec));

% Initialize tiling dimensions
tiling = {1 1 1};

% Assign non-singleton tiling dimensions
tiling{ind} = dim(ind);

% Deal tiling dimensions to corresponding variables (make one singleton)
% [nrow, ncol, npage] = deal(tiling{:});
[nrow, ncol, npage] = tiling{:};

% Assign VEC to non-singleton dimension in [NROW, NCOL, NPAGE]
mda(1:nrow,1:ncol,1:npage) = vec;

% Only repeat dimensions different from length of VEC
dim(ind) = 1;

% Repeat
mda = repmat(mda,dim);

end
