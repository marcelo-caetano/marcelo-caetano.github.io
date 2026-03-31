% TEST RELATIVE/ABSOLUTE PATH

% Baseline path
base = {'root','usr','tmp','dir1'};
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
ref_diff = fullfile('mnt','drive','dir3');

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
abs_diffref = fullfile('mnt','drive','dir3',fname);

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
rel_diffref = fullfile('mnt','drive','dir3',fname);

% File in parent dir (tmp) of refdir
rel_parentref = fullfile('..',fname);

% File in subdir2 inside parent (tmp) of refdir
rel_subpart = fullfile('..','dir2','subdir2',fname);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST ABS2REL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf(1,'\nTEST ABS2REL\n');

% SAMEREF: File inside refdir
if isequal(rel_sameref,tools.iofun.abs2rel(abs_sameref,ref_same))
    fprintf(1,'ABS2REL SAMEREF successful\n');
else
    warning('ABS2REL SAMEREF failed');
end

% PARTREF: File in dir inside parent (tmp) of refdir
if isequal(rel_partref,tools.iofun.abs2rel(abs_partref,ref_same))
    fprintf(1,'ABS2REL PARTREF successful\n');
else
    warning('ABS2REL PARTREF failed');
end

% SUBREF: File in subdir inside refdir
if isequal(rel_subref,tools.iofun.abs2rel(abs_subref,ref_same))
    fprintf(1,'ABS2REL SUBREF successful\n');
else
    warning('ABS2REL SUBREF failed');
end

% DIFFREF: File in DIFFREF dir
if isequal(rel_diffref,tools.iofun.abs2rel(abs_diffref,ref_same))
    fprintf(1,'ABS2REL DIFFREF successful\n');
else
    warning('ABS2REL DIFFREF failed');
end

% PARENTREF: File in parent dir (tmp) of refdir
if isequal(rel_parentref,tools.iofun.abs2rel(abs_parentref,ref_same))
    fprintf(1,'ABS2REL SUBPART successful\n');
else
    warning('ABS2REL SUBPART failed');
end

% SUBPART: File in subdir2 inside parent (tmp) of refdir
if isequal(rel_subpart,tools.iofun.abs2rel(abs_subpart,ref_same))
    fprintf(1,'ABS2REL SUBPART successful\n');
else
    warning('ABS2REL SUBPART failed');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST REL2ABS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf(1,'\nTEST REL2ABS\n');

% SAMEREF: File inside refdir
if isequal(abs_sameref,tools.iofun.rel2abs(rel_sameref,ref_same))
    fprintf(1,'REL2ABS SAMEREF successful\n');
else
    warning('REL2ABS SAMEREF failed');
end

% PARTREF: File in dir inside parent (tmp) of refdir
if isequal(abs_partref,tools.iofun.rel2abs(rel_partref,ref_same))
    fprintf(1,'REL2ABS PARTREF successful\n');
else
    warning('REL2ABS PARTREF failed');
end

% SUBREF: File in subdir inside refdir
if isequal(abs_subref,tools.iofun.rel2abs(rel_subref,ref_same))
    fprintf(1,'REL2ABS SUBREF successful\n');
else
    warning('REL2ABS SUBREF failed');
end

% SUBPART: File in subdir2 inside parent (tmp) of refdir
if isequal(abs_subpart,tools.iofun.rel2abs(rel_subpart,ref_same))
    fprintf(1,'REL2ABS SUBPART successful\n');
else
    warning('REL2ABS SUBPART failed');
end

% PARENTREF: File in parent dir (tmp) of refdir
if isequal(abs_parentref,tools.iofun.rel2abs(rel_parentref,ref_same))
    fprintf(1,'REL2ABS PARENTREF successful\n');
else
    warning('REL2ABS PARENTREF failed');
end

% DIFFREF: File in DIFFREF dir
if isequal(abs_diffref,tools.iofun.rel2abs(rel_diffref,ref_same))
    fprintf(1,'REL2ABS DIFFREF successful\n');
else
    warning('REL2ABS DIFFREF failed');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST ABS2REL2ABS same REF DIR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf(1,'\nTEST ABS2REL2ABS same REF DIR\n');

% SAMEREF: File inside refdir
if isequal(abs_sameref,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_sameref,ref_same),ref_same))
    fprintf(1,'ABS2REL2ABS SAMEREF successful\n');
else
    warning('ABS2REL2ABS SAMEREF successful\n');
end

% PARTREF: File in dir inside parent (tmp) of refdir
if isequal(abs_partref,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_partref,ref_same),ref_same))
    fprintf(1,'ABS2REL2ABS PARTREF successful\n');
else
    warning('ABS2REL2ABS PARTREF successful\n');
end

% SUBREF: File in subdir inside refdir
if isequal(abs_subref,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subref,ref_same),ref_same))
    fprintf(1,'ABS2REL2ABS SUBREF successful\n');
else
    warning('ABS2REL2ABS SUBREF successful\n');
end

% SUBPART: File in subdir2 inside parent (tmp) of refdir
if isequal(abs_subpart,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subpart,ref_same),ref_same))
    fprintf(1,'ABS2REL2ABS SUBPART successful\n');
else
    warning('ABS2REL2ABS SUBPART successful\n');
end

% DIFFREF: File in DIFFREF dir
if isequal(abs_diffref,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_diffref,ref_same),ref_same))
    fprintf(1,'ABS2REL2ABS DIFFREF successful\n');
else
    warning('ABS2REL2ABS DIFFREF successful\n');
end

% PARENTREF: File in parent dir (tmp) of refdir
if isequal(abs_parentref,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_parentref,ref_same),ref_same))
    fprintf(1,'ABS2REL2ABS PARENTREF successful\n');
else
    warning('ABS2REL2ABS PARENTREF successful\n');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST REL2ABS2REL same REF DIR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf(1,'\nTEST REL2ABS2REL same REF DIR\n');

% SAMEREF: File inside refdir
if isequal(rel_sameref,tools.iofun.abs2rel(tools.iofun.rel2abs(rel_sameref,ref_same),ref_same))
    fprintf(1,'REL2ABS2REL SAMEREF successful\n');
else
    warning('REL2ABS2REL SAMEREF successful\n');
end

% PARTREF: File in dir inside parent (tmp) of refdir
if isequal(rel_partref,tools.iofun.abs2rel(tools.iofun.rel2abs(rel_partref,ref_same),ref_same))
    fprintf(1,'REL2ABS2REL PARTREF successful\n');
else
    warning('REL2ABS2REL PARTREF successful\n');
end

% SUBREF: File in subdir inside refdir
if isequal(rel_subref,tools.iofun.abs2rel(tools.iofun.rel2abs(rel_subref,ref_same),ref_same))
    fprintf(1,'REL2ABS2REL SUBREF successful\n');
else
    warning('REL2ABS2REL SUBREF successful\n');
end

% SUBPART: File in subdir2 inside parent (tmp) of refdir
if isequal(rel_parentref,tools.iofun.abs2rel(tools.iofun.rel2abs(rel_parentref,ref_same),ref_same))
    fprintf(1,'REL2ABS2REL SUBPART successful\n');
else
    warning('REL2ABS2REL SUBPART successful\n');
end

% DIFFREF: File in DIFFREF dir
if isequal(rel_diffref,tools.iofun.abs2rel(tools.iofun.rel2abs(rel_diffref,ref_same),ref_same))
    fprintf(1,'REL2ABS2REL DIFFREF successful\n');
else
    warning('REL2ABS2REL DIFFREF successful\n');
end

% PARENTREF: File in parent dir (tmp) of refdir
if isequal(rel_parentref,tools.iofun.abs2rel(tools.iofun.rel2abs(rel_parentref,ref_same),ref_same))
    fprintf(1,'REL2ABS2REL PARENTREF successful\n');
else
    warning('REL2ABS2REL PARENTREF successful\n');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST SAME2PART: Exchange dir1 and dir2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf(1,'\nTEST SAME2PART\n');
fprintf(1,'\nExchange dir1 with dir2\n');

ex_same = fullfile(base{1:end-1},'dir2',fname);
ex_part = fullfile(base{1:end-1},'dir2',fname);
ex_sub = fullfile(base{1:end-1},'dir2','subdir1',fname);
ex_diff = fullfile('mnt','drive','dir3',fname);
ex_parent = fullfile(base{1:end-1},fname);
ex_subpart = fullfile(base{1:end-1},'dir2','subdir2',fname);

% SAMEREF: File inside refdir
if isequal(ex_same,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_sameref,ref_same),ref_part))
    fprintf(1,'SAME2PART same level successful\n');
else
    warning('SAME2PART same level failed\n');
end

% PARTREF: File in dir inside parent (tmp) of refdir
if isequal(ex_part,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_partref,ref_same),ref_part))
    fprintf(1,'SAME2PART down level dir successful\n');
else
    warning('SAME2PART down level dir failed\n');
end

% SUBREF: File in subdir inside refdir
if isequal(ex_sub,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subref,ref_same),ref_part))
    fprintf(1,'SAME2PART subdir successful\n');
else
    warning('SAME2PART subdir failed\n');
end

% SUBPART: File in subdir2 inside parent (tmp) of refdir
if isequal(ex_subpart,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subpart,ref_same),ref_part))
    fprintf(1,'SAME2PART diff root successful\n');
else
    warning('SAME2PART diff root failed\n');
end

% DIFFREF: File in DIFFREF dir
if isequal(ex_diff,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_diffref,ref_same),ref_part))
    fprintf(1,'SAME2PART down level successful\n');
else
    warning('SAME2PART down level failed\n');
end

% PARENTREF: File in parent dir (tmp) of refdir
if isequal(ex_parent,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_parentref,ref_same),ref_part))
    fprintf(1,'SAME2PART down level dir subdir successful\n');
else
    warning('SAME2PART down level dir subdir failed\n');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST SAME2SUB: Move down to subdir1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf(1,'\nTEST SAME2SUB\n');
fprintf(1,'\nMove down to subdir1\n');

mvdownsub1_same = fullfile(base{:},'subdir1',fname);
mvdownsub1_part = fullfile(base{:},'dir2',fname);
mvdownsub1_sub = fullfile(base{:},'subdir1','subdir1',fname);
mvdownsub1_diff = fullfile('mnt','drive','dir3',fname);
mvdownsub1_parent = fullfile(base{:},fname);
mvdownsub1_subpart = fullfile(base{:},'dir2','subdir2',fname);

% SAMEREF: File inside refdir
if isequal(mvdownsub1_same,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_sameref,ref_same),ref_sub))
    fprintf(1,'SAME2SUB same level successful\n');
else
    warning('SAME2SUB same level failed\n');
end

% PARTREF: File in dir inside parent (tmp) of refdir
if isequal(mvdownsub1_part,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_partref,ref_same),ref_sub))
    fprintf(1,'SAME2SUB down level dir successful\n');
else
    warning('SAME2SUB down level dir failed\n');
end

% SUBREF: File in subdir inside refdir
if isequal(mvdownsub1_sub,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subref,ref_same),ref_sub))
    fprintf(1,'SAME2SUB subdir successful\n');
else
    warning('SAME2SUB subdir failed\n');
end

% SUBPART: File in subdir2 inside parent (tmp) of refdir
if isequal(mvdownsub1_subpart,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subpart,ref_same),ref_sub))
    fprintf(1,'SAME2SUB diff root successful\n');
else
    warning('SAME2SUB diff root failed\n');
end

% DIFFREF: File in DIFFREF dir
if isequal(mvdownsub1_diff,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_diffref,ref_same),ref_sub))
    fprintf(1,'SAME2SUB down level successful\n');
else
    warning('SAME2SUB down level failed\n');
end

% PARENTREF: File in parent dir (tmp) of refdir
if isequal(mvdownsub1_parent,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_parentref,ref_same),ref_sub))
    fprintf(1,'SAME2SUB down level dir subdir successful\n');
else
    warning('SAME2SUB down level dir subdir failed\n');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST SAME2PARENT: Move up
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf(1,'\nTEST SAME2PARENT\n');
fprintf(1,'\nMove up\n');

mvup_same = fullfile(base{1:end-1},fname);
mvdown_part = fullfile(base{1:end-2},'dir2',fname);
mvdown_sub = fullfile(base{1:end-1},'subdir1',fname);
mvdown_diff = fullfile('mnt','drive','dir3',fname);
mvdown_parent = fullfile(base{1:end-2},fname);
mvdown_subpart = fullfile(base{1:end-2},'dir2','subdir2',fname);

% SAMEREF: File inside refdir
if isequal(mvup_same,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_sameref,ref_same),ref_parent))
    fprintf(1,'SAME2PARENT same level successful\n');
else
    warning('SAME2PARENT same level failed\n');
end

% PARTREF: File in dir inside parent (tmp) of refdir
if isequal(mvdown_part,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_partref,ref_same),ref_parent))
    fprintf(1,'SAME2PARENT down level dir successful\n');
else
    warning('SAME2PARENT down level dir failed\n');
end

% SUBREF: File in subdir inside refdir
if isequal(mvdown_sub,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subref,ref_same),ref_parent))
    fprintf(1,'SAME2PARENT subdir successful\n');
else
    warning('SAME2PARENT subdir failed\n');
end

% SUBPART: File in subdir2 inside parent (tmp) of refdir
if isequal(mvdown_subpart,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subpart,ref_same),ref_parent))
    fprintf(1,'SAME2PARENT diff root successful\n');
else
    warning('SAME2PARENT diff root failed\n');
end

% DIFFREF: File in DIFFREF dir
if isequal(mvdown_diff,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_diffref,ref_same),ref_parent))
    fprintf(1,'SAME2PARENT down level successful\n');
else
    warning('SAME2PARENT down level failed\n');
end

% PARENTREF: File in parent dir (tmp) of refdir
if isequal(mvdown_parent,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_parentref,ref_same),ref_parent))
    fprintf(1,'SAME2PARENT down level dir subdir successful\n');
else
    warning('SAME2PARENT down level dir subdir failed\n');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST SAME2SUBPART: Exchange dir1 with dir2 and move down to subdir2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf(1,'\nTEST SAME2SUBPART\n');
fprintf(1,'\nExchange dir1 with dir2 and move down to subdir2\n');

mvdownsub2_same = fullfile(base{1:end-1},'dir2','subdir2',fname);
mvdownsub2_part = fullfile(base{1:end-1},'dir2','dir2',fname);
mvdownsub2_sub = fullfile(base{1:end-1},'dir2','subdir2','subdir1',fname);
mvdownsub2_diff = fullfile('mnt','drive','dir3',fname);
mvdownsub2_parent = fullfile(base{1:end-1},'dir2',fname);
mvdownsub2_subpart = fullfile(base{1:end-1},'dir2','dir2','subdir2',fname);

% SAMEREF: File inside refdir
if isequal(mvdownsub2_same,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_sameref,ref_same),ref_subpart))
    fprintf(1,'SAME2SUBPART same level successful\n');
else
    warning('SAME2SUBPART same level failed\n');
end

% PARTREF: File in dir inside parent (tmp) of refdir
if isequal(mvdownsub2_part,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_partref,ref_same),ref_subpart))
    fprintf(1,'SAME2SUBPART down level dir successful\n');
else
    warning('SAME2SUBPART down level dir failed\n');
end

% SUBREF: File in subdir inside refdir
if isequal(mvdownsub2_sub,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subref,ref_same),ref_subpart))
    fprintf(1,'SAME2SUBPART subdir successful\n');
else
    warning('SAME2SUBPART subdir failed\n');
end

% SUBPART: File in subdir2 inside parent (tmp) of refdir
if isequal(mvdownsub2_subpart,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subpart,ref_same),ref_subpart))
    fprintf(1,'SAME2SUBPART diff root successful\n');
else
    warning('SAME2SUBPART diff root failed\n');
end

% DIFFREF: File in DIFFREF dir
if isequal(mvdownsub2_diff,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_diffref,ref_same),ref_subpart))
    fprintf(1,'SAME2SUBPART down level successful\n');
else
    warning('SAME2SUBPART down level failed\n');
end

% PARENTREF: File in parent dir (tmp) of refdir
if isequal(mvdownsub2_parent,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_parentref,ref_same),ref_subpart))
    fprintf(1,'SAME2SUBPART down level dir subdir successful\n');
else
    warning('SAME2SUBPART down level dir subdir failed\n');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST SAME2DIFF: Move to different dir
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf(1,'\nTEST SAME2DIFF\n');
fprintf(1,'\nMove to different dir\n');

mvdiff_same = fullfile('mnt','drive','dir3',fname);
mvdiff_part = fullfile('mnt','drive','dir2',fname);
mvdiff_sub = fullfile('mnt','drive','dir3','subdir1',fname);
mvdiff_diff = fullfile('mnt','drive','dir3',fname);
mvdiff_parent = fullfile('mnt','drive',fname);
mvdiff_subpart = fullfile('mnt','drive','dir2','subdir2',fname);

% SAMEREF: File inside refdir
if isequal(mvdiff_same,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_sameref,ref_same),ref_diff))
    fprintf(1,'SAME2DIFF same level successful\n');
else
    warning('SAME2DIFF same level failed\n');
end

% PARTREF: File in dir inside parent (tmp) of refdir
if isequal(mvdiff_part,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_partref,ref_same),ref_diff))
    fprintf(1,'SAME2DIFF down level dir successful\n');
else
    warning('SAME2DIFF down level dir failed\n');
end

% SUBREF: File in subdir inside refdir
if isequal(mvdiff_sub,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subref,ref_same),ref_diff))
    fprintf(1,'SAME2DIFF subdir successful\n');
else
    warning('SAME2DIFF subdir failed\n');
end

% SUBPART: File in subdir2 inside parent (tmp) of refdir
if isequal(mvdiff_subpart,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subpart,ref_same),ref_diff))
    fprintf(1,'SAME2DIFF diff root successful\n');
else
    warning('SAME2DIFF diff root failed\n');
end

% DIFFREF: File in DIFFREF dir
if isequal(mvdiff_diff,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_diffref,ref_same),ref_diff))
    fprintf(1,'SAME2DIFF down level successful\n');
else
    warning('SAME2DIFF down level failed\n');
end

% PARENTREF: File in parent dir (tmp) of refdir
if isequal(mvdiff_parent,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_parentref,ref_same),ref_diff))
    fprintf(1,'SAME2DIFF down level dir subdir successful\n');
else
    warning('SAME2DIFF down level dir subdir failed\n');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST PART2SAME: Exchange dir no pattern
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf(1,'\nTEST PART2SAME\n');
fprintf(1,'\nExchange dir no pattern\n');

exrnd_same = fullfile(base{:},fname);
exrnd_part = fullfile(base{:},fname);
exrnd_sub = fullfile(base{:},'subdir1',fname);
exrnd_diff = fullfile('mnt','drive','dir3',fname);
exrnd_parent = fullfile(base{1:end-1},fname);
exrnd_subpart = fullfile(base{:},'subdir2',fname);

% SAMEREF: File inside refdir
if isequal(exrnd_same,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_sameref,ref_part),ref_same))
    fprintf(1,'PART2SAME same level successful\n');
else
    warning('PART2SAME same level failed\n');
end

% PARTREF: File in dir inside parent (tmp) of refdir
if isequal(exrnd_part,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_partref,ref_part),ref_same))
    fprintf(1,'PART2SAME down level dir successful\n');
else
    warning('PART2SAME down level dir failed\n');
end

% SUBREF: File in subdir inside refdir
if isequal(exrnd_sub,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subref,ref_part),ref_same))
    fprintf(1,'PART2SAME subdir successful\n');
else
    warning('PART2SAME subdir failed\n');
end

% SUBPART: File in subdir2 inside parent (tmp) of refdir
if isequal(exrnd_subpart,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_subpart,ref_part),ref_same))
    fprintf(1,'PART2SAME diff root successful\n');
else
    warning('PART2SAME diff root failed\n');
end

% DIFFREF: File in DIFFREF dir
if isequal(exrnd_diff,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_diffref,ref_part),ref_same))
    fprintf(1,'PART2SAME down level successful\n');
else
    warning('PART2SAME down level failed\n');
end

% PARENTREF: File in parent dir (tmp) of refdir
if isequal(exrnd_parent,tools.iofun.rel2abs(tools.iofun.abs2rel(abs_parentref,ref_part),ref_same))
    fprintf(1,'PART2SAME down level dir subdir successful\n');
else
    warning('PART2SAME down level dir subdir failed\n');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST PART2SUB: 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST PART2DIFF: 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST PART2PARENT: 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST PART2SUBPART: 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
