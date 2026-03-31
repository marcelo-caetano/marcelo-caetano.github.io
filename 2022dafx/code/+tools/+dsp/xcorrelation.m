function [Rxy,Rl] = xcorrelation(x,y,W,Ss,Kmin,Kdec,Kmax)
%XCORRELATION Cross correlation.
%
%   [Rxy,Rl] = XCORRELATION(X,Y,W,S,Kmin,Kdec,Kmax)
%
%   See also XCORR

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0

if nargin < 3;  W = 600;        end
if nargin < 4;  Ss = 120;       end
if nargin < 5;  Kmin = 0;       end
if nargin < 6;  Kdec = 1;       end
if nargin < 7;  Kmax = W + Ss;  end

% if Kmax > W + Ss
%     Kmax = W + Ss;
% end

% Number of overlapping samples
Wov = W - Ss;

% Column vectors
x = x(:);
y = y(:);

if size(x,1) == size(y,1)
    
    x = [x;zeros(Wov+Kmax-(size(x,1)+1),1)];
    
end

Rl = Kmin:Kdec:Kmax-1;

% Initialize variables
rxy = zeros(length(Rl),1);
rxx = zeros(length(Rl),1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate rxy and rxx
%%%%%%%%%%%%%%%%%%%%%%%%%%%

k = 1;

for ixc = Rl
    
    %     figure(1)
    %     plot(Ss+1:W,y(Ss+1:W),'k')
    %     hold on
    %     plot(1:Wov,x(1+k:Wov+k),'r')
    %     hold off
    %     title(sprintf('k = %d',k))
    %     pause(0.01)
    
    rxy(k) = sum(x(1+ixc:Wov+ixc).*y(Ss+1:W));
    
    rxx(k) = sum(x(1+ixc:Wov+ixc).^2);
    
    k = k + 1;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate ryy
%%%%%%%%%%%%%%%%%%%%%%%%%%%

ryy = sum(y(Ss+1:W).^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate Rxy
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Rxy = (rxy.*abs(rxy))./rxx*ryy;
Rxy = rxy./sqrt(rxx*ryy);

end
