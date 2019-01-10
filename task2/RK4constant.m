function [t, x] = RK4constant(dxdt,interval,x0,h)
%RK4CONSTANT solves a system of equations using Runge-Kutta 4
%   Detailed explanation goes here

%Error handling
if (interval(2) - interval(1) > 0 && h < 0) || (interval(2) - interval(1) < 0 && h > 0)
    error("Wrong sign of step");
end

%Allocation and initial values
steps = floor(abs(interval(2) - interval(1))/abs(h));
t = zeros(1, steps+1);
t(1) = interval(1);
x(:, 1) = x0;
index = 1;

%Loop
for i = interval(1)+h:h:interval(2)
    %k1
    k(:, 1) = dxdt(t(index), x(:, index));
    %k2
    k(:, 2) = dxdt(t(index), x(:, index)+h*k(:, 1)/2);
    %k3
    k(:, 3) = dxdt(t(index), x(:, index)+h*k(:, 2)/2);
    %k4
    k(:, 4) = dxdt(t(index), x(:, index)+h*k(:, 3));
    %new x
    index = index + 1;
    t(index) = i;
    x(:, index) = x(:, index-1) + h/6*(k(:, 1)+2*k(:, 1)+2*k(:, 1)+k(:, 1));
end

