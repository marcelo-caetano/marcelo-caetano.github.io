function ik = fibsearch(arr,k)
%FIBSEARCH Fibonaccian search
%   I = FIBSEARCH(A,X) searches array A for X and retuns the index I for
%   which A(I) == X. If X is not found in A, I = [].

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

% Check if array is sorted
if ~issorted(arr)
    error('ArrayNotSorted: Input array must be sorted in ascending order')
end

% Length of the array to search
arrlen = length(arr);

% Find smallest Fibonacci order greater than or equal to array length
order = smallestOrder(arrlen);

% % Generate Fibonacci sequence
% fibonacci_sequence = tools.math.fibseq(order);

% Pad array with NaN up to Fib(order)
arr(arrlen+1:tools.math.fibnum(order)) = nan(1);

i = tools.math.fibnum(order-1);
p = tools.math.fibnum(order-2);
q = tools.math.fibnum(order-3);

while true
    
    a=1;
    
    if k < arr(i)
        
        if q == 0
            % Not found: Terminate
            ik = [];
            return
        else
            % Decrease i
            auxi = i;
            auxp = p;
            auxq = q;
            i = auxi - auxq;
            % i = auxp;
            p = auxq;
            q = auxp - auxq;
        end
        
    elseif k > arr(i)
        
        if p == 1
            % Not found: Terminate
            ik = [];
            return
        else
            % Increase i
            auxi = i;
            auxp = p;
            auxq = q;
            i = auxi + auxq;
            p = auxp - auxq;
            q = auxq - auxp;
            % q = 2*auxq - auxp;
        end
        
    else
        
        ik = i;
        return
        
    end
    
end

end

function ord = smallestOrder(len)

% Initialize the order of the Fibinacci sequence
ord = 1;

% Find smallest Fibonacci order greater than or equal to array length
while true
    
    ord = ord + 1;
    
    if tools.math.fibnum(ord) >= len
        
        break
        
    end
    
end

end
