function pitchstr = pitch_strength( f, L, pitch_candidate )

% Create pitch strength matrix
pitchstr = zeros(length(pitch_candidate),size(L,2));

% Define integration regions
integration_region = ones(1,length(pitch_candidate)+1);

for iregion = 1:length(integration_region)-1
    
    integration_region(iregion+1) = integration_region(iregion) - 1 + find(f(integration_region(iregion):end)>pitch_candidate(iregion)/4,1,'first');
    
end

integration_region = integration_region(2:end);

% Create loudness normalization matrix
N = sqrt(flipud(cumsum(flipud(L.*L))));

for icand = 1:length(pitch_candidate)
    
    % Normalize loudness
    norm_loud = N(integration_region(icand),:);
    
    % to make zero-loudness equal zero after normalization
    norm_loud(norm_loud==0) = Inf;
    
    NL = L(integration_region(icand):end,:) ./ repmat(norm_loud,size(L,1)-integration_region(icand)+1,1);
    
    % Compute pitch strength
    pitchstr(icand,:) = tools.f0.pitch_strength_cand(f(integration_region(icand):end),NL,pitch_candidate(icand));
    
end

end
