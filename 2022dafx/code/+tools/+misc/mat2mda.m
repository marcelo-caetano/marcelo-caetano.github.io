function mda = mat2mda(mat,nrow,ncol,npage)
%MAT2MDA Matrix to multi-dimensional array.
%   Detailed explanation goes here
%
%   See also VEC2MDA

% 2020 MCaetano SMT 0.2.1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(4,4);

% Check number of output arguments
nargoutchk(0,1);

if ~all(ismember(size(mat),[nrow ncol npage]))
    
    error('SMT:MAT2MDA:dimensionMismatch',...
        ['The size of MAT must coincide with'...
        ' two of the dimensions for MDA.\nMAT entered is SIZE %d x %d and'...
        ' the dimensions for MDA entered were NROW %d x NCOL %d x NPAGE %d'],...
        size(mat,1),size(mat,2),nrow,ncol,npage);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Final dimensions of MDA
dim = [nrow ncol npage];

% Index of non-singleton dimensions: TRUE where DIM coincides with SIZE(MAT)
ind = ismember(dim,size(mat));

% Initialize tiling dimensions
tiling = {nrow ncol npage};

% Assign singleton tiling dimensions
tiling{~ind} = 1;

% Deal tiling dimensions to corresponding variables (make one singleton)
% [nrow, ncol, npage] = deal(tiling{:});
[nrow, ncol, npage] = tiling{:};

% Transpose if dimensions of MAT have different ordering than found in DIM
if ~isequal(dim(ind),size(mat))
    
    % Transpose
    mat = mat';
    
end

% Assign MAT to non-singleton dimension in [NROW, NCOL, NPAGE]
mda(1:nrow,1:ncol,1:npage) = mat;

% Make dimensions present in DIM singleton (only remaining dimension is repeated)
dim(ind) = 1;

% Repeat
mda = repmat(mda,dim);

end
