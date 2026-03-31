function pitchstr = pitch_strength_cand(freq,NL,pitch_candidate)

% Number of harmonics
nharm = fix(freq(end)/pitch_candidate - 0.75);

if nharm == 0
    
    pitchstr = NaN;
    
    return
    
end

% Kernel
kernel = zeros(size(freq));

% Normalize frequency w.r.t. candidate
norm_freq_cand = freq / pitch_candidate;

% Create kernel
for icand = [ 1 primes(nharm) ]
    
    a = abs( norm_freq_cand - icand );
    
    % Peak's weight
    peak_weight = a < .25;
    
    kernel(peak_weight) = cos(2*pi*norm_freq_cand(peak_weight));
    
    % Valleys' weights
    trough_weight = .25 < a & a < .75;
    
    kernel(trough_weight) = kernel(trough_weight) + cos(2*pi*norm_freq_cand(trough_weight))/2;
    
end

% Apply envelope
kernel = kernel .* sqrt(1./freq);

% K+-normalize kernel
kernel = kernel / norm(kernel(kernel>0));

% Compute pitch strength
pitchstr = kernel' * NL;

end
