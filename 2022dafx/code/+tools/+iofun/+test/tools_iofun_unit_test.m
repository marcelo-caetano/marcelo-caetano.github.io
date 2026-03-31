% UNIT TEST I/O FUNCTIONS

% WARNING! Command to run UnitTest: res = runtests('tools.iofun.test.tools_iofun_unit_test')

% TODO: CHECK ASSERTIONS THAT FAIL
% TODO: ADD TESTS TO FOLLOWING FUNCTIONS
% ADD2PATH
% EOL
% FULLPATH
% ISEMPTYDIR
% ISFILETYPE
% ISFUNCTION
% ISSCRIPT
% NLISTDIR
% PATHCHK
% RECURSLISTDIR
% RSD
% RSF
% USERDIR
% WRITEFILE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHARED VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Baseline path
if ispc
    rootdir = 'D:';
else
    rootdir = filesep;
end

base = {rootdir,'usr','tmp','dir1'};
fname = 'file.ext';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REFERENCE DIR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Full reference dir
ref_same = fullfile(base{:});

% Reference dir SAMEREF absolute dir
ref_part = fullfile(base{1:end-1},'dir2');

% Reference dir PARTREF abolute dir
ref_sub = fullfile(base{:},'subdir1');

% Reference dir and absolute dir have DIFFREF dirs
ref_diff = fullfile(rootdir,'mnt','drive','dir3');

% Reference dir SAMEREF absolute dir
ref_parent = fullfile(base{1:3});

% Reference dir SUBPART absolute dir
ref_subpart = fullfile(base{1:end-1},'dir2','subdir2');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ABSOLUTE DIR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% File inside refdir
abs_sameref = fullfile(base{:},fname);

% File in dir inside parent (tmp) of refdir
abs_partref = fullfile(base{1:end-1},'dir2',fname);

% File in subdir inside refdir
abs_subref = fullfile(base{:},'subdir1',fname);

% File in subdir2 inside parent (tmp) of refdir
abs_subpart = fullfile(base{1:end-1},'dir2','subdir2',fname);

% File in DIFFREF dir
abs_diffref = fullfile(rootdir,'mnt','drive','dir3',fname);

% File in parent dir (tmp) of refdir
abs_parentref = fullfile(base{1:end-1},fname);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RELATIVE DIR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% File inside refdir
rel_sameref = fullfile('.',fname);

% File in dir inside parent (tmp) of refdir
rel_partref = fullfile('..','dir2',fname);

% File in subdir inside refdir
rel_subref = fullfile('.','subdir1',fname);

% File in DIFFREF dir
rel_diffref = fullfile(rootdir,'mnt','drive','dir3',fname);

% File in parent dir (tmp) of refdir
rel_parentref = fullfile('..',fname);

% File in subdir2 inside parent (tmp) of refdir
rel_subpart = fullfile('..','dir2','subdir2',fname);

%% Test 1: isabs

assert(tools.iofun.isabs(ref_same))

%% Test 2: isrel

assert(tools.iofun.isrel(rel_partref))

assert(tools.iofun.isrel(rel_subpart))

%% Test 3: isroot

assert(tools.iofun.isroot(abs_sameref))

%% Test 4: rootdir

assert(isequal(rootdir,tools.iofun.rootdir))

%% Test 5: isdironpath

dev = getenv('DEV');

assert(tools.iofun.isdironpath(dev))

assert(~tools.iofun.isdironpath(abs_sameref))

%% Test 6: mknewdir

curr_dir = pwd;
new_dir = fullfile(curr_dir,'aux');

assert(tools.iofun.mknewdir(new_dir))

s = rmdir(new_dir);
assert(isequal(1,s))

%% Test 1: abs2rel

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST ABS2REL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SAMEREF: File inside refdir
assert(isequal(rel_sameref,tools.iofun.abs2rel(abs_sameref,ref_same)))

% PARTREF: File in dir inside parent (tmp) of refdir
assert(isequal(rel_partref,tools.iofun.abs2rel(abs_partref,ref_same)))

% SUBREF: File in subdir inside refdir
assert(isequal(rel_subref,tools.iofun.abs2rel(abs_subref,ref_same)))

% DIFFREF: File in DIFFREF dir
% assert(isequal(rel_diffref,tools.iofun.abs2rel(abs_diffref,ref_same)))

% PARENTREF: File in parent dir (tmp) of refdir
assert(isequal(rel_parentref,tools.iofun.abs2rel(abs_parentref,ref_same)))

% SUBPART: File in subdir2 inside parent (tmp) of refdir
assert(isequal(rel_subpart,tools.iofun.abs2rel(abs_subpart,ref_same)))

%% Test 2: rel2abs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST REL2ABS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SAMEREF: File inside refdir
assert(isequal(abs_sameref,tools.iofun.rel2abs(rel_sameref,ref_same)))

% PARTREF: File in dir inside parent (tmp) of refdir
assert(isequal(abs_partref,tools.iofun.rel2abs(rel_partref,ref_same)))

% SUBREF: File in subdir inside refdir
assert(isequal(abs_subref,tools.iofun.rel2abs(rel_subref,ref_same)))

% SUBPART: File in subdir2 inside parent (tmp) of refdir
assert(isequal(abs_subpart,tools.iofun.rel2abs(rel_subpart,ref_same)))

% PARENTREF: File in parent dir (tmp) of refdir
assert(isequal(abs_parentref,tools.iofun.rel2abs(rel_parentref,ref_same)))

% DIFFREF: File in DIFFREF dir
assert(isequal(abs_diffref,tools.iofun.rel2abs(rel_diffref,ref_same)))

%% Test 3: abs2rel2abs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST ABS2REL2ABS same REF DIR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SAMEREF: File inside refdir
assert(isequal(abs_sameref,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_sameref,ref_same),ref_same)))

% PARTREF: File in dir inside parent (tmp) of refdir
assert(isequal(abs_partref,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_partref,ref_same),ref_same)))

% SUBREF: File in subdir inside refdir
assert(isequal(abs_subref,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subref,ref_same),ref_same)))

% SUBPART: File in subdir2 inside parent (tmp) of refdir
assert(isequal(abs_subpart,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subpart,ref_same),ref_same)))

% DIFFREF: File in DIFFREF dir
assert(isequal(abs_diffref,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_diffref,ref_same),ref_same)))

% PARENTREF: File in parent dir (tmp) of refdir
assert(isequal(abs_parentref,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_parentref,ref_same),ref_same)))

%% Test 4: rel2abs2rel

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST REL2ABS2REL same REF DIR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SAMEREF: File inside refdir
assert(isequal(rel_sameref,tools.iofun.abs2rel(tools.iofun.rel2abs(rel_sameref,ref_same),ref_same)))

% PARTREF: File in dir inside parent (tmp) of refdir
assert(isequal(rel_partref,tools.iofun.abs2rel(tools.iofun.rel2abs(rel_partref,ref_same),ref_same)))

% SUBREF: File in subdir inside refdir
assert(isequal(rel_subref,tools.iofun.abs2rel(tools.iofun.rel2abs(rel_subref,ref_same),ref_same)))

% SUBPART: File in subdir2 inside parent (tmp) of refdir
assert(isequal(rel_parentref,tools.iofun.abs2rel(tools.iofun.rel2abs(rel_parentref,ref_same),ref_same)))

% DIFFREF: File in DIFFREF dir
% assert(isequal(rel_diffref,tools.iofun.abs2rel(tools.iofun.rel2abs(rel_diffref,ref_same),ref_same)))

% PARENTREF: File in parent dir (tmp) of refdir
assert(isequal(rel_parentref,tools.iofun.abs2rel(tools.iofun.rel2abs(rel_parentref,ref_same),ref_same)))

%% Test 5: same2part

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST SAME2PART: Exchange dir1 and dir2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ex_same = fullfile(base{1:end-1},'dir2',fname);
ex_part = fullfile(base{1:end-1},'dir2',fname);
ex_sub = fullfile(base{1:end-1},'dir2','subdir1',fname);
ex_diff = fullfile('mnt','drive','dir3',fname);
ex_parent = fullfile(base{1:end-1},fname);
ex_subpart = fullfile(base{1:end-1},'dir2','subdir2',fname);

% SAMEREF: File inside refdir
assert(isequal(ex_same,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_sameref,ref_same),ref_part)))

% PARTREF: File in dir inside parent (tmp) of refdir
assert(isequal(ex_part,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_partref,ref_same),ref_part)))

% SUBREF: File in subdir inside refdir
assert(isequal(ex_sub,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subref,ref_same),ref_part)))

% SUBPART: File in subdir2 inside parent (tmp) of refdir
assert(isequal(ex_subpart,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subpart,ref_same),ref_part)))

% DIFFREF: File in DIFFREF dir
% assert(isequal(ex_diff,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_diffref,ref_same),ref_part)))

% PARENTREF: File in parent dir (tmp) of refdir
assert(isequal(ex_parent,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_parentref,ref_same),ref_part)))

%% Test 6: same2sub

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST SAME2SUB: Move down to subdir1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mvdownsub1_same = fullfile(base{:},'subdir1',fname);
mvdownsub1_part = fullfile(base{:},'dir2',fname);
mvdownsub1_sub = fullfile(base{:},'subdir1','subdir1',fname);
mvdownsub1_diff = fullfile('mnt','drive','dir3',fname);
mvdownsub1_parent = fullfile(base{:},fname);
mvdownsub1_subpart = fullfile(base{:},'dir2','subdir2',fname);

% SAMEREF: File inside refdir
assert(isequal(mvdownsub1_same,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_sameref,ref_same),ref_sub)))

% PARTREF: File in dir inside parent (tmp) of refdir
assert(isequal(mvdownsub1_part,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_partref,ref_same),ref_sub)))

% SUBREF: File in subdir inside refdir
assert(isequal(mvdownsub1_sub,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subref,ref_same),ref_sub)))

% SUBPART: File in subdir2 inside parent (tmp) of refdir
assert(isequal(mvdownsub1_subpart,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subpart,ref_same),ref_sub)))

% DIFFREF: File in DIFFREF dir
% assert(isequal(mvdownsub1_diff,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_diffref,ref_same),ref_sub)))

% PARENTREF: File in parent dir (tmp) of refdir
assert(isequal(mvdownsub1_parent,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_parentref,ref_same),ref_sub)))

%% Test 7: same2parent

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST SAME2PARENT: Move up
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mvup_same = fullfile(base{1:end-1},fname);
mvdown_part = fullfile(base{1:end-2},'dir2',fname);
mvdown_sub = fullfile(base{1:end-1},'subdir1',fname);
mvdown_diff = fullfile('mnt','drive','dir3',fname);
mvdown_parent = fullfile(base{1:end-2},fname);
mvdown_subpart = fullfile(base{1:end-2},'dir2','subdir2',fname);

% SAMEREF: File inside refdir
assert(isequal(mvup_same,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_sameref,ref_same),ref_parent)))

% PARTREF: File in dir inside parent (tmp) of refdir
assert(isequal(mvdown_part,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_partref,ref_same),ref_parent)))

% SUBREF: File in subdir inside refdir
assert(isequal(mvdown_sub,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subref,ref_same),ref_parent)))

% SUBPART: File in subdir2 inside parent (tmp) of refdir
assert(isequal(mvdown_subpart,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subpart,ref_same),ref_parent)))

% DIFFREF: File in DIFFREF dir
% assert(isequal(mvdown_diff,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_diffref,ref_same),ref_parent)))

% PARENTREF: File in parent dir (tmp) of refdir
assert(isequal(mvdown_parent,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_parentref,ref_same),ref_parent)))

%% Test 8: same2subpart

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST SAME2SUBPART: Exchange dir1 with dir2 and move down to subdir2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mvdownsub2_same = fullfile(base{1:end-1},'dir2','subdir2',fname);
mvdownsub2_part = fullfile(base{1:end-1},'dir2','dir2',fname);
mvdownsub2_sub = fullfile(base{1:end-1},'dir2','subdir2','subdir1',fname);
mvdownsub2_diff = fullfile('mnt','drive','dir3',fname);
mvdownsub2_parent = fullfile(base{1:end-1},'dir2',fname);
mvdownsub2_subpart = fullfile(base{1:end-1},'dir2','dir2','subdir2',fname);

% SAMEREF: File inside refdir
assert(isequal(mvdownsub2_same,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_sameref,ref_same),ref_subpart)))

% PARTREF: File in dir inside parent (tmp) of refdir
assert(isequal(mvdownsub2_part,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_partref,ref_same),ref_subpart)))

% SUBREF: File in subdir inside refdir
assert(isequal(mvdownsub2_sub,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subref,ref_same),ref_subpart)))

% SUBPART: File in subdir2 inside parent (tmp) of refdir
assert(isequal(mvdownsub2_subpart,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subpart,ref_same),ref_subpart)))

% DIFFREF: File in DIFFREF dir
% assert(isequal(mvdownsub2_diff,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_diffref,ref_same),ref_subpart)))

% PARENTREF: File in parent dir (tmp) of refdir
assert(isequal(mvdownsub2_parent,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_parentref,ref_same),ref_subpart)))

%% Test 9: same2diff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST SAME2DIFF: Move to different dir
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mvdiff_same = fullfile(rootdir,'mnt','drive','dir3',fname);
mvdiff_part = fullfile(rootdir,'mnt','drive','dir2',fname);
mvdiff_sub = fullfile(rootdir,'mnt','drive','dir3','subdir1',fname);
mvdiff_diff = fullfile(rootdir,'mnt','drive','dir3',fname);
mvdiff_parent = fullfile(rootdir,'mnt','drive',fname);
mvdiff_subpart = fullfile(rootdir,'mnt','drive','dir2','subdir2',fname);

% SAMEREF: File inside refdir
assert(isequal(mvdiff_same,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_sameref,ref_same),ref_diff)))

% PARTREF: File in dir inside parent (tmp) of refdir
assert(isequal(mvdiff_part,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_partref,ref_same),ref_diff)))

% SUBREF: File in subdir inside refdir
assert(isequal(mvdiff_sub,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subref,ref_same),ref_diff)))

% SUBPART: File in subdir2 inside parent (tmp) of refdir
assert(isequal(mvdiff_subpart,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subpart,ref_same),ref_diff)))

% DIFFREF: File in DIFFREF dir
assert(isequal(mvdiff_diff,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_diffref,ref_same),ref_diff)))

% PARENTREF: File in parent dir (tmp) of refdir
assert(isequal(mvdiff_parent,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_parentref,ref_same),ref_diff)))

%% Test 10: part2same

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST PART2SAME: Exchange dir no pattern
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exrnd_same = fullfile(base{:},fname);
exrnd_part = fullfile(base{:},fname);
exrnd_sub = fullfile(base{:},'subdir1',fname);
exrnd_diff = fullfile(rootdir,'mnt','drive','dir3',fname);
exrnd_parent = fullfile(base{1:end-1},fname);
exrnd_subpart = fullfile(base{:},'subdir2',fname);

% SAMEREF: File inside refdir
assert(isequal(exrnd_same,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_sameref,ref_part),ref_same)))

% PARTREF: File in dir inside parent (tmp) of refdir
assert(isequal(exrnd_part,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_partref,ref_part),ref_same)))

% SUBREF: File in subdir inside refdir
assert(isequal(exrnd_sub,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subref,ref_part),ref_same)))

% SUBPART: File in subdir2 inside parent (tmp) of refdir
assert(isequal(exrnd_subpart,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subpart,ref_part),ref_same)))

% DIFFREF: File in DIFFREF dir
assert(isequal(exrnd_diff,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_diffref,ref_part),ref_same)))

% PARENTREF: File in parent dir (tmp) of refdir
assert(isequal(exrnd_parent,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_parentref,ref_part),ref_same)))

%% Test 11: part2sub

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST PART2SUB:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Test 12: part2diff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST PART2DIFF:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Test 13: part2parent

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST PART2PARENT:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Test 14: part2subpart

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST PART2SUBPART:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Test 15:
