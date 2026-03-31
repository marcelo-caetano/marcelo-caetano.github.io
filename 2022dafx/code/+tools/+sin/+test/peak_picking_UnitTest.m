% UNIT TEST FOR PEAK PICKING

% Command to run UnitTest: res = runtests('tools.sin.test.peak_picking_UnitTest')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHARED VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nbin = 8;
nframe = 5;
nchannel = 2;

oneframe = 1;
onechannel = 1;

peak_simple = [0 0 1 0 0 0 1 0]';
bool_spec_simple = logical([0 0 1 0 0 0 1 0]');
bool_symm_simple = logical([0 0 0 0 0 0 0 0]');
bool_simple = bool_spec_simple | bool_symm_simple;
bin_simple = nan(nbin,oneframe,onechannel);
bin_simple(bool_simple) = [2 6]';

peak_border = [1 0 1 1 0 1 0 1]';
bool_spec_border = logical([0 0 0 0 0 1 0 0]');
bool_symm_border = logical([0 0 0 1 0 0 0 0]');
bool_border = bool_spec_border | bool_symm_border;
bin_border = nan(nbin,oneframe,onechannel);
bin_border(bool_border) = [3 5]';

peak_nan = [0 1 0 nan(1) 1 1 nan(1) 0]';
bool_spec_nan = logical([0 1 0 0 0 0 0 0]');
bool_symm_nan = logical([0 0 0 0 0 0 0 0]');
bool_nan = bool_spec_nan | bool_symm_nan;
bin_nan = nan(nbin,oneframe,onechannel);
bin_nan(bool_nan) = [1]';

peak_inf = [0 1 0 inf(1) 0 1 -inf(1) 0]';
bool_spec_inf = logical([0 1 0 1 0 1 0 0]');
bool_symm_inf = logical([0 0 0 0 0 0 0 0]');
bool_inf = bool_spec_inf | bool_symm_inf;
bin_inf = nan(nbin,oneframe,onechannel);
bin_inf(bool_inf) = [1 3 5]';

peak_inf2 = [1 1 inf(1) inf(1) 1 1 -inf(1) 0]';
bool_spec_inf2 = logical([0 0 0 0 0 0 0 0]');
bool_symm_inf2 = logical([0 0 0 1 0 1 0 0]');
bool_inf2 = bool_spec_inf2 | bool_symm_inf2;
bin_inf2 = nan(nbin,oneframe,onechannel);
bin_inf2(bool_inf2) = [3 5]';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST CASES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

peak = repmat([peak_simple peak_border peak_nan peak_inf peak_inf2],1,1,nchannel);

bool_spec = repmat([bool_spec_simple bool_spec_border bool_spec_nan bool_spec_inf bool_spec_inf2],1,1,nchannel);

bool_symm = repmat([bool_symm_simple bool_symm_border bool_symm_nan bool_symm_inf bool_symm_inf2],1,1,nchannel);

bool = repmat([bool_simple bool_border bool_nan bool_inf bool_inf2],1,1,nchannel);

bin = repmat([bin_simple bin_border bin_nan bin_inf bin_inf2],1,1,nchannel);


%% Test 1: is3ptpeak

assert(isequal(bool_spec,tools.sin.is3ptpeak(peak)))

%% Test 2: is2ptpeak

assert(isequal(bool_symm,tools.sin.is2ptpeak(peak)))

%% Test 3: ispeak

assert(isequal(bool,tools.sin.ispeak(peak)))

%% Test 4: numerical indices

nfft = 8;
fs = 16000;
[pa,pf,pp] = peak_picking(peak,peak,nfft,fs,nframe,'full',false);

assert(isequaln(bin,pf.peak))
