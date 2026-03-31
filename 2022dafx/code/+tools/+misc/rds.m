function scalar = rds(fun,array)
%RDS Recurse down to scalar
%   S = RDS(FUN,A) recursively applies FUN the the input array A until the
%   result is the scalar S. RDS is typically useful to modify the behavior
%   of functions that operate across the columns of a matrix (or any other
%   dimension of a multidimensional array), such as the functions SUM,
%   PROD, MAX, and, MIN, the statistics MEAN, STD, VAR, MEDIAN, MODE or the
%   logical functions ALL and ANY, which are natural extensions of the
%   logical operators AND and OR respectively.
%
%   For example, RDS(@MEAN,ARRAY) == MEAN(ARRAY,'all'). The syntax on the
%   right-hand side was introduced in R2018b, so RDS can be used to obtain
%   the same output in previous versions. Note that MEAN(ARRAY(:)) will
%   produce the same result.
%
%   See also RSF, RSD, RECURSDIR, RECURSLISTDIR

% 2020 M Caetano SMT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK FUNCTION ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,2);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Apply FUN to array
int_array = fun(array);

% Base case
if numel(int_array) == 1
    
    % Return INT_ARRAY
    scalar = int_array;
    
    % Recursive case
else
    
    % Remove trailing singleton dimensions
    dim_array = squeeze(int_array);
    
    % Recursive call to RDS
    scalar = tools.misc.rds(fun,dim_array);
    
end

end
