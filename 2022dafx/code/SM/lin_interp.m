function [yp,a,b] = lin_interp(x1,x2,x3,y1,y2,y3,xp)
%PHASE_INTERP Linear interpolation of phase value across frequency
%   Detailed explanation goes here

% 2019 MCaetano SMT 0.1.0 (Revised)
% 2020 MCaetano SMT 0.2.0

% LINEAR FIT USING LEAST SQUARES FOR ALL 3 POINS RESULTS IN LOWER SRER THAN LINEAR FIT FOR 2 POINTS BELOW
% a = (3*(x1.*y1 + x2.*y2 + x3.*y3) - (x1 + x2 + x3).*(y1 + y2 + y3)) ./ (3*(x1.^2 + x2.^2 + x3.^2) - (x1 + x2 + x3).^2);
% b = ((y1 + y2 + y3) - a.*(x1 + x2 + x3))/3;
% yp = a.*xp + b;

% Initialize interpolated phase
yh = nan(size(xp));
yl = nan(size(xp));
xh = nan(size(xp));
xl = nan(size(xp));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% XP > X2: FREQUENCIES TO THE RIGHT OF XP (POSITIVE RATIONAL BIN NUMBER)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ind = xp > x2;

yh(ind) = y3(ind);
xh(ind) = x3(ind);
yl(ind) = y2(ind);
xl(ind) = x2(ind);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% XP < X2: FREQUENCIES TO THE LEFT OF XP (NEGATIVE RATIONAL BIN NUMBER)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ind = xp < x2;

yh(ind) = y2(ind);
xh(ind) = x2(ind);
yl(ind) = y1(ind);
xl(ind) = x1(ind);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LINEAR INTERPOLATION OF PHASE USING 2-POINT LEAST SQUARES SIMPLIFICATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = (yh - yl) ./ (xh - xl);
b = (xl.*yh - xh.*yl) ./ (xl - xh);
yp = a.*xp + b;

end
