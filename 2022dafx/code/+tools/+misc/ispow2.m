function res = ispow2(num)
%ISPOW2 Test if a number is a power of two.
%   RES = ISPOW2(NUM) returns TRUE if NUM is a power of two and FALSE
%   otherwise. NUM can be a scalar, vector, or multidimensional array and
%   RES will have the same dimensions. However, NUM must contain positive
%   integers otherwise ISPOW2 throws an error.
%
%   See also ISEVEN, ISODD, ISINT

% 2020 MCaetano SMT 0.1.1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,1);

% Check number of output arguments
nargoutchk(0,1);

% Validate input arguments
classes = {'numeric'};
attr = {'finite','nonnan','integer','positive'};
validateattributes(num,classes,attr);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%res = num ~= 0 && bitand(num,num-1) == 0; When 0 is also allowed
res = bitand(num,num-1) == 0;

end
