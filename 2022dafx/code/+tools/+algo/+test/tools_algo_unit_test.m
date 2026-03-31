% UNIT TEST FOR FOLDER +TOOLS/+ALGO

% WARNING! Command to run UnitTest: res = runtests('tools.algo.test.tools_algo_unit_test')

% TODO: ADD TESTS FOR ERRORS
% TODO: ADD TEST2 FOR TOOLS.ALGO.SELCANDMINDISTREF

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHARED VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Test 1: tools.algo.findIndFirstLastTrueVal

nbin = 8;
nframe = 3;
nchannel = 2;

bool_channel = [1 0 0 1 0 0 1 0;0 1 0 0 1 0 1 0;0 0 1 0 1 0 0 1]';

res_first = [1 10 19 25 34 43]';
res_last = [7 15 24 31 39 48]';

% Logical indices of troughs
bool_trough = logical(repmat(bool_channel,1,1,nchannel));

[ind_first_trough,ind_last_trough] = tools.algo.findIndFirstLastTrueVal(bool_trough,nbin,nframe,nchannel);

assert(isequal(ind_first_trough,res_first))

assert(isequal(ind_last_trough,res_last))
