function [check1,check2] = mollweide(sidelen,opposite_angle,angleflag,tol)
%MOLLWEIDE Checks consistency of a triangle using Mollweide's formulas.
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

narginchk(2,4)
nargoutchk(0,2)

if nargin == 2
    
    angleflag = 'radian';
    tol = 1e-11;
    
elseif nargin == 3
    
    tol = 1e-11;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch angleflag
    
    case 'degree'
        
        cosfun = @cosd;
        sinfun = @sind;
        
    case 'radian'
        
        cosfun = @cos;
        sinfun = @sin;
        
    otherwise
        
        cosfun = @cos;
        sinfun = @sin;
        
end

check1 = (sidelen(1,:) + sidelen(2,:))./(sidelen(3,:)) - (cosfun((opposite_angle(1,:) - opposite_angle(2,:))/2)./sinfun(opposite_angle(3,:)/2)) < tol;
check2 = (sidelen(1,:) - sidelen(2,:))./(sidelen(3,:)) - (sinfun((opposite_angle(1,:) - opposite_angle(2,:))/2)./cosfun(opposite_angle(3,:)/2)) < tol;

end
