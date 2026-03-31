% BENCHMARK MULTI-DIMENSIONAL ARRAY

% nrow rows
nrow = 600;

% ncol columns
ncol = 80;

% npage pages
npage = 1000;

% Column vector (npage rows, each row will become a page)
col = (1:npage)';

% Number of runs
nbench = 1e02;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FOR LOOP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('For Loop');

% Initialize multidimensional array MDA
mda = zeros(nrow,ncol,npage);

start_loop = tic;

for ibench = 1:nbench
    
    for ipage = 1:npage
        
        for irow = 1:nrow
            
            for icol = 1:ncol
                
                mda(irow,icol,ipage) = col(ipage);
                
            end
            
        end
        
    end
    
end

elap_loop = toc(start_loop);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2 STEPS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Two-Step Assignment');

start_2step = tic;

for ibench = 1:nbench
    
    clear mult;
    
    % Auxiliary array (1 x 1 x ncol)
    mult(1,1,:) = col;
    
    % Multidimensional array (nrow x ncol x npage)
    mult = repmat(mult,nrow,ncol,1);
    
end

elap_2step = toc(start_2step);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Built-In Functions');

start_func = tic;

for ibench = 1:nbench
    
    % Alternative
    MULT = reshape(repmat(col,1,nrow*ncol)',nrow,ncol,npage);
    
end

elap_func = toc(start_func);

fprintf(1,['NBENCH: %12e\nLOOP: %5.5es\n2STEP: %5.5es\n'...
    'FUNC: %5.5es\n'],...
    nbench,elap_loop/nbench,elap_2step/nbench,elap_func/nbench);
