function [cepscoeff,diff,it] = ics(logmagspec,cepswin,nfft,maxit,maxdiff,order,stepflag)
%ICS Iterative cepstral smoothing.
%   CC = ICS(LMS,CEPSWIN,NFFT,MAXIT,MAXDIFF,CEPSORDER,STEPFLAG)
%
%   See also TRUENV, MKCEPSFILT

% 2020 MCaetano SMT 0.1.1

% TODO: FIX HELP
% TODO: VALIDATE INPUTS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(7,7);

% Check number of output arguments
nargoutchk(0,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Nyquist quefrency
inyq = tools.spec.nyq_ind(nfft);

% Initialize iterations
it = 0;

% Initialize maximum difference
diff = realmax;

% TRUE for DIFF > MAXDIFF
bool_diff = diff > maxdiff;

% Initialize smoothed cepstral coefficients
cepsmooth = zeros(size(logmagspec));

while any(bool_diff(:)) && it < maxit
    
    % Cepstral coefficients
    cepscoeff = tools.ceps.log_mag_spec2real_ceps(logmagspec,nfft);
    
    if stepflag
        
        % Inband energy
        inband = sqrt(sum(([cepscoeff(1,:,:);2*cepscoeff(2:order,:,:)]).^2,1));
        
        % Out-of-band energy
        outband = sqrt(sum((2*cepscoeff(order+1:inyq-1,:,:)).^2,1));
        
        % Step factor
        lambda = (inband+outband)./inband;
        
        % Liftered cepstrum
        cepsmooth = lambda.*cepswin.*(cepscoeff-cepsmooth) + cepsmooth;
        
    else
        
        % Liftered cepstrum
        cepsmooth = cepscoeff.*cepswin;
        
    end
    
    % Spectral envelope
    specenv = tools.ceps.real_ceps2log_mag_spec(cepsmooth,nfft);
    
    % Next log magnitude spectrum
    logmagspec = max(logmagspec,specenv);
    
    % Array of maximum differences between LOGMAGSPEC and SPECENV
    diff = max(logmagspec - specenv,[],1);
    
    % TRUE for DIFF > MAXDIFF
    bool_diff = diff > maxdiff;
    
    % Next iteration
    it = it + 1;
    
end

% Return cesptral coefficients
cepscoeff = [cepsmooth(1,:,:);2*cepsmooth(2:order,:,:)];

end
