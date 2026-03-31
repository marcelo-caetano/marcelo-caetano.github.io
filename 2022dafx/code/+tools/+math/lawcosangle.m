function opposite_angle = lawcosangle(side,angleflag)
%LAWCOSANGLE Use law of cosines to calculate opposite angle from sides.
%   A = LAWCOSANGLE(S) calculates the angle A from the vector of sides S
%   using the law of cosines. S is an array of size 3 x NTRI, where NTRI is
%   the number of triangles. The order of sides in S must be S = [O;L1;L1],
%   where O is the side opposite to the angle A and L is either lateral
%   side. The law of cosines states that O^2 = L1^2 + L2^2 - 2L1*L2*cos(A).
%
%   A = LAWCOSANGLE(S,ANGLEFLAG) uses ANGLEFLAG to determine if the angle
%   is returned in radins or degrees. Use 'RADIAN' or 'DEGREE'
%   respectively. The default is 'RADIAN' for the syntax above.
%
%   See also LAWCOSSIDE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

narginchk(1,2)
nargoutchk(0,1)

if nargin == 1
    
    angleflag = 'radian';
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch angleflag
    
    case 'degree'
        
        arccos = @acosd;
        
    case 'radian'
        
        arccos = @acos;
        
    otherwise
        
        arccos = @acos;
        
end

opposite = side(1,:);
lat1 = side(2,:);
lat2 = side(3,:);

cos_opposite_angle = (lat1.^2 + lat2.^2 - opposite.^2)./(2*lat1.*lat2);

opposite_angle = arccos(cos_opposite_angle);

end
