function negent = negentropy(randvar,funcflag)
%NEGENTROPY Negentropy.
%   NE = NEGENTROPY(RV) returns the negentropy NE of the random variable
%   RV. The negentropy is calculated as NE = DE(G) - DE(RV), where DE
%   stands for differential entropy, and G is a Gaussian random variable
%   with the same mean and variance as RV.
%
%   NE = NEGENTROPY(RV,FUNCFLAG) uses FUNCFLAG to specify the method to
%   calculate the negentropy. FUNCFLAG = 'HIST' approximates the PDF of RV
%   using the histogram and FUNCFLAG = 'APPR' approximates the negentropy
%   directly using the relation NE = [E{G(RV(0,1))} - E{G(N(0,1))}]^2,
%   where E{} is the expectation operator, G is the non-linear function
%   G(x) = -exp(-(x^2)/2), RV(0,1) is RV normalized to have mean 0 and std
%   1, and N(0,1) is the normalized Gaussian pdf.
%
%   See also ENTROPY

% Hyvarinen & Oja 2000 "Independent Component Analysis: Algorithms and
% Applications" https://www.cs.helsinki.fi/u/ahyvarin/papers/NN00new.pdf

% 2022 M Caetano

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

narginchk(1,2)
nargoutchk(0,1)

if nargin == 1
    
    funcflag = 'hist';
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Handle to non-linear function
nlf = @(x) -exp(-(x.^2)/2);

mean_randvar = mean(randvar);
std_randvar = std(randvar);

% Gaussian process mean=0 variance=1
gauss_norm = randn(size(randvar));

switch funcflag
    
    case 'hist'
        
        % Gaussian process with the same mean and variance
        gauss_rv = gauss_norm.*std_randvar + mean_randvar;
        % Entropy of Gauss
        Hgauss = tools.math.entropy(gauss_rv);
        % Entropy of data
        Hent = tools.math.entropy(randvar);
        % Negentropy
        negent = Hgauss - Hent;
        
    case 'appr'
        
        randvar_norm = (randvar - mean_randvar)./std_randvar;
        negent = (mean(nlf(randvar_norm)) - mean(nlf(gauss_norm))).^2;
        
    otherwise
        
        error('SMT:NEGENTROPY:InvalidArgument',['Invalid FUNCFLAG\n'...
            'FUNCFLAG must be either HIST or APPR\n'...
            'FUNCFLAG entered was %d\n'],funcflag)
        
end

end
