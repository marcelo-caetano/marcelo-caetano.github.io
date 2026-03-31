% TEST MAGNITUDE SCALING CONVERSION FUNCTIONS

%TODO: TEST CASES WITH COMPLEX BASE AND COMPLEX POWER
% WARNING! Command to run UnitTest: res = runtests('tools.math.test.magnitude_scaling_conversion_UnitTest')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHARED VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Bases
base = [-20 -3.2391567 -1 -0.002 -1.0e-80 0 realmin 0.000018 1 5.35261067 55]';

% Tolerance for floating point conversions
tol_db = 1e-10;
tol_pow = 1e-3;

base_dbp = 20*log10(base);
base_dbr = 10*log10(base);
base_bel = log10(base);
base_oct = log2(base);
base_nep = log(base);

pow_neg_even = -90;
pow_neg_odd = -99;
pow_neg_float = -2.1827565;
pow_neg_one = -1;
pow_neg_small = -0.0001243;
pow_zero = 0;
pow_pos_small = 0.000008264;
pow_pos_one = 1;
pow_pos_float = 6.8493657;
pow_pos_even = 82;
pow_pos_odd = 81;

base_neg_even = base.^(pow_neg_even);
base_neg_odd = base.^(pow_neg_odd);
base_neg_float = base.^(pow_neg_float);
base_neg_one = base.^(pow_neg_one);
base_neg_small = base.^(pow_neg_small);
base_zero = base.^(pow_zero);
base_pos_small = base.^(pow_pos_small);
base_pos_one = base.^(pow_pos_one);
base_pos_float = base.^(pow_pos_float);
base_pos_even = base.^(pow_pos_even);
base_pos_odd = base.^(pow_pos_odd);

%% Test 1: linear to log

% Decibel (power)
assert(isequal(base_dbp,tools.math.lin2log(base,'dbp')))

% Decibel (root power)
assert(isequal(base_dbr,tools.math.lin2log(base,'dbr')))

% Bel
assert(isequal(base_bel,tools.math.lin2log(base,'bel')))

% Octave
assert(isequal(base_oct,tools.math.lin2log(base,'oct')))

% Neper
assert(isequal(base_nep,tools.math.lin2log(base,'nep')))

%% Test 2: log to linear

% Decibell (power)
aux = abs(base - tools.math.log2lin(base_dbp,'dbp',true)) < tol_db;
assert(all(aux(:)))

% Decibel (root power)
aux = abs(base - tools.math.log2lin(base_dbr,'dbr',true)) < tol_db;
assert(all(aux(:)))

% Bel
aux = abs(base - tools.math.log2lin(base_bel,'bel',true)) < tol_db;
assert(all(aux(:)))

% Octave
aux = abs(base - tools.math.log2lin(base_oct,'oct',true)) < tol_db;
assert(all(aux(:)))

% Neper
aux = abs(base - tools.math.log2lin(base_nep,'nep',true)) < tol_db;
assert(all(aux(:)))

%% Test 3: linear to power

% Negative even power
assert(isequal(base_neg_even,tools.math.lin2pow(base,pow_neg_even)))

% Negative odd power
assert(isequal(base_neg_odd,tools.math.lin2pow(base,pow_neg_odd)))

% Negative real power
assert(isequal(base_neg_float,tools.math.lin2pow(base,pow_neg_float)))

% Negative 1 power
assert(isequal(base_neg_one,tools.math.lin2pow(base,pow_neg_one)))

% Negative power between 0 and 1
assert(isequal(base_neg_small,tools.math.lin2pow(base,pow_neg_small)))

% 0 power
assert(isequal(base_zero,tools.math.lin2pow(base,pow_zero)))

% Positive power small magnitude
assert(isequal(base_pos_small,tools.math.lin2pow(base,pow_pos_small)))

% Positive power 1
assert(isequal(base_pos_one,tools.math.lin2pow(base,pow_pos_one)))

% Positive real power
assert(isequal(base_pos_float,tools.math.lin2pow(base,pow_pos_float)))

% Positive integer power
assert(isequal(base_pos_even,tools.math.lin2pow(base,pow_pos_even)))

%% Test 4: power to linear

% Negative even power: WARNING! abs(base) compensates for conversion error
aux = abs(abs(base) - tools.math.pow2lin(base_neg_even,pow_neg_even)) < tol_pow;
assert(all(aux(:)))

% Negative odd power
aux = abs(base - tools.math.pow2lin(base_neg_odd,pow_neg_odd)) < tol_pow;
assert(all(aux(:)))

% Negative real power
aux = abs(base - tools.math.pow2lin(base_neg_float,pow_neg_float)) < tol_pow;
assert(all(aux(:)))

% Negative 1 power
assert(isequal(base,tools.math.pow2lin(base_neg_one,pow_neg_one)))

% Negative power between 0 and 1
aux = abs(base - tools.math.pow2lin(base_neg_small,pow_neg_small)) < tol_pow;
assert(all(aux(:)))

% 0 power
assert(isequal(ones(size(base)),tools.math.pow2lin(base_zero,pow_zero)))

% Positive power small magnitude
aux = abs(base - tools.math.pow2lin(base_pos_small,pow_pos_small)) < tol_pow;
assert(all(aux(:)))

% Positive power 1
assert(isequal(base,tools.math.pow2lin(base_pos_one,pow_pos_one)))

% Positive real power
aux = abs(base - tools.math.pow2lin(base_pos_float,pow_pos_float)) < tol_pow;
assert(all(aux(:)))

% Positive even power: WARNING! abs(base) compensates for conversion error
aux = abs(abs(base) - tools.math.pow2lin(base_pos_even,pow_pos_even)) < tol_pow;
assert(all(aux(:)))

% Positive odd power
aux = abs(base - tools.math.pow2lin(base_pos_odd,pow_pos_odd)) < tol_pow;
assert(all(aux(:)))
