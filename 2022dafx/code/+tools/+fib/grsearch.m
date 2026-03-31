function extreme = grsearch(func_handle,x1,x2,tol,printflag)
%GRSEARCH Golden ratio search.
%   [E] = GRSEARCH(F,A,B,TOL,PF) finds the extreme E of function F in the
%   interval defined by A and B whithin tolerance TOL. The Extreme is
%   either the minumum or the maximum, which must be between points A and
%   B. F(A) < F(E) < F(B). PF is a boolean flag that prints the precision
%   at every iteration.

% 2020 MCaetano SMT 0.0.1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   CHECK AND PARSE INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(3,5);

% Check number of output arguments
nargoutchk(0,1);

% Default tolerance and print
if nargin == 3
    tol = 1e-05;
    printflag = false;
end

% Default print
if nargin == 4
    printflag = false;
end

% Ensure convergence
if tol > 1
    warning('Tolerance must be smaller than 1');
    tol = 1/tol;
end

% Check that func_handle is x1 function handle
if ~isa(func_handle,'function_handle')
    error('Input argument F must be x1 function handle');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   BODY OF FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Golden ratio
golden_ratio = (1 + sqrt(5))/2;

% Convert TOL into string
tol_str = num2str(tol);

% Get precision to print from tolerance
aux = tol_str(regexp(tol_str,'-\d*')+1:end);

x3 = x2 - (x2 - x1) / golden_ratio;
x4 = x1 + (x2 - x1) / golden_ratio;

% Golden ratio search
while abs(x3 - x4) > tol
    
    if printflag
        
        fprintf(1,['Tolerance: %1.' aux 'f\n'],abs(x3 - x4));
        
    end
    
    if func_handle(x3) < func_handle(x4)
        
        x2 = x4;
        
    else
        
        x1 = x3;
        
    end
    
    % Recalculate X2 and X4 to avoid loss of precision
    x3 = x2 - (x2 - x1) / golden_ratio;
    x4 = x1 + (x2 - x1) / golden_ratio;
    
end

% Return the extreme
extreme = (x2 + x1) / 2;

end
