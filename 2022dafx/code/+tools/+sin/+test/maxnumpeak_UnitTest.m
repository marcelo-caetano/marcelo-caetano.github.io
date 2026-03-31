% UNIT TEST FOR MAXNUMPEAK

% Command to run UnitTest: res = runtests('tools.sin.test.maxnumpeak_UnitTest')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHARED VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nfft = 64;
nbin = tools.spec.pos_freq_band(nfft);
nframe = 6;
nchannel = 2;

maxnpeak = 7;

amp = nan(nbin,nframe,nchannel);
freq = nan(nbin,nframe,nchannel);
ph = nan(nbin,nframe,nchannel);

amp_maxn = nan(nbin,nframe,nchannel);
freq_maxn = nan(nbin,nframe,nchannel);
ph_maxn = nan(nbin,nframe,nchannel);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST CASES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIRST PAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NPEAK > MAXNPEAK (UNIQUE VALUES)
peak_more = logical([0 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0])';
npeak_more = nnz(peak_more);
amp_more = [1 2 5 10 22 9 17 4 3 6]';
freq_more = [10 20 50 100 120 160 170 200 240 290]';
ph_more = [1 1 1 1 1 1 1 1 1 1]';

amp(peak_more,1,1) = amp_more;
freq(peak_more,1,1) = freq_more;
ph(peak_more,1,1) = ph_more;

peak_more_maxn = logical([0 0 0 0 0 0 0 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0 0 0 1 0 0])';
npeak_more_maxn = nnz(peak_more_maxn);
amp_more_maxn = [5 10 22 9 17 4 6]';
freq_more_maxn = [50 100 120 160 170 200 290]';
ph_more_maxn = [1 1 1 1 1 1 1]';

amp_maxn(peak_more_maxn,1,1) = amp_more_maxn;
freq_maxn(peak_more_maxn,1,1) = freq_more_maxn;
ph_maxn(peak_more_maxn,1,1) = ph_more_maxn;

% NPEAK > MAXNPEAK (ALL REPEATED)
peak_repall = logical([0 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0])';
npeak_repall = nnz(peak_repall);
amp_repall = [16 16 16 16 16 16 16 16 16 16]';
freq_repall = [10 20 50 100 120 160 170 200 240 290]';
ph_repall = [1 1 1 1 1 1 1 1 1 1]';

amp(peak_repall,2,1) = amp_repall;
freq(peak_repall,2,1) = freq_repall;
ph(peak_repall,2,1) = ph_repall;

peak_repall_maxn = logical([0 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0])';
npeap_repall_maxn = nnz(peak_repall_maxn);
amp_repall_maxn = [16 16 16 16 16 16 16]';
freq_repall_maxn = [10 20 50 100 120 160 170]';
ph_repall_maxn = [1 1 1 1 1 1 1]';

amp_maxn(peak_repall_maxn,2,1) = amp_repall_maxn;
freq_maxn(peak_repall_maxn,2,1) = freq_repall_maxn;
ph_maxn(peak_repall_maxn,2,1) = ph_repall_maxn;

% NPEAK > MAXNPEAK (REPEATED VALUES NOT SELECTED => UNIQUE > MAXNPEAK)
peak_repsel1 =   logical([0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0])';
npeak_repsel1 = nnz(peak_repsel1);
amp_repsel1 = [1 1 1 1 1 1 1 18 17 16 15 14 13 12 11 10]';
freq_repsel1 = [10 20 50 100 120 160 170 200 240 290 300 320 340 400 440 450]';
ph_repsel1 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';

amp(peak_repsel1,3,1) = amp_repsel1;
freq(peak_repsel1,3,1) = freq_repsel1;
ph(peak_repsel1,3,1) = ph_repsel1;

peak_repsel1_maxn = logical([0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 0 0])';
npeak_repsel1_maxn = nnz(peak_repsel1_maxn);
amp_repsel1_maxn = [18 17 16 15 14 13 12]';
freq_repsel1_maxn = [200 240 290 300 320 340 400]';
ph_repsel1_maxn = [1 1 1 1 1 1 1]';

amp_maxn(peak_repsel1_maxn,3,1) = amp_repsel1_maxn;
freq_maxn(peak_repsel1_maxn,3,1) = freq_repsel1_maxn;
ph_maxn(peak_repsel1_maxn,3,1) = ph_repsel1_maxn;

% NPEAK > MAXNPEAK (REPEATED VALUES NOT SELECTED => UNIQUE = MAXNPEAK)
peak_repsel2 = logical([0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0])';
npeak_repsel2 = nnz(peak_repsel2);
amp_repsel2 = [1 1 1 1 1 1 1 1 1 16 15 14 13 12 11 10]';
freq_repsel2 = [10 20 50 100 120 160 170 200 240 290 300 320 340 400 440 450]';
ph_repsel2 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';

amp(peak_repsel2,4,1) = amp_repsel2;
freq(peak_repsel2,4,1) = freq_repsel2;
ph(peak_repsel2,4,1) = ph_repsel2;

peak_repsel2_maxn = logical([0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0])';
npeak_repsel2_maxn = nnz(peak_repsel2_maxn);
amp_repsel2_maxn = [16 15 14 13 12 11 10]';
freq_repsel2_maxn = [290 300 320 340 400 440 450]';
ph_repsel2_maxn = [1 1 1 1 1 1 1]';

amp_maxn(peak_repsel2_maxn,4,1) = amp_repsel2_maxn;
freq_maxn(peak_repsel2_maxn,4,1) = freq_repsel2_maxn;
ph_maxn(peak_repsel2_maxn,4,1) = ph_repsel2_maxn;

% NPEAK > MAXNPEAK (REPEATED VALUES NOT SELECTED => UNIQUE < MAXNPEAK)
peak_repsel3 = logical([0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0])';
npeak_repsel3 = nnz(peak_repsel3);
amp_repsel3 = [1 1 1 1 1 1 1 1 1 1 1 1 13 12 11 10]';
freq_repsel3 = [10 20 50 100 120 160 170 200 240 290 300 320 340 400 440 450]';
ph_repsel3 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';

amp(peak_repsel3,5,1) = amp_repsel3;
freq(peak_repsel3,5,1) = freq_repsel3;
ph(peak_repsel3,5,1) = ph_repsel3;

peak_repsel3_maxn = logical([0 1 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 1 0 1 0])';
npeak_repsel3_maxn = nnz(peak_repsel3_maxn);
amp_repsel3_maxn = [1 1 1 13 12 11 10]';
freq_repsel3_maxn = [10 20 50 340 400 440 450]';
ph_repsel3_maxn = [1 1 1 1 1 1 1]';

amp_maxn(peak_repsel3_maxn,5,1) = amp_repsel3_maxn;
freq_maxn(peak_repsel3_maxn,5,1) = freq_repsel3_maxn;
ph_maxn(peak_repsel3_maxn,5,1) = ph_repsel3_maxn;

% NPEAK == 0
peak_no = logical([0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])';
npeak_no = nnz(peak_no);
amp_no = [];
freq_no = [];
ph_no = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECOND PAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NPEAK > MAXNPEAK (REPEATED VALUES SELECTED => REP > MAXNPEAK)
peak_repnot1 = logical([0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0])';
npeak_repnot1 = nnz(peak_repnot1);
amp_repnot1 = [1 2 3 4 5 6 17 17 17 17 17 17 17 17 17 17]';
freq_repnot1 = [10 20 50 100 120 160 170 200 240 290 300 320 340 400 440 450]';
ph_repnot1 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';

amp(peak_repnot1,1,2) = amp_repnot1;
freq(peak_repnot1,1,2) = freq_repnot1;
ph(peak_repnot1,1,2) = ph_repnot1;

peak_repnot1_maxn = logical([0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 0 0 0 0])';
npeak_repnot1_maxn = nnz(peak_repnot1_maxn);
amp_repnot1_maxn = [17 17 17 17 17 17 17]';
freq_repnot1_maxn = [170 200 240 290 300 320 340]';
ph_repnot1_maxn = [1 1 1 1 1 1 1]';

amp_maxn(peak_repnot1_maxn,1,2) = amp_repnot1_maxn;
freq_maxn(peak_repnot1_maxn,1,2) = freq_repnot1_maxn;
ph_maxn(peak_repnot1_maxn,1,2) = ph_repnot1_maxn;

% NPEAK > MAXNPEAK (REPEATED VALUES SELECTED => REP = MAXNPEAK)
peak_repnot2 =   logical([0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0])';
npeak_repnot2 = nnz(peak_repnot2);
amp_repnot2 = [1 2 3 4 5 6 7 8 9 17 17 17 17 17 17 17]';
freq_repnot2 = [10 20 50 100 120 160 170 200 240 290 300 320 340 400 440 450]';
ph_repnot2 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';

amp(peak_repnot2,2,2) = amp_repnot2;
freq(peak_repnot2,2,2) = freq_repnot2;
ph(peak_repnot2,2,2) = ph_repnot2;

peak_repnot2_maxn =   logical([0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0])';
npeak_repnot2_maxn = nnz(peak_repnot2_maxn);
amp_repnot2_maxn = [17 17 17 17 17 17 17]';
freq_repnot2_maxn = [290 300 320 340 400 440 450]';
ph_repnot2_maxn = [1 1 1 1 1 1 1]';

amp_maxn(peak_repnot2_maxn,2,2) = amp_repnot2_maxn;
freq_maxn(peak_repnot2_maxn,2,2) = freq_repnot2_maxn;
ph_maxn(peak_repnot2_maxn,2,2) = ph_repnot2_maxn;

% NPEAK > MAXNPEAK (REPEATED VALUES SELECTED => REP < MAXNPEAK)
peak_repnot3 = logical([0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0])';
npeak_repnot3 = nnz(peak_repnot3);
amp_repnot3 = [17 17 17 17 1 2 3 4 5 6 7 8 9 10 11 12]';
freq_repnot3 = [10 20 50 100 120 160 170 200 240 290 300 320 340 400 440 450]';
ph_repnot3 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';

amp(peak_repnot3,3,2) = amp_repnot3;
freq(peak_repnot3,3,2) = freq_repnot3;
ph(peak_repnot3,3,2) = ph_repnot3;

peak_repnot3_maxn = logical([0 1 0 1 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 1 0])';
npeak_repnot3_maxn = nnz(peak_repnot3_maxn);
amp_repnot3_maxn = [17 17 17 17 10 11 12]';
freq_repnot3_maxn = [10 20 50 100 400 440 450]';
ph_repnot3_maxn = [1 1 1 1 1 1 1]';

amp_maxn(peak_repnot3_maxn,3,2) = amp_repnot3_maxn;
freq_maxn(peak_repnot3_maxn,3,2) = freq_repnot3_maxn;
ph_maxn(peak_repnot3_maxn,3,2) = ph_repnot3_maxn;

% NPEAK == MAXNPEAK
peak_equal = logical([0 0 0 1 0 0 1 0 0 0 0 0 1 0 0 1 0 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 0])';
npeak_equal = nnz(peak_equal);
amp_equal = [3 6 11 20 18 7 1]';
freq_equal = [11 21 51 101 121 161 171]';
ph_equal = [2 2 2 2 2 2 2]';

amp(peak_equal,4,2) = amp_equal;
freq(peak_equal,4,2) = freq_equal;
ph(peak_equal,4,2) = ph_equal;

peak_equal_maxn = logical([0 0 0 1 0 0 1 0 0 0 0 0 1 0 0 1 0 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 0])';
npeak_equal_maxn = nnz(peak_equal_maxn);
amp_equal_maxn = [3 6 11 20 18 7 1]';
freq_equal_maxn = [11 21 51 101 121 161 171]';
ph_equal_maxn = [2 2 2 2 2 2 2]';

amp_maxn(peak_equal_maxn,4,2) = amp_equal_maxn;
freq_maxn(peak_equal_maxn,4,2) = freq_equal_maxn;
ph_maxn(peak_equal_maxn,4,2) = ph_equal_maxn;

% NPEAK < MAXNPEAK (NaN AT THE START)
peak_fewer1 = logical([0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0])';
npeak_fewer1 = nnz(peak_fewer1);
amp_fewer1 = [7 12 34 9]';
freq_fewer1 = [12 22 32 92]';
ph_fewer1 = [3 3 3 3]';

amp(peak_fewer1,5,2) = amp_fewer1;
freq(peak_fewer1,5,2) = freq_fewer1;
ph(peak_fewer1,5,2) = ph_fewer1;

peak_fewer1_maxn = logical([0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0])';
npeak_fewer1_maxn = nnz(peak_fewer1_maxn);
amp_fewer1_maxn = [7 12 34 9]';
freq_fewer1_maxn = [12 22 32 92]';
ph_fewer1_maxn = [3 3 3 3]';

amp_maxn(peak_fewer1_maxn,5,2) = amp_fewer1_maxn;
freq_maxn(peak_fewer1_maxn,5,2) = freq_fewer1_maxn;
ph_maxn(peak_fewer1_maxn,5,2) = ph_fewer1_maxn;

% NPEAK < MAXNPEAK (NaN IN THE MIDDLE)
peak_fewer2 = logical([1 0 1 0 0 1 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])';
npeak_fewer2 = nnz(peak_fewer2);
amp_fewer2 = [7 12 34 9]';
freq_fewer2 = [12 22 32 92]';
ph_fewer2 = [3 3 3 3]';

amp(peak_fewer2,6,2) = amp_fewer2;
freq(peak_fewer2,6,2) = freq_fewer2;
ph(peak_fewer2,6,2) = ph_fewer2;

peak_fewer2_maxn = logical([1 0 1 0 0 1 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])';
npeak_fewer2_maxn = nnz(peak_fewer2_maxn);
amp_fewer2_maxn = [7 12 34 9]';
freq_fewer2_maxn = [12 22 32 92]';
ph_fewer2_maxn = [3 3 3 3]';

amp_maxn(peak_fewer2_maxn,6,2) = amp_fewer2_maxn;
freq_maxn(peak_fewer2_maxn,6,2) = freq_fewer2_maxn;
ph_maxn(peak_fewer2_maxn,6,2) = ph_fewer2_maxn;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

max_amp = cat(3,[22 16 18 16 13 nan(1)],[17 17 17 20 34 34]);
max_freq = cat(3,[120 10 200 290 340 nan(1)],[170 290 10 101 32 32]);
max_ph = cat(3,[1 1 1 1 1 nan(1)],[1 1 1 2 3 3]);

%% Test 1: NPEAK > MAXNPEAK (UNIQUE VALUES)

nframe = 1;
nchannel = 1;

[a,f,p] = tools.sin.maxnumpeak(amp(:,1,1),freq(:,1,1),ph(:,1,1),maxnpeak,nbin,nframe,nchannel,true);
assert(isequal([a f p],[amp_more_maxn freq_more_maxn ph_more_maxn]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,1,1),freq(:,1,1),ph(:,1,1),maxnpeak,nbin,nframe,nchannel,false);
assert(isequaln([a f p],[amp_maxn(:,1,1) freq_maxn(:,1,1) ph_maxn(:,1,1)]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,1,1),freq(:,1,1),ph(:,1,1),maxnpeak,nbin,nframe,nchannel);
assert(isequaln([a f p],[amp_maxn(:,1,1) freq_maxn(:,1,1) ph_maxn(:,1,1)]))

%% Test 2: NPEAK > MAXNPEAK (ALL REPEATED)

nframe = 1;
nchannel = 1;

[a,f,p] = tools.sin.maxnumpeak(amp(:,2,1),freq(:,2,1),ph(:,2,1),maxnpeak,nbin,nframe,nchannel,true);
assert(isequal([a f p],[amp_repall_maxn freq_repall_maxn ph_repall_maxn]),false)

[a,f,p] = tools.sin.maxnumpeak(amp(:,2,1),freq(:,2,1),ph(:,2,1),maxnpeak,nbin,nframe,nchannel,false);
assert(isequaln([a f p],[amp_maxn(:,2,1) freq_maxn(:,2,1) ph_maxn(:,2,1)]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,2,1),freq(:,2,1),ph(:,2,1),maxnpeak,nbin,nframe,nchannel);
assert(isequaln([a f p],[amp_maxn(:,2,1) freq_maxn(:,2,1) ph_maxn(:,2,1)]))

%% Test 3: NPEAK > MAXNPEAK (REPEATED VALUES NOT SELECTED => UNIQUE > MAXNPEAK)

nframe = 1;
nchannel = 1;

[a,f,p] = tools.sin.maxnumpeak(amp(:,3,1),freq(:,3,1),ph(:,3,1),maxnpeak,nbin,nframe,nchannel,true);
assert(isequal([a f p],[amp_repsel1_maxn freq_repsel1_maxn ph_repsel1_maxn]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,3,1),freq(:,3,1),ph(:,3,1),maxnpeak,nbin,nframe,nchannel,false);
assert(isequaln([a f p],[amp_maxn(:,3,1) freq_maxn(:,3,1) ph_maxn(:,3,1)]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,3,1),freq(:,3,1),ph(:,3,1),maxnpeak,nbin,nframe,nchannel);
assert(isequaln([a f p],[amp_maxn(:,3,1) freq_maxn(:,3,1) ph_maxn(:,3,1)]))

%% Test 4: NPEAK > MAXNPEAK (REPEATED VALUES NOT SELECTED => UNIQUE = MAXNPEAK)

nframe = 1;
nchannel = 1;

[a,f,p] = tools.sin.maxnumpeak(amp(:,4,1),freq(:,4,1),ph(:,4,1),maxnpeak,nbin,nframe,nchannel,true);
assert(isequal([a f p],[amp_repsel2_maxn freq_repsel2_maxn ph_repsel2_maxn]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,4,1),freq(:,4,1),ph(:,4,1),maxnpeak,nbin,nframe,nchannel,false);
assert(isequaln([a f p],[amp_maxn(:,4,1) freq_maxn(:,4,1) ph_maxn(:,4,1)]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,4,1),freq(:,4,1),ph(:,4,1),maxnpeak,nbin,nframe,nchannel);
assert(isequaln([a f p],[amp_maxn(:,4,1) freq_maxn(:,4,1) ph_maxn(:,4,1)]))

%% Test 5: NPEAK > MAXNPEAK (REPEATED VALUES NOT SELECTED => UNIQUE < MAXNPEAK)

nframe = 1;
nchannel = 1;

[a,f,p] = tools.sin.maxnumpeak(amp(:,5,1),freq(:,5,1),ph(:,5,1),maxnpeak,nbin,nframe,nchannel,true);
assert(isequal([a f p],[amp_repsel3_maxn freq_repsel3_maxn ph_repsel3_maxn]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,5,1),freq(:,5,1),ph(:,5,1),maxnpeak,nbin,nframe,nchannel,false);
assert(isequaln([a f p],[amp_maxn(:,5,1) freq_maxn(:,5,1) ph_maxn(:,5,1)]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,5,1),freq(:,5,1),ph(:,5,1),maxnpeak,nbin,nframe,nchannel);
assert(isequaln([a f p],[amp_maxn(:,5,1) freq_maxn(:,5,1) ph_maxn(:,5,1)]))

%% Test 6: NPEAK == 0

nframe = 1;
nchannel = 1;

[a,f,p] = tools.sin.maxnumpeak(amp(:,6,1),freq(:,6,1),ph(:,6,1),maxnpeak,nbin,nframe,nchannel,true);
assert(isequaln([a f p],nan(maxnpeak,3)))

[a,f,p] = tools.sin.maxnumpeak(amp(:,6,1),freq(:,6,1),ph(:,6,1),maxnpeak,nbin,nframe,nchannel,false);
assert(isequaln([a f p],[amp_maxn(:,6,1) freq_maxn(:,6,1) ph_maxn(:,6,1)]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,6,1),freq(:,6,1),ph(:,6,1),maxnpeak,nbin,nframe,nchannel);
assert(isequaln([a f p],[amp_maxn(:,6,1) freq_maxn(:,6,1) ph_maxn(:,6,1)]))

%% Test 7: NPEAK > MAXNPEAK (REPEATED VALUES SELECTED => REP > MAXNPEAK)

nframe = 1;
nchannel = 1;

[a,f,p] = tools.sin.maxnumpeak(amp(:,1,2),freq(:,1,2),ph(:,1,2),maxnpeak,nbin,nframe,nchannel,true);
assert(isequal([a f p],[amp_repnot1_maxn freq_repnot1_maxn ph_repnot1_maxn]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,1,2),freq(:,1,2),ph(:,1,2),maxnpeak,nbin,nframe,nchannel,false);
assert(isequaln([a f p],[amp_maxn(:,1,2) freq_maxn(:,1,2) ph_maxn(:,1,2)]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,1,2),freq(:,1,2),ph(:,1,2),maxnpeak,nbin,nframe,nchannel);
assert(isequaln([a f p],[amp_maxn(:,1,2) freq_maxn(:,1,2) ph_maxn(:,1,2)]))

%% Test 8: NPEAK > MAXNPEAK (REPEATED VALUES SELECTED => REP = MAXNPEAK)

nframe = 1;
nchannel = 1;

[a,f,p] = tools.sin.maxnumpeak(amp(:,2,2),freq(:,2,2),ph(:,2,2),maxnpeak,nbin,nframe,nchannel,true);
assert(isequal([a f p],[amp_repnot2_maxn freq_repnot2_maxn ph_repnot2_maxn]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,2,2),freq(:,2,2),ph(:,2,2),maxnpeak,nbin,nframe,nchannel,false);
assert(isequaln([a f p],[amp_maxn(:,2,2) freq_maxn(:,2,2) ph_maxn(:,2,2)]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,2,2),freq(:,2,2),ph(:,2,2),maxnpeak,nbin,nframe,nchannel);
assert(isequaln([a f p],[amp_maxn(:,2,2) freq_maxn(:,2,2) ph_maxn(:,2,2)]))

%% Test 9: NPEAK > MAXNPEAK (REPEATED VALUES SELECTED => REP < MAXNPEAK)

nframe = 1;
nchannel = 1;

[a,f,p] = tools.sin.maxnumpeak(amp(:,3,2),freq(:,3,2),ph(:,3,2),maxnpeak,nbin,nframe,nchannel,true);
assert(isequal([a f p],[amp_repnot3_maxn freq_repnot3_maxn ph_repnot3_maxn]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,3,2),freq(:,3,2),ph(:,3,2),maxnpeak,nbin,nframe,nchannel,false);
assert(isequaln([a f p],[amp_maxn(:,3,2) freq_maxn(:,3,2) ph_maxn(:,3,2)]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,3,2),freq(:,3,2),ph(:,3,2),maxnpeak,nbin,nframe,nchannel);
assert(isequaln([a f p],[amp_maxn(:,3,2) freq_maxn(:,3,2) ph_maxn(:,3,2)]))

%% Test 10: NPEAK == MAXNPEAK

nframe = 1;
nchannel = 1;

[a,f,p] = tools.sin.maxnumpeak(amp(:,4,2),freq(:,4,2),ph(:,4,2),maxnpeak,nbin,nframe,nchannel,true);
assert(isequal([a f p],[amp_equal_maxn freq_equal_maxn ph_equal_maxn]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,4,2),freq(:,4,2),ph(:,4,2),maxnpeak,nbin,nframe,nchannel,false);
assert(isequaln([a f p],[amp_maxn(:,4,2) freq_maxn(:,4,2) ph_maxn(:,4,2)]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,4,2),freq(:,4,2),ph(:,4,2),maxnpeak,nbin,nframe,nchannel);
assert(isequaln([a f p],[amp_maxn(:,4,2) freq_maxn(:,4,2) ph_maxn(:,4,2)]))

%% Test 11: NPEAK < MAXNPEAK (NaN AT THE BEGINNING)

nframe = 1;
nchannel = 1;

[a,f,p] = tools.sin.maxnumpeak(amp(:,5,2),freq(:,5,2),ph(:,5,2),maxnpeak,nbin,nframe,nchannel,true);
assert(isequaln([a f p],[[nan(3,1);amp_fewer1_maxn] [nan(3,1);freq_fewer1_maxn] [nan(3,1);ph_fewer1_maxn]]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,5,2),freq(:,5,2),ph(:,5,2),maxnpeak,nbin,nframe,nchannel,false);
assert(isequaln([a f p],[amp_maxn(:,5,2) freq_maxn(:,5,2) ph_maxn(:,5,2)]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,5,2),freq(:,5,2),ph(:,5,2),maxnpeak,nbin,nframe,nchannel);
assert(isequaln([a f p],[amp_maxn(:,5,2) freq_maxn(:,5,2) ph_maxn(:,5,2)]))

%% Test 12: NPEAK < MAXNPEAK (NaN AT THE END)

nframe = 1;
nchannel = 1;

[a,f,p] = tools.sin.maxnumpeak(amp(:,6,2),freq(:,6,2),ph(:,6,2),maxnpeak,nbin,nframe,nchannel,true);
A = [amp_fewer2_maxn(1);nan(1,1);amp_fewer2_maxn(2);nan(2,1);amp_fewer2_maxn(3:end)];
F = [freq_fewer2_maxn(1);nan(1,1);freq_fewer2_maxn(2);nan(2,1);freq_fewer2_maxn(3:end)];
P = [ph_fewer2_maxn(1);nan(1,1);ph_fewer2_maxn(2);nan(2,1);ph_fewer2_maxn(3:end)];
assert(isequaln([a f p],[A F P]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,6,2),freq(:,6,2),ph(:,6,2),maxnpeak,nbin,nframe,nchannel,false);
assert(isequaln([a f p],[amp_maxn(:,6,2) freq_maxn(:,6,2) ph_maxn(:,6,2)]))

[a,f,p] = tools.sin.maxnumpeak(amp(:,6,2),freq(:,6,2),ph(:,6,2),maxnpeak,nbin,nframe,nchannel);
assert(isequaln([a f p],[amp_maxn(:,6,2) freq_maxn(:,6,2) ph_maxn(:,6,2)]))

%% Test 13: STEREO FRAMES

[a,f,p] = tools.sin.maxnumpeak(amp,freq,ph,maxnpeak,nbin,nframe,nchannel,true);
A1 = [amp_more_maxn amp_repall_maxn amp_repsel1_maxn amp_repsel2_maxn amp_repsel3_maxn nan(maxnpeak,1)];
A2 = [amp_repnot1_maxn amp_repnot2_maxn amp_repnot3_maxn amp_equal_maxn [nan(3,1);amp_fewer1_maxn] [amp_fewer2_maxn(1);nan(1,1);amp_fewer2_maxn(2);nan(2,1);amp_fewer2_maxn(3:end)]];
A = cat(3,A1,A2);
F1 = [freq_more_maxn freq_repall_maxn freq_repsel1_maxn freq_repsel2_maxn freq_repsel3_maxn nan(maxnpeak,1)];
F2 = [freq_repnot1_maxn freq_repnot2_maxn freq_repnot3_maxn freq_equal_maxn [nan(3,1);freq_fewer1_maxn] [freq_fewer2_maxn(1);nan(1,1);freq_fewer2_maxn(2);nan(2,1);freq_fewer2_maxn(3:end)]];
F = cat(3,F1,F2);
P1 = [ph_more_maxn ph_repall_maxn ph_repsel1_maxn ph_repsel2_maxn ph_repsel3_maxn nan(maxnpeak,1)];
P2 = [ph_repnot1_maxn ph_repnot2_maxn ph_repnot3_maxn ph_equal_maxn [nan(3,1);ph_fewer1_maxn] [ph_fewer2_maxn(1);nan(1,1);ph_fewer2_maxn(2);nan(2,1);ph_fewer2_maxn(3:end)]];
P = cat(3,P1,P2);
assert(isequaln(a,A))
assert(isequaln(f,F))
assert(isequaln(p,P))

[a,f,p] = tools.sin.maxnumpeak(amp,freq,ph,maxnpeak,nbin,nframe,nchannel,false);
assert(isequaln(a,amp_maxn))
assert(isequaln(f,freq_maxn))
assert(isequaln(p,ph_maxn))

[a,f,p] = tools.sin.maxnumpeak(amp,freq,ph,maxnpeak,nbin,nframe,nchannel);
assert(isequaln(a,amp_maxn))
assert(isequaln(f,freq_maxn))
assert(isequaln(p,ph_maxn))

% 1 peak
[a,f,p] = tools.sin.maxnumpeak(amp,freq,ph,1,nbin,nframe,nchannel,true);
assert(isequaln(a,max_amp))
assert(isequaln(f,max_freq))
assert(isequaln(p,max_ph))
