% CONVERT FROM LOGICAL INDEXING TO LINEAR INDEXING

nrow = 2;
ncol = 3;
npage = 4;

% Create matrix
A = reshape(1:nrow*ncol*npage,[nrow ncol npage]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USING LOGICAL INDEXING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Logical one-page array
ipick = true(nrow,ncol);

% Array with logical indices to select first page of A
ibool = cat(3,ipick,false(nrow,ncol,npage-1));

% Initialize B (one page)
P1 = zeros(nrow,ncol);
P2 = zeros(nrow,ncol);

% P1: first page
P1(ipick) = A(ibool);

% P2: second page
P2(ipick) = A(circshift(ibool,1,3));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USING LINEAR INDEXING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Linear first-page array
ilin = reshape(1:nrow*ncol,[nrow ncol]);

% Linear second-page
% sub2ind(size(A),ilin,3) THIS DOES NOT WORK: I GAVE UP HERE

%ilin = reshape(1:numel(A(:,:,1)),size(A(:,:,1)));

