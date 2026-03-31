a = [-87 -80 -79 -72 -68 -63 -61 -55 -50 -47 -44 -38 -36 -31 -28 -22 -18 -17 -10 -2 -1 0 ...
    1 3 5 6 9 11 15 18 21 25 29 30 34 42 44 56 58 61 66 69 73 75 77 81 85 90 99];

k = 0;

tic
ind1 = tools.fib.fibsearch(a,k);
timefibse1 = toc;

tic
ind2 = tools.fib.fibsearch_old(a,k);
timefibse2 = toc;