% TEST MULTI-DIMENSIONAL ARRAY

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% nrow rows
nrow = 2;

% ncol columns
ncol = 4;

% npage pages
npage = 3;

% Column vector (npage rows, each row will become a page)
%mat = (1:4)';

mat = repmat((1:2),4,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTIONALITY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Required dimension
req_dim = [nrow ncol npage];

% Initialize MULT
%mult = zeros(req_dim);

% Test where REQ_DIM coincides with SIZE(MAT)
[lia,loc] = ismember(req_dim,size(mat));

% Condition for transposition
if ~isequal(req_dim(lia),size(mat))
    
    %transpose
    mat = mat';
    
end

% Dimension for tiling
tile_dim = {nrow ncol npage};

% Make singleton
tile_dim{~lia} = 1;

% Deal
[auxrow, auxcol, auxpage] = tile_dim{:};

% Assign VEC to TILE_DIM
mult(1:auxrow,1:auxcol,1:auxpage) = mat;

% Only repeat dimensions different from length of VEC
req_dim(lia) = 1;

% Repeat
mult = repmat(mult,req_dim);

% Static COL2PAGE
%isequal(mult,col2page(mat,nrow,ncol))
