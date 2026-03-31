function opposite_side = lawcosside(side,opposite_angle,angleflag)
%LAWCOSSIDE Use law of cosines to calculate opposite side.
%   O = LAWCOSSIDE(S,A) calculates the opposite side O from the vector of
%   sides S and the opposite angle A using the law of cosines. S is an
%   array of size 2 x NTRI, where NTRI is the number of triangles and A is
%   and array of size 1 x NTRI. The law of cosines states that
%   O^2 = L1^2 + L2^2 - 2L1*L2*cos(A).
%
%   O = LAWCOSSIDE(S,A,ANGLEFLAG) uses ANGLEFLAG to determine if the angle
%   A is in radins or degrees. Use 'RADIAN' or 'DEGREE' respectively. The
%   default is 'RADIAN' for the syntax above.
%
%   See also LAWCOSANGLE

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
        
        cosfun = @cosd;
        
    case 'radian'
        
        cosfun = @cos;
        
    otherwise
        
        cosfun = @cos;
        
end

opposite_side = sqrt(side(1,:).^2 + side(2,:).^2 - 2*side(1,:).*side(2,:)*cosfun(opposite_angle));

end
