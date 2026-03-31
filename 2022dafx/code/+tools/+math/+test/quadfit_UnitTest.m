% UNIT TEST FOR FUNCTION QUADRATIC FIT

% Command to run UnitTest: res = runtests('tools.math.test.quadfit_UnitTest')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHARED VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exponent for precision [-10:0]
powprec = -10;

% Floating point precision
prec = 10^powprec;

% Abscissa of the maximum
modabsmax = 12560926;
% absmax = modabsmax*prec;
absmax = 1095814517e-10;

% Ordenate of the maximum
ordmax = -99.87;

% Concavity of the parabola: convex < 0; concave > 0
conc = -1;

% Frequency bin
bin = 2;

% Parabola function handle
parab = @(x)conc.*(x-absmax).^2 + ordmax;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST CASES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Symmetrical (y1==y2) + right bin (equally spaced bins)
symm_right_bin = [absmax-bin/2,absmax+bin/2,absmax+3*bin/2];

% Symmetrical (y2==y3) + left bin (equally spaced bins)
symm_left_bin = [absmax-3*bin/2,absmax-bin/2,absmax+bin/2];

% Symmetrical (y1==y3) + peak middle (y2 is peak) (equally spaced bins)
symm_peak_mid = [absmax-bin/2,absmax,absmax+bin/2];

% Symmetrical (y1==y2) + right bin (non-equally spaced bins)
symm_right_bin_ness = [absmax-bin/2,absmax+bin/2,absmax+bin];

% Symmetrical (y2==y3) + left bin (non-equally spaced bins)
symm_left_bin_ness = [absmax-bin,absmax-bin/2,absmax+bin/2];

% Symmetrical (y1==y3) + peak middle (x2 is peak) (non-equally spaced bins)
symm_peak_mid_ness = [absmax-3*bin/2,absmax,absmax+3*bin/2];

% Boundary left: approaching peak from left (equally spaced bins)
bound_peak_left = [absmax-bin,absmax-bin/2,absmax];

% Boundary right: away from peak towards right (equally spaced bins)
bound_peak_right = [absmax,absmax+bin/2,absmax+bin];

nbin = 8;
nframe = 5;
nchannel = 2;

% Arrays of abscissae for test cases
x1 = repmat([symm_right_bin(1) symm_left_bin(1) symm_peak_mid(1) symm_right_bin_ness(1) symm_left_bin_ness(1) symm_peak_mid_ness(1) bound_peak_left(1) bound_peak_right(1)]',1,nframe,nchannel);
x2 = repmat([symm_right_bin(2) symm_left_bin(2) symm_peak_mid(2) symm_right_bin_ness(2) symm_left_bin_ness(2) symm_peak_mid_ness(2) bound_peak_left(2) bound_peak_right(2)]',1,nframe,nchannel);
x3 = repmat([symm_right_bin(3) symm_left_bin(3) symm_peak_mid(3) symm_right_bin_ness(3) symm_left_bin_ness(3) symm_peak_mid_ness(3) bound_peak_left(3) bound_peak_right(3)]',1,nframe,nchannel);

% Arrays of correct results for comparison
Xm = repmat(absmax,nbin,nframe,nchannel);
Ym = repmat(ordmax,nbin,nframe,nchannel);
C = repmat(conc,nbin,nframe,nchannel);

% Error function handle
errfun = @(A,a) abs(A-a);

%% Test 1: exact values

% Tolerance for floating point arithmetic: tol = 1e(powtol)
powtol = -15;
aux = powtol-powprec;
tol = 10^(powprec+aux);

disp('EXACT VALUES')

% Exact values for all cases
[xm,ym,c] = tools.math.quadfit(x1,x2,x3,parab(x1),parab(x2),parab(x3));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

%% Test 2: bin deviation (always causing non-equally spaced bins)

% Deviation
dev = 1e-1;

% Tolerance for floating point arithmetic: tol = 1e(powtol)
powtol = -14;
aux = powtol-powprec;
tol = 10^(powprec+aux);

disp('BIN DEVIATION')

% Plus dev right
[xm,ym,c] = tools.math.quadfit(x1,x2,x3+dev,parab(x1),parab(x2),parab(x3+dev));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

% Minus dev right
[xm,ym,c] = tools.math.quadfit(x1,x2,x3-dev,parab(x1),parab(x2),parab(x3-dev));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

% Plus dev left
[xm,ym,c] = tools.math.quadfit(x1+dev,x2,x3,parab(x1+dev),parab(x2),parab(x3));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

% Minus dev left
[xm,ym,c] = tools.math.quadfit(x1-dev,x2,x3,parab(x1-dev),parab(x2),parab(x3));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

% Double dev out
[xm,ym,c] = tools.math.quadfit(x1-dev,x2,x3+dev,parab(x1-dev),parab(x2),parab(x3+dev));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

% Double dev in
[xm,ym,c] = tools.math.quadfit(x1+dev,x2,x3-dev,parab(x1+dev),parab(x2),parab(x3-dev));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

%% Test 3: large single error

err = 1e-7;

% Tolerance for floating point arithmetic: tol = 1e(powtol)
powtol = -6;
aux = powtol-powprec;
tol = 10^(powprec+aux);

disp('SINGLE ERROR')

% Left abscissae
[xm,ym,c] = tools.math.quadfit(x1+err,x2,x3,parab(x1),parab(x2),parab(x3));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

% Middle abscissae
[xm,ym,c] = tools.math.quadfit(x1,x2+err,x3,parab(x1),parab(x2),parab(x3));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

% Right abscissae
[xm,ym,c] = tools.math.quadfit(x1,x2,x3+err,parab(x1),parab(x2),parab(x3));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

% Left ordinates
[xm,ym,c] = tools.math.quadfit(x1,x2,x3,parab(x1+err),parab(x2),parab(x3));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

% Middle ordinates
[xm,ym,c] = tools.math.quadfit(x1,x2,x3,parab(x1),parab(x2+err),parab(x3));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

% Right ordinates
[xm,ym,c] = tools.math.quadfit(x1,x2,x3,parab(x1),parab(x2),parab(x3+err));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

%% Test 4: double small error same bin

err = 1e-10;

% Tolerance for floating point arithmetic: tol = 1e(powtol);
powtol = -5;
aux = powtol-powprec;
tol = 10^(powprec+aux);

disp('DOUBLE ERROR SAME BIN')

% Left abscissae and ordinates
[xm,ym,c] = tools.math.quadfit(x1-err,x2,x3,parab(x1+err),parab(x2),parab(x3));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

% Middle abscissae and ordinates
[xm,ym,c] = tools.math.quadfit(x1,x2-err,x3,parab(x1),parab(x2+err),parab(x3));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

% Right abscissae and ordinates
[xm,ym,c] = tools.math.quadfit(x1,x2,x3-err,parab(x1),parab(x2),parab(x3+err));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

%% Test 5: double small error different bins

err = 1e-10;

% Tolerance for floating point arithmetic: tol = 1e(powtol);
powtol = -5;
aux = powtol-powprec;
tol = 10^(powprec+aux);

disp('DOUBLE ERROR DIFFERENT BINS')

% Only abscissae
[xm,ym,c] = tools.math.quadfit(x1-err,x2+err,x3,parab(x1),parab(x2),parab(x3));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

[xm,ym,c] = tools.math.quadfit(x1-err,x2,x3+err,parab(x1),parab(x2),parab(x3));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

[xm,ym,c] = tools.math.quadfit(x1,x2+err,x3-err,parab(x1),parab(x2),parab(x3));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

% Only ordinates
[xm,ym,c] = tools.math.quadfit(x1,x2,x3,parab(x1+err),parab(x2-err),parab(x3));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

[xm,ym,c] = tools.math.quadfit(x1,x2,x3,parab(x1+err),parab(x2),parab(x3-err));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

[xm,ym,c] = tools.math.quadfit(x1,x2,x3,parab(x1),parab(x2+err),parab(x3-err));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

% Different abscissae and ordinates
[xm,ym,c] = tools.math.quadfit(x1-err,x2,x3,parab(x1),parab(x2+err),parab(x3));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

[xm,ym,c] = tools.math.quadfit(x1-err,x2,x3,parab(x1),parab(x2),parab(x3+err));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

[xm,ym,c] = tools.math.quadfit(x1,x2-err,x3,parab(x1+err),parab(x2),parab(x3));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

[xm,ym,c] = tools.math.quadfit(x1,x2-err,x3,parab(x1),parab(x2),parab(x3+err));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

[xm,ym,c] = tools.math.quadfit(x1,x2,x3-err,parab(x1+err),parab(x2),parab(x3));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))

[xm,ym,c] = tools.math.quadfit(x1,x2,x3-err,parab(x1),parab(x2),parab(x3+err));
fprintf(1,'Maximum error Xm %2.5g\n',max(errfun(Xm,xm)));
fprintf(1,'Maximum error Ym %2.5g\n',max(errfun(Ym,ym)));
fprintf(1,'Maximum error C %2.5g\n',max(errfun(C,c)));
est_err = errfun([Xm Ym C],[xm ym c]) < tol;
assert(all(est_err(:)))
