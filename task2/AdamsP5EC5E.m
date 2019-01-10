function [t, x] = AdamsP5EC5E(dxdt,interval,x0,h)
%ADAMSP5EC5E solves a system of equations using Adams Prediction-Correction
%order 5
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

%Beta parameters
Bex = [1901, -2774, 2616, -1274, 251]/720;
Bim = [475, 1427, -789, 482, -173, 27]/1440;

%Loop
for i = interval(1)+h:h:interval(2)
    index = index+1;
    t(index) = i;
    %Prediction
    sum = 0;
    for j = 1:1:5
        if index - j < 1
            break
        end
        sum = sum + Bex(j)*dxdt(t(index-j), x(:, index-j));
    end
    xstep = x(:, index-1) + h*sum;
    %Corrector
    sum = 0;
    for j = 1:1:5
        if index - j < 1
            break
        end
        sum = sum + Bim(j+1)*dxdt(t(index-j), x(:, index-j));
    end
    x(:, index) = x(:, index-1) + h*sum + h*Bim(1)*dxdt(t(index-1), xstep);
end

