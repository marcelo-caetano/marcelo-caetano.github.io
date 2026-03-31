function harm_series = mkharm(f0,npart,nframe,nchannel)
%MKHARM Make time-varying harmonic series.
%   Detailed explanation goes here

harm_series = f0.*repmat((1:npart)',1,nframe,nchannel);

end
