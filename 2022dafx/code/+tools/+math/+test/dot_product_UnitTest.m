% TEST DOT PRODUCT OF TWO MULTInrowENSIONAL ARRAYS

%TODO: TEST CASES WITH COMPLEX BASE AND COMPLEX POWER
% WARNING! Command to run UnitTest: res = runtests('tools.math.test.dot_product_UnitTest')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHARED VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Dimensions
nrow = 4;
ncol = 3;
npage = 2;

% Initialize data
m1 = magic(nrow);
m2 = pascal(nrow);
m3 = hankel(1:nrow,nrow:-1:1);
m4 = gallery('binomial',nrow);
m5 = gallery('chebspec',nrow,1);
m6 = gallery('circul',nrow);

% Select and concatenate into vectors
v1 = cat(3,m1(:,1:ncol),m4(:,1:ncol),m6(:,1:ncol));
v2 = cat(3,m2(:,1:ncol),m3(:,1:ncol),m5(:,1:ncol));

% Tolerance for floating point conversions
tol_db = 1e-10;
tol_pow = 1e-3;

%% Test 1: dot product

% Dot product
assert(isequal(dot(v1,v2),tools.math.dotprod(v1,v2)))

%% Test 2: dot product forcing no normalization

% Do not normalize the result
normflag = false;

% Dot product with NORMFLAG = FALSE
assert(isequal(dot(v1,v2),tools.math.dotprod(v1,v2,normflag)))

%% Test 3: dot product with normalization

% Normalize the result
normflag = true;

% Magnitude
mag1 = sqrt(dot(v1,v1));
mag2 = sqrt(dot(v2,v2));

% Dot product with NORMFLAG = TRUE (cosine of the angle)
assert(isequal(dot(v1,v2)./(mag1.*mag2),tools.math.dotprod(v1,v2,normflag)))
