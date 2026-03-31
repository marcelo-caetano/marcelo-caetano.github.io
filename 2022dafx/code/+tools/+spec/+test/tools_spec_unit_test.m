% UNIT TEST FOR FOLDER +TOOLS/+SPEC/

% WARNING! Command to run UnitTest: res = runtests('tools.spec.test.tools_spec_unit_test')

% TODO: ADD TESTS FOR ERRORS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHARED VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fractional part
frac_part = 1e-2;

% Tolerance for maximum difference
tol = 1e-20;

% Sampling frequency
fs = 16000;

% Size of the FFT
odd_nfft = 7;
even_nfft = 8;

% Number of frames
nframe = 5;

% Number of channels
nchannel = 2;

% Nyquist bin
odd_knyq = odd_nfft/2;
even_knyq = even_nfft/2;

% Index of Nyquist frequency
odd_inyq = floor(odd_knyq)+1;
even_inyq = even_knyq + 1;

% Positive frequency band
odd_pos_freq_band = ceil(odd_nfft/2);
even_pos_freq_band = even_nfft/2+1;

% Negative frequency band
odd_neg_freq_band = odd_pos_freq_band-1;
even_neg_freq_band = even_pos_freq_band-2;

% FFT vectors FULL
odd_spec_full_vec = [odd_nfft,fliplr(1:odd_knyq),1:odd_knyq]';
even_spec_full_vec = [even_nfft,fliplr(1:even_knyq-1),even_nfft/2,1:even_knyq-1]';

% FFT vectors NEGPOS
odd_spec_negpos_vec = [1:odd_knyq,odd_nfft,fliplr(1:odd_knyq)]';
even_spec_negpos_vec = [1:even_knyq-1,even_nfft,fliplr(1:even_knyq-1),even_nfft/2]';

% FFT spectrum FULL
odd_spec_full = repmat(odd_spec_full_vec,1,nframe,nchannel);
even_spec_full = repmat(even_spec_full_vec,1,nframe,nchannel);

% FFT spectrum NEGPOS
odd_spec_negpos = repmat(odd_spec_negpos_vec,1,nframe,nchannel);
even_spec_negpos = repmat(even_spec_negpos_vec,1,nframe,nchannel);

% Column vector of FULL bins
odd_bin_full_vec = (0:odd_nfft-1)';
even_bin_full_vec = (0:even_nfft-1)';

% Matrix of integer FULL bins
odd_bin_full = repmat(odd_bin_full_vec,1,nframe,nchannel);
even_bin_full = repmat(even_bin_full_vec,1,nframe,nchannel);

% Column vector of FULL indices
odd_ind_full_vec = (1:odd_nfft)';
even_ind_full_vec = (1:even_nfft)';

% Make matrix of FULL indices
odd_ind_full = repmat(odd_ind_full_vec,1,nframe,nchannel);
even_ind_full = repmat(even_ind_full_vec,1,nframe,nchannel);

% Matrix of fractional FULL bins
odd_frac_bin_full = odd_bin_full;
odd_frac_bin_full(odd_bin_full~=0) = odd_bin_full(odd_bin_full~=0) - frac_part;
odd_frac_bin_full(odd_bin_full==0) = odd_bin_full(odd_bin_full==0) + frac_part;
even_frac_bin_full = even_bin_full;
even_frac_bin_full(even_bin_full~=0) = even_bin_full(even_bin_full~=0) - frac_part;
even_frac_bin_full(even_bin_full==0) = even_bin_full(even_bin_full==0) + frac_part;

% Column vector of POS bins
odd_bin_pos_vec = (0:odd_knyq)';
even_bin_pos_vec = (0:even_knyq)';

% Matrix of integer POS bins
odd_bin_pos = repmat(odd_bin_pos_vec,1,nframe,nchannel);
even_bin_pos = repmat(even_bin_pos_vec,1,nframe,nchannel);

% Make lower bound of NEGPOS bins
odd_low_bnd = -floor(odd_nfft/2);
even_low_bnd = -even_nfft/2+1;

% Make upper bound of NEGPOS bins
odd_up_bnd = floor(odd_nfft/2);
even_up_bnd = even_nfft/2;

% Column vector of NEGPOS bins
odd_bin_negpos_vec = (odd_low_bnd:odd_up_bnd)';
even_bin_negpos_vec = (even_low_bnd:even_up_bnd)';

% Make matrix of NEGPOS bins
odd_bin_negpos = repmat(odd_bin_negpos_vec,1,nframe,nchannel);
even_bin_negpos = repmat(even_bin_negpos_vec,1,nframe,nchannel);

% Matrix of fractional NEGPOS bins
odd_frac_bin_negpos = odd_bin_negpos;
odd_frac_bin_negpos(1,:,:) = odd_bin_negpos(1,:,:) + frac_part;
odd_frac_bin_negpos(2:end,:,:) = odd_bin_negpos(2:end,:,:) - frac_part;
even_frac_bin_negpos = even_bin_negpos;
even_frac_bin_negpos(1,:,:) = even_bin_negpos(1,:,:) + frac_part;
even_frac_bin_negpos(2:end,:,:) = even_bin_negpos(2:end,:,:) - frac_part;

% Integer FULL frequencies
odd_freq_full = fs*odd_bin_full/odd_nfft;
even_freq_full = fs*even_bin_full/even_nfft;

% Fractional FULL frequencies
odd_frac_freq_full = fs*odd_frac_bin_full/odd_nfft;
even_frac_freq_full = fs*even_frac_bin_full/even_nfft;

% Integer POS frequencies
odd_freq_pos = fs*odd_bin_pos/odd_nfft;
even_freq_pos = fs*even_bin_pos/even_nfft;

% Integer NEGPOS frequencies
odd_freq_negpos = fs*odd_bin_negpos/odd_nfft;
even_freq_negpos = fs*even_bin_negpos/even_nfft;

% Fractional NEGPOS frequencies
odd_frac_freq_negpos = fs*odd_frac_bin_negpos/odd_nfft;
even_frac_freq_negpos = fs*even_frac_bin_negpos/even_nfft;

%% Test 1: tools.plot.mkbin.m

% Bin FULL ODD (DEFAULT)
assert(isequal(odd_bin_full,tools.spec.mkbin(odd_nfft,nframe,nchannel)))

% Bin FULL EVEN (DEFAULT)
assert(isequal(even_bin_full,tools.spec.mkbin(even_nfft,nframe,nchannel)))

% Bin FULL ODD
assert(isequal(odd_bin_full,tools.spec.mkbin(odd_nfft,nframe,nchannel,'full')))

% Bin FULL EVEN
assert(isequal(even_bin_full,tools.spec.mkbin(even_nfft,nframe,nchannel,'full')))

% Bin NEGPOS ODD
assert(isequal(odd_bin_negpos,tools.spec.mkbin(odd_nfft,nframe,nchannel,'negpos')))

% Bin NEGPOS ODD
assert(isequal(even_bin_negpos,tools.spec.mkbin(even_nfft,nframe,nchannel,'negpos')))

% Bin POS ODD
assert(isequal(odd_bin_pos,tools.spec.mkbin(odd_nfft,nframe,nchannel,'pos')))

% Bin POS EVEN
assert(isequal(even_bin_pos,tools.spec.mkbin(even_nfft,nframe,nchannel,'pos')))

%% Test 2: tools.spec.mkfreq.m

% Frequency FULL ODD
assert(isequal(odd_freq_full,tools.spec.mkfreq(odd_nfft,fs,nframe,nchannel,'full')))

% Frequency FULL EVEN
assert(isequal(even_freq_full,tools.spec.mkfreq(even_nfft,fs,nframe,nchannel,'full')))

% Frequency NEGPOS ODD
assert(isequal(odd_freq_negpos,tools.spec.mkfreq(odd_nfft,fs,nframe,nchannel,'negpos')))

% Frequency NEGPOS ODD
assert(isequal(even_freq_negpos,tools.spec.mkfreq(even_nfft,fs,nframe,nchannel,'negpos')))

% Frequency POS ODD
assert(isequal(odd_freq_pos,tools.spec.mkfreq(odd_nfft,fs,nframe,nchannel,'pos')))

% Frequency POS EVEN
assert(isequal(even_freq_pos,tools.spec.mkfreq(even_nfft,fs,nframe,nchannel,'pos')))

%% Test 3: tools.spec.nyq_bin.m

% NYQ BIN ODD
assert(isequal(odd_knyq,tools.spec.nyq_bin(odd_nfft)))

% NYQ BIN EVEN
assert(isequal(even_knyq,tools.spec.nyq_bin(even_nfft)))

%% Test 4: tools.spec.nyq_ind.m

% NYQ IND ODD
assert(isequal(odd_inyq,tools.spec.nyq_ind(odd_nfft)))

% NYQ IND EVEN
assert(isequal(even_inyq,tools.spec.nyq_ind(even_nfft)))

%% Test 5: tools.spec.nyq_freq.m

% NYQ IND ODD
assert(isequal(fs/2,tools.spec.nyq_freq(odd_nfft,fs)))

% NYQ IND EVEN
assert(isequal(fs/2,tools.spec.nyq_freq(even_nfft,fs)))

%% Test 6: tools.spec.pos_freq_band.m

% POS FREQ BAND ODD
assert(isequal(odd_pos_freq_band,tools.spec.pos_freq_band(odd_nfft)))

% POS FREQ BAND EVEN
assert(isequal(even_pos_freq_band,tools.spec.pos_freq_band(even_nfft)))

%% Test 7: tools.spec.neg_freq_band.m

% NEG FREQ BAND ODD
assert(isequal(odd_neg_freq_band,tools.spec.neg_freq_band(odd_nfft)))

% NEG FREQ BAND EVEN
assert(isequal(even_neg_freq_band,tools.spec.neg_freq_band(even_nfft)))

%% Test 8: tools.spec.binshift.m

% FULL TO NEGPOS ODD
assert(isequal(odd_bin_negpos,tools.spec.binshift(odd_bin_full,odd_nfft)))

% FULL TO NEGPOS EVEN
assert(isequal(even_bin_negpos,tools.spec.binshift(even_bin_full,even_nfft)))

%% Test 9: tools.spec.ibinshift.m

% NEGPOS TO FULL ODD
assert(isequal(odd_bin_full,tools.spec.ibinshift(odd_bin_negpos,odd_nfft)))

% NEGPOS TO FULL EVEN
assert(isequal(even_bin_full,tools.spec.ibinshift(even_bin_negpos,even_nfft)))

%% Test 10: tools.spec.fftflip.m

% FLIP SPEC ODD
assert(isequal(odd_spec_negpos,tools.spec.fftflip(odd_spec_full,odd_nfft)))

% FLIP SPEC EVEN
assert(isequal(even_spec_negpos,tools.spec.fftflip(even_spec_full,even_nfft)))

%% Test 11: tools.spec.ifftflip.m

% IFLIP SPEC_FLIP ODD
assert(isequal(odd_spec_full,tools.spec.ifftflip(odd_spec_negpos,odd_nfft)))

% IFLIP SPEC_FLIP EVEN
assert(isequal(even_spec_full,tools.spec.ifftflip(even_spec_negpos,even_nfft)))

%% Test 12: tools.spec.binshift.m & tools.spec.ibinshift.m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BACK AND FORTH: BINSHIFT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% FULL TO NEGPOS TO FULL ODD
assert(isequal(odd_bin_full,tools.spec.ibinshift(tools.spec.binshift(odd_bin_full,odd_nfft),odd_nfft)))

% FULL TO NEGPOS TO FULL EVEN
assert(isequal(even_bin_full,tools.spec.ibinshift(tools.spec.binshift(even_bin_full,even_nfft),even_nfft)))

% NEGPOS TO FULL TO NEGPOS ODD
assert(isequal(odd_bin_negpos,tools.spec.binshift(tools.spec.ibinshift(odd_bin_negpos,odd_nfft),odd_nfft)))

% NEGPOS TO FULL TO NEGPOS ODD
assert(isequal(even_bin_negpos,tools.spec.binshift(tools.spec.ibinshift(even_bin_negpos,even_nfft),even_nfft)))

%% Test 13: tools.spec.fftflip.m & tools.spec.ifftflip.m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BACK AND FORTH: FFTFLIP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SPEC TO FLIP TO SPEC ODD
assert(isequal(odd_spec_full,tools.spec.ifftflip(tools.spec.fftflip(odd_spec_full,odd_nfft),odd_nfft)))

% SPEC TO FLIP TO SPEC EVEN
assert(isequal(even_spec_full,tools.spec.ifftflip(tools.spec.fftflip(even_spec_full,even_nfft),even_nfft)))

% FLIP TO SPEC TO FLIP ODD
assert(isequal(odd_spec_negpos,tools.spec.fftflip(tools.spec.ifftflip(odd_spec_negpos,odd_nfft),odd_nfft)))

% FLIP TO SPEC TO FLIP EVEN
assert(isequal(even_spec_negpos,tools.spec.fftflip(tools.spec.ifftflip(even_spec_negpos,even_nfft),even_nfft)))

%% Test 14: tools.spec.ind2bin.m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST CONVERSIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% INDEX TO BIN (FULL)
assert(max((odd_bin_full - tools.spec.ind2bin(odd_ind_full)).^2,[],'all') < tol)
assert(max((even_bin_full - tools.spec.ind2bin(even_ind_full)).^2,[],'all') < tol)

% INDEX TO BIN (NEGPOS)
assert(max((odd_bin_negpos - tools.spec.ind2bin(odd_ind_full,odd_nfft)).^2,[],'all') < tol)
assert(max((even_bin_negpos - tools.spec.ind2bin(even_ind_full,even_nfft)).^2,[],'all') < tol)

% VERIFY ERROR
% % INDEX OUT OF RANGE
% % verifyError(testCase,@() tools.spec.ind2bin(ind_full-1),'MATLAB:ind2bin:expectedPositive')
% verifiable.verifyThat(@() tools.spec.ind2bin(ind_full-1),Throws('MATLAB:ind2bin:expectedPositive'));
%
% % FRACTIONAL INDEX
% % verifyError(testCase,@() tools.spec.ind2bin(ind_full+0.1),'MATLAB:ind2bin:expectedInteger')
% verifiable.verifyThat(@() tools.spec.ind2bin(ind_full+0.1),Throws('MATLAB:ind2bin:expectedInteger'));
%
% % NFFT IS ARRAY
% % verifyError(testCase,@() tools.spec.ind2bin(ind_full,[nfft nfft]),'MATLAB:ind2bin:expectedScalar')
% verifiable.verifyThat(@() tools.spec.ind2bin(ind_full,[nfft nfft]),Throws('MATLAB:ind2bin:expectedScalar'));
%
% % NFFT NOT NUMERIC
% % verifyError(testCase,@() tools.spec.ind2bin(ind_full,'nfft'),'MATLAB:ind2bin:invalidType')
% verifiable.verifyThat(@() tools.spec.ind2bin(ind_full,'nfft'),Throws('MATLAB:ind2bin:invalidType'));
%
% % NFFT NOT FINITE
% % verifyError(testCase,@() tools.spec.ind2bin(ind_full,nan(1)),'MATLAB:ind2bin:expectedFinite')
% verifiable.verifyThat(@() tools.spec.ind2bin(ind_full,nan(1)),Throws('MATLAB:ind2bin:expectedFinite'));
%
% % NFFT FRACTIONAL
% % verifyError(testCase,@() tools.spec.ind2bin(ind_full,nfft+frac_part),'MATLAB:ind2bin:expectedInteger')
% verifiable.verifyThat(@() tools.spec.ind2bin(ind_full,nfft+frac_part),Throws('MATLAB:ind2bin:expectedInteger'));
%
% % NFFT ODD
% % verifyError(testCase,@() tools.spec.ind2bin(ind_full,nfft-1),'MATLAB:ind2bin:incorrectNumrows')
% verifiable.verifyThat(@() tools.spec.ind2bin(ind_full,nfft-1),Throws('MATLAB:ind2bin:incorrectNumrows'));
%
% % NFFT ~= LENGTH(IND)
% % verifyError(testCase,@() tools.spec.ind2bin(ind_full,nfft/2),'MATLAB:ind2bin:incorrectNumrows')
% verifiable.verifyThat(@() tools.spec.ind2bin(ind_full,nfft/2),Throws('MATLAB:ind2bin:incorrectNumrows'));


%% Test 15: tools.spec.bin2ind.m

% BIN TO INDEX (FULL)
assert(max((odd_ind_full - tools.spec.bin2ind(odd_bin_full)).^2,[],'all') < tol)
assert(max((even_ind_full - tools.spec.bin2ind(even_bin_full)).^2,[],'all') < tol)

% FRACTIONAL BIN TO INDEX (FULL)
assert(max((odd_ind_full - tools.spec.bin2ind(odd_frac_bin_full)).^2,[],'all') < tol)
assert(max((even_ind_full - tools.spec.bin2ind(even_frac_bin_full)).^2,[],'all') < tol)

% BIN TO INDEX (NEGPOS)
assert(max((odd_ind_full - tools.spec.bin2ind(odd_bin_negpos,odd_nfft)).^2,[],'all') < tol)
assert(max((even_ind_full - tools.spec.bin2ind(even_bin_negpos,even_nfft)).^2,[],'all') < tol)

% FRACTIONAL BIN TO INDEX (NEGPOS)
assert(max((odd_ind_full - tools.spec.bin2ind(odd_frac_bin_negpos,odd_nfft)).^2,[],'all') < tol)
assert(max((even_ind_full - tools.spec.bin2ind(even_frac_bin_negpos,even_nfft)).^2,[],'all') < tol)

% VERIFY ERROR
% % FLAG NEGPOS
% verifyError(testCase,@() tools.spec.bin2ind(bin_negpos),'MATLAB:bin2ind:expectedNonnegative')
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 2 INPUT ARGUMENTS
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% % FLAG FULL & BIN > NFFT-1
% verifyError(testCase,@() tools.spec.bin2ind(bin_full+1,nfft),'MATLAB:bin2ind:notLessEqual')
%
% % FLAG NEGPOS & BIN < -NFFT/2+1
% verifyError(testCase,@() tools.spec.bin2ind(bin_negpos-1,nfft),'MATLAB:bin2ind:notGreaterEqual')

%% Test 16: tools.spec.ind2freq.m

% INDEX TO FREQUENCY (FULL)
assert(max((odd_freq_full - tools.spec.ind2freq(odd_ind_full,fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_freq_full - tools.spec.ind2freq(even_ind_full,fs,even_nfft)).^2,[],'all') < tol)

% INDEX TO FREQUENCY (NEGPOS)
assert(max((odd_freq_negpos - tools.spec.ind2freq(odd_ind_full,fs,odd_nfft,true)).^2,[],'all') < tol)
assert(max((even_freq_negpos - tools.spec.ind2freq(even_ind_full,fs,even_nfft,true)).^2,[],'all') < tol)

%% Test 17: tools.spec.freq2ind.m

% FULL FREQUENCY TO INDEX
assert(max((odd_ind_full - tools.spec.freq2ind(odd_freq_full,fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_ind_full - tools.spec.freq2ind(even_freq_full,fs,even_nfft)).^2,[],'all') < tol)

% FRACTIONAL FULL FREQUENCY TO INDEX
assert(max((odd_ind_full - tools.spec.freq2ind(odd_frac_freq_full,fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_ind_full - tools.spec.freq2ind(even_frac_freq_full,fs,even_nfft)).^2,[],'all') < tol)

% NEGPOS FREQUENCY TO INDEX
assert(max((odd_ind_full - tools.spec.freq2ind(odd_freq_negpos,fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_ind_full - tools.spec.freq2ind(even_freq_negpos,fs,even_nfft)).^2,[],'all') < tol)

% FRACTIONAL NEGPOS FREQUENCY TO INDEX
assert(max((odd_ind_full - tools.spec.freq2ind(odd_frac_freq_negpos,fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_ind_full - tools.spec.freq2ind(even_frac_freq_negpos,fs,even_nfft)).^2,[],'all') < tol)

%% Test 18: tools.spec.bin2freq.m

% BIN TO FREQUENCY (FULL)
assert(max((odd_freq_full - tools.spec.bin2freq(odd_bin_full,fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_freq_full - tools.spec.bin2freq(even_bin_full,fs,even_nfft)).^2,[],'all') < tol)

% FRACTIONAL BIN TO FREQUENCY (FULL)
assert(max((odd_frac_freq_full - tools.spec.bin2freq(odd_frac_bin_full,fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_frac_freq_full - tools.spec.bin2freq(even_frac_bin_full,fs,even_nfft)).^2,[],'all') < tol)

% FRACTIONAL BIN TO FREQUENCY (FULL)
assert(max((odd_freq_full - tools.spec.bin2freq(odd_frac_bin_full,fs,odd_nfft,true)).^2,[],'all') < tol)
assert(max((even_freq_full - tools.spec.bin2freq(even_frac_bin_full,fs,even_nfft,true)).^2,[],'all') < tol)

% BIN TO FREQUENCY (NEGPOS)
assert(max((odd_freq_negpos - tools.spec.bin2freq(odd_bin_negpos,fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_freq_negpos - tools.spec.bin2freq(even_bin_negpos,fs,even_nfft)).^2,[],'all') < tol)

% FRACTIONAL BIN TO FREQUENCY (NEGPOS)
assert(max((odd_frac_freq_negpos - tools.spec.bin2freq(odd_frac_bin_negpos,fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_frac_freq_negpos - tools.spec.bin2freq(even_frac_bin_negpos,fs,even_nfft)).^2,[],'all') < tol)

% FRACTIONAL BIN TO FREQUENCY (NEGPOS)
assert(max((odd_freq_negpos - tools.spec.bin2freq(odd_frac_bin_negpos,fs,odd_nfft,true)).^2,[],'all') < tol)
assert(max((even_freq_negpos - tools.spec.bin2freq(even_frac_bin_negpos,fs,even_nfft,true)).^2,[],'all') < tol)

% % FULL FREQ > Fs*(NFFT-1)/NFFT
% verifyError(testCase,@() tools.spec.bin2freq(freq_full+1,fs,nfft),'MATLAB:bin2freq:notLessEqual')
%
% % NEGPOS FREQ < Fs*(-NFFT/2+1)/NFFT
% verifyError(testCase,@() tools.spec.bin2freq(freq_negpos-1,fs,nfft),'MATLAB:bin2freq:notGreaterEqual')

%% Test 19: tools.spec.freq2bin.m

% FREQUENCY TO BIN (FULL)
assert(max((odd_bin_full - tools.spec.freq2bin(odd_freq_full,fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_bin_full - tools.spec.freq2bin(even_freq_full,fs,even_nfft)).^2,[],'all') < tol)

% FRACTIONAL FREQUENCY TO FRACTIONAL BIN (FULL)
assert(max((odd_frac_bin_full - tools.spec.freq2bin(odd_frac_freq_full,fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_frac_bin_full - tools.spec.freq2bin(even_frac_freq_full,fs,even_nfft)).^2,[],'all') < tol)

% FRACTIONAL FREQUENCY TO BIN (FULL)
assert(max((odd_bin_full - tools.spec.freq2bin(odd_frac_freq_full,fs,odd_nfft,true)).^2,[],'all') < tol)
assert(max((even_bin_full - tools.spec.freq2bin(even_frac_freq_full,fs,even_nfft,true)).^2,[],'all') < tol)

% FREQUENCY TO BIN (NEGPOS)
assert(max((odd_bin_negpos - tools.spec.freq2bin(odd_freq_negpos,fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_bin_negpos - tools.spec.freq2bin(even_freq_negpos,fs,even_nfft)).^2,[],'all') < tol)

% FRACTIONAL FREQUENCY TO FRACTIONAL BIN (NEGPOS)
assert(max((odd_frac_bin_negpos - tools.spec.freq2bin(odd_frac_freq_negpos,fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_frac_bin_negpos - tools.spec.freq2bin(even_frac_freq_negpos,fs,even_nfft)).^2,[],'all') < tol)

% FRACTIONAL FREQUENCY TO BIN (NEGPOS)
assert(max((odd_bin_negpos - tools.spec.freq2bin(odd_frac_freq_negpos,fs,odd_nfft,true)).^2,[],'all') < tol)
assert(max((even_bin_negpos - tools.spec.freq2bin(even_frac_freq_negpos,fs,even_nfft,true)).^2,[],'all') < tol)

% VERIFY ERROR

% % FULL BIN > NFFT-1
% verifyError(testCase,@() tools.spec.freq2bin(freq_full+1,fs,nfft),'MATLAB:freq2bin:notLessEqual')
%
% % NEGPOS BIN < -NFFT/2+1
% verifyError(testCase,@() tools.spec.freq2bin(freq_negpos-1,fs,nfft),'MATLAB:freq2bin:notGreaterEqual')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BACK AND FORTH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Test 20: INS2BIN2IND

% IND TO BIN TO IND (FULL)
assert(max((odd_ind_full - tools.spec.bin2ind(tools.spec.ind2bin(odd_ind_full))).^2,[],'all') < tol)
assert(max((even_ind_full - tools.spec.bin2ind(tools.spec.ind2bin(even_ind_full))).^2,[],'all') < tol)

% IND TO BIN TO IND (FULL)
assert(max((odd_ind_full - tools.spec.bin2ind(tools.spec.ind2bin(odd_ind_full))).^2,[],'all') < tol)
assert(max((even_ind_full - tools.spec.bin2ind(tools.spec.ind2bin(even_ind_full))).^2,[],'all') < tol)

% IND TO BIN TO IND (NEGPOS)
assert(max((odd_ind_full - tools.spec.bin2ind(tools.spec.ind2bin(odd_ind_full,odd_nfft),odd_nfft)).^2,[],'all') < tol)
assert(max((even_ind_full - tools.spec.bin2ind(tools.spec.ind2bin(even_ind_full,even_nfft),even_nfft)).^2,[],'all') < tol)

%% Test 21: BIN2IND2BIN

% BIN TO IND TO BIN (FULL)
assert(max((odd_bin_full - tools.spec.ind2bin(tools.spec.bin2ind(odd_bin_full))).^2,[],'all') < tol)
assert(max((even_bin_full - tools.spec.ind2bin(tools.spec.bin2ind(even_bin_full))).^2,[],'all') < tol)

% BIN TO IND TO BIN (FULL)
assert(max((odd_bin_full - tools.spec.ind2bin(tools.spec.bin2ind(odd_bin_full))).^2,[],'all') < tol)
assert(max((even_bin_full - tools.spec.ind2bin(tools.spec.bin2ind(even_bin_full))).^2,[],'all') < tol)

% BIN TO IND TO BIN (NEGPOS->FULL)
assert(max((odd_bin_full - tools.spec.ind2bin(tools.spec.bin2ind(odd_bin_negpos,odd_nfft))).^2,[],'all') < tol)
assert(max((even_bin_full - tools.spec.ind2bin(tools.spec.bin2ind(even_bin_negpos,even_nfft))).^2,[],'all') < tol)

% BIN TO IND TO BIN (NEGPOS->FULL)
assert(max((odd_bin_negpos - tools.spec.ind2bin(tools.spec.bin2ind(odd_bin_negpos,odd_nfft),odd_nfft)).^2,[],'all') < tol)
assert(max((even_bin_negpos - tools.spec.ind2bin(tools.spec.bin2ind(even_bin_negpos,even_nfft),even_nfft)).^2,[],'all') < tol)

%% Test 22: BIN2FREQ2BIN

% BIN TO FREQ TO BIN (FULL)
assert(max((odd_bin_full - tools.spec.freq2bin(tools.spec.bin2freq(odd_bin_full,fs,odd_nfft),fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_bin_full - tools.spec.freq2bin(tools.spec.bin2freq(even_bin_full,fs,even_nfft),fs,even_nfft)).^2,[],'all') < tol)

% FRACTIONAL BIN TO FREQ TO FRACTIONAL BIN (FULL)
assert(max((odd_frac_bin_full - tools.spec.freq2bin(tools.spec.bin2freq(odd_frac_bin_full,fs,odd_nfft),fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_frac_bin_full - tools.spec.freq2bin(tools.spec.bin2freq(even_frac_bin_full,fs,even_nfft),fs,even_nfft)).^2,[],'all') < tol)

% BIN TO FREQ TO BIN (NEGPOS)
assert(max((odd_bin_negpos - tools.spec.freq2bin(tools.spec.bin2freq(odd_bin_negpos,fs,odd_nfft),fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_bin_negpos - tools.spec.freq2bin(tools.spec.bin2freq(even_bin_negpos,fs,even_nfft),fs,even_nfft)).^2,[],'all') < tol)

% FRACTIONAL BIN TO FREQ TO FRACTIONAL BIN (NEGPOS)
assert(max((odd_frac_bin_negpos - tools.spec.freq2bin(tools.spec.bin2freq(odd_frac_bin_negpos,fs,odd_nfft),fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_frac_bin_negpos - tools.spec.freq2bin(tools.spec.bin2freq(even_frac_bin_negpos,fs,even_nfft),fs,even_nfft)).^2,[],'all') < tol)

%% Test 23: FREQ2BIN2FREQ

% FREQ TO BIN TO FREQ (FULL)
assert(max((odd_freq_full - tools.spec.bin2freq(tools.spec.freq2bin(odd_freq_full,fs,odd_nfft),fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_freq_full - tools.spec.bin2freq(tools.spec.freq2bin(even_freq_full,fs,even_nfft),fs,even_nfft)).^2,[],'all') < tol)

% FRACTIONAL FREQ TO BIN TO FRACTIONAL FREQ (FULL)
assert(max((odd_frac_freq_full - tools.spec.bin2freq(tools.spec.freq2bin(odd_frac_freq_full,fs,odd_nfft),fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_frac_freq_full - tools.spec.bin2freq(tools.spec.freq2bin(even_frac_freq_full,fs,even_nfft),fs,even_nfft)).^2,[],'all') < tol)

% FREQ TO BIN TO FREQ (NEGPOS)
assert(max((odd_freq_negpos - tools.spec.bin2freq(tools.spec.freq2bin(odd_freq_negpos,fs,odd_nfft),fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_freq_negpos - tools.spec.bin2freq(tools.spec.freq2bin(even_freq_negpos,fs,even_nfft),fs,even_nfft)).^2,[],'all') < tol)

% FRACTIONAL FREQ TO FRACTIONAL BIN TO FRACTIONAL FREQ (NEGPOS)
assert(max((odd_frac_freq_negpos - tools.spec.bin2freq(tools.spec.freq2bin(odd_frac_freq_negpos,fs,odd_nfft),fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_frac_freq_negpos - tools.spec.bin2freq(tools.spec.freq2bin(even_frac_freq_negpos,fs,even_nfft),fs,even_nfft)).^2,[],'all') < tol)

%% Test 24: FREQ2IND2FREQ

% FREQ TO IND TO FREQ (FULL)
assert(max((odd_freq_full - tools.spec.ind2freq(tools.spec.freq2ind(odd_freq_full,fs,odd_nfft),fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_freq_full - tools.spec.ind2freq(tools.spec.freq2ind(even_freq_full,fs,even_nfft),fs,even_nfft)).^2,[],'all') < tol)

% FREQ TO IND TO FREQ (NEGPOS)
assert(max((odd_freq_negpos - tools.spec.ind2freq(tools.spec.freq2ind(odd_freq_negpos,fs,odd_nfft),fs,odd_nfft,true)).^2,[],'all') < tol)
assert(max((even_freq_negpos - tools.spec.ind2freq(tools.spec.freq2ind(even_freq_negpos,fs,even_nfft),fs,even_nfft,true)).^2,[],'all') < tol)

%% Test 25: IND2FREQ2IND

% IND TO FREQ TO IND (FULL)
assert(max((odd_ind_full - tools.spec.freq2ind(tools.spec.ind2freq(odd_ind_full,fs,odd_nfft),fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_ind_full - tools.spec.freq2ind(tools.spec.ind2freq(even_ind_full,fs,even_nfft),fs,even_nfft)).^2,[],'all') < tol)

% IND TO FREQ TO IND (NEGPOS)
assert(max((odd_ind_full - tools.spec.freq2ind(tools.spec.ind2freq(odd_ind_full,fs,odd_nfft,true),fs,odd_nfft)).^2,[],'all') < tol)
assert(max((even_ind_full - tools.spec.freq2ind(tools.spec.ind2freq(even_ind_full,fs,even_nfft,true),fs,even_nfft)).^2,[],'all') < tol)
