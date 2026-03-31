function fib = fibseq(order)
%FIBSEQ Fibonacci sequence
%   F = FIBSEQ(N) returns the sequence of Fibonacci numbers from 0 to N.
%   The Fibonacci numbers are defined as
%
%   F(0) = 0
%   F(1) = 1
%   F(order) = F(order-1) + F(order-2)

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

% Check number of input arguments
narginchk(1,1)

% Check number of output arguments
nargoutchk(0,1)

% Validate Input
validateInput(order);

if order == 0
    fib = 0;
elseif order == 1
    fib = [0; 1];
else
    fib = zeros(order+1,1);
    fib(1) = 0;
    fib(2) = 1;
    ind = 3;
    while ind <= order+1
        fib(ind) = fib(ind-1)+fib(ind-2);
        ind = ind+1;
    end
    
end

end

% Private function to validate input
function validateInput(n)

% Check that N is scalar
if numel(n) ~= 1
    error('N must be a scalar')
end

% Check that N is numeric
if not(isnumeric(n))
    error('N must be numeric')
end

% Check that N is single, double, int or uint
if not(any(strcmpi(class(n),{'double','single','uint8','uint16','uint32','uint64',...
        'int8','int16','int32','int64'})))
    error('Class(N) must be SINGLE DOUBLE UINT or INT')
end

% Check that N is integer
if rem(n,1) ~= 0
    error('N must be an integer')
end

% Check that N is non-negative
if n < 0
    error('Fibonacci sequence starts at index 0')
end

% Check that N <= 1476
if n > 1476
    warning('Numeric precision overflow: N > 1496')
end

end
