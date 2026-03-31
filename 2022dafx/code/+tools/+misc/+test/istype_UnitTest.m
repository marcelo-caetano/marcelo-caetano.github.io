% UNIT TEST FUNCTIONS THAT CHECK INPUT TYPE

% WARNING! Command to run UnitTest: res = runtests('tools.misc.test.istype_UnitTest')
%TODO: FINISH UNIT TEST

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHARED VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Numeric array

% Character array
char_arr = 'nothing to see here';

% String array
str_arr = ["just" "a" "regular" "string";"nothing" "to" "see" "here"];

% Cell array of char
cell_arr_char = {'just' 'a' 'regular' 'string';'nothing' 'to' 'see' 'here'};

% Miscellaneous cell array
misc_cell_arr = {"just" "a" "regular" "string";'nothing' 'to' 'see' 'here'};

%% Test 1: tools.misc.iseven

% fft spectrum: 1 input argument
% assert(isequal(posspec,tools.fft2.full_spec2pos_spec(spec)))

% fft spectrum: 2 input arguments
% assert(isequal(posspec,tools.fft2.full_spec2pos_spec(spec,nfft)))

% fft spectrum: 2 input arguments (wrong NFFT)
% assert(isequal(posspec,tools.fft2.full_spec2pos_spec(spec,nfft-3)))

% fft spectrum: 3 input arguments (no negative spectral energy)
% assert(isequal(posspec,tools.fft2.full_spec2pos_spec(spec,nfft,false)))

% fft spectrum: 3 input arguments (add negative spectral energy)
% assert(isequal(posspec_nrg,tools.fft2.full_spec2pos_spec(spec,nfft,true)))

%% Test 2: tools.misc.isodd

% fft spectrum: 1 input argument
% assert(isequal(spec,tools.fft2.pos_spec2full_spec(posspec)))

% fft spectrum: 2 input arguments
% assert(isequal(spec,tools.fft2.pos_spec2full_spec(posspec,nfft)))

% fft spectrum: 2 input arguments (wrong NFFT)
% assert(isequal(spec,tools.fft2.pos_spec2full_spec(posspec,nfft-3)))

% fft spectrum: 3 input arguments (no negative spectral energy)
% assert(isequal(spec,tools.fft2.pos_spec2full_spec(posspec,nfft,false)))

% fft spectrum: 3 input arguments (add negative spectral energy)
% assert(isequal(spec,tools.fft2.pos_spec2full_spec(posspec_nrg,nfft,true)))

%% Test 3: tools.misc.ispow2

% assert(isequal(magspec,tools.fft2.fft2mag_spec(spec)))

%% Test 4: tools.misc.isint

% 1 input argument
% assert(isequal(phspec,tools.fft2.fft2phase_spec(spec)))

%% Test 5: tools.misc.isfrac

% 1 input argument
% assert(isequal(posmagspec,tools.fft2.fft2pos_mag_spec(spec)))

% 2 input arguments
% assert(isequal(posmagspec,tools.fft2.fft2pos_mag_spec(spec,nfft)))

% 2 input arguments (wrong NFFT)
% assert(isequal(posmagspec,tools.fft2.fft2pos_mag_spec(spec,nfft-3)))

% 3 input arguments (no negative spectral energy)
% assert(isequal(posmagspec,tools.fft2.fft2pos_mag_spec(spec,nfft,false)))

% 3 input arguments (add negative spectral energy)
% assert(isequal(posmagspec_nrg,tools.fft2.fft2pos_mag_spec(spec,nfft,true)))

%% Test 6: tools.misc.istext

% Char array
assert(tools.misc.istext(char_arr))

% String array
assert(tools.misc.istext(str_arr))

% Cell array of char vectors
tools.misc.istext(cell_arr_char)

% Misc array
assert(~tools.misc.istext(misc_cell_arr))
