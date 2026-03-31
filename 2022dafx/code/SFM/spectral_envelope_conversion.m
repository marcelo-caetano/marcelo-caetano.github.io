function lin_pred_coeff = spectral_envelope_conversion(spec_env_coeff,order,nfft,nframe,nchannel,specenvflag,logflag,realflag,levflag)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

switch lower(specenvflag)
    
    case 'lpc'
        
        lin_pred_coeff = spec_env_coeff;
        
    case 'rc'
        
        lin_pred_coeff = rc2poly(spec_env_coeff);
        
    case 'lar'
        
        reflect_coeff = lar2rc(spec_env_coeff);
        lin_pred_coeff = rc2poly(reflect_coeff);
        
    case 'isp'
        
        inv_sine_param = is2rc(spec_env_coeff);
        lin_pred_coeff = rc2poly(inv_sine_param);
        
    case 'acs'
        
        % Call LINEAR_PREDICTION
        lin_pred_coeff = levinson(spec_env_coeff);
        
    case {'ceps','tenv'}
        
        lin_pred_coeff = tools.ceps.real_ceps2lin_pred(spec_env_coeff,order,nfft,nframe,nchannel,logflag,realflag,levflag);
        
    otherwise
        
        error('InvalidArgument:SPECTRAL_ENVELOPE_CONVERSION:SMT',...
            'Invalid option %s\n',specenvflag)
        
end

end
