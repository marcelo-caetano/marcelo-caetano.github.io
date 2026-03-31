function [mult] = col2page(col,nrow,ncol)
%COL2PAGE Column vector to pages of 3D array.
%   M = COL2PAGE(C,NROW,NCOL) tiles each row element of the column vector
%   C NROW x NCOL times per page of the 3D array M. The final dimension of 
%   M is NROW x NCOL x NPAGE.
%
%   Example: m = col2page((1:2)',3,4) returns
%
%   m(:,:,1) =
% 
%      1     1     1     1
%      1     1     1     1
%      1     1     1     1
% 
% 
%   m(:,:,2) =
% 
%      2     2     2     2
%      2     2     2     2
%      2     2     2     2
%
%   See also MAT2PAGE

% 2020 MCaetano SMT 0.2.1

% Force COL to be a column vector
col = col(:);

% Assign COL to pages (3rd dimension) of MULT
mult(1,1,:) = col;

% Tile MULT array NROW x NCOL (nrow x ncol x npage)
mult = repmat(mult,nrow,ncol,1);

% % Alternative solution using built-in functions (takes longer)
% % Number of pages of mult
% npage = length(col);
% % Each row element of COL becomes a NROW x NCOL page
% mult = reshape(repmat(col,1,nrow*ncol)',nrow,ncol,npage);

end
