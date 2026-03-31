function bool_sel_cand = selCandMinDistRef(refArray,candArray,distThresh)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Sizes
[nRowRef,nColRef,nPageRef] = size(refArray);
[nRowCand,nColCand,nPageCand] = size(candArray);

if nColCand ~= nColRef
    error('Number of columns must be the same');
else
    nCol = nColRef;
end

% Convert to cell with one page in each cell
refCell = num2cell(refArray,[1 2]);
candCell = num2cell(candArray,[1 2]);

% Generic anonymous function to calculate the distance matrix
distMat = @(nrowref,nrowcand,ncol) (@(Ref,Cand) abs(reshape(Ref,[nrowref 1 ncol])-reshape(Cand,[1 nrowcand ncol])));

% Instantiate generic distance function to get specific anonymous function
% with input parameters REF,CAND
calcDistMat = distMat(nRowRef,nRowCand,nCol);

% Calculate pairwise distance
D = cellfun(calcDistMat,refCell,candCell,'UniformOutput',false);

% Minimum across columns for distance matrix
mD = cellfun(@(dmat) min(dmat,[],1,'omitnan'),D,'UniformOutput',false);

% Generic anonymous function to reshape array
minVal = @(nrowcand,ncol) (@(m) reshape(m,[nrowcand ncol]));

% Instantiate generic anonymous function to get specific anonymous function
% with input parameters ARRAY
calcMinVal = minVal(nRowCand,nCol);

% Calculate minimum value
minVal = cell2mat(cellfun(calcMinVal,mD,'UniformOutput',false));

% Logical indices of candidates with minimum distance to reference
bool_sel_cand = minVal < distThresh;

end
