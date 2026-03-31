function F = fibnum(order)
%FIBNUM Fibonacci number
%   F = FIBNUM(N) returns the Nth Fibonacci number, where N >= 0. The
%   Fibonacci numbers are defined as
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

aux = tools.math.fibseq(order);
F = aux(end);

end
