function [dxdt] = dx(t,x)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

dxdt = [x(2)+x(1)*(0.5-x(1)^2-x(2)^2); -x(1)+x(2)*(0.5-x(1)^2-x(2)^2)];

end

