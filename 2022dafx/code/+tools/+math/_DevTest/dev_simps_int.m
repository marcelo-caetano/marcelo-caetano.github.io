% DEVELOPMENT OF SIMPSON'S NUMERICAL INTEGRATION
% GOAL IS TO REPRODUCE BEHAVIOR OF TRAPZ

% The integration of sin(x) on [0,pi] is 2
% Let us compare TRAPZ and SIMPS
x = linspace(0,pi,6);
% x = linspace(-pi,0,6);
y = sin(x);
trapz(x,y) % returns 1.9338
tools.math.simps(x,y) % returns 2.0071

