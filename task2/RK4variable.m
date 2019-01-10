function [t, x, e, h] = RK4variable(dxdt,interval,x0,h0,eRel,eAbs, hmin)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%Constants
s = 0.9;
B = 5;
m = length(dxdt);
%Allocation and initial values
t(1) = interval(1);
x(:, 1) = x0;
h(1) = h0;
e(:, 1) = [0, 0];
n = 1;

while t(n) + h(n) < interval(2)
   %Calculating solution - full step
   k(:, 1) = dxdt(t(n), x(:, n));
   k(:, 2) = dxdt(t(n), x(:, n)+h(n)*k(:, 1)/2);
   k(:, 3) = dxdt(t(n), x(:, n)+h(n)*k(:, 2)/2);
   k(:, 4) = dxdt(t(n), x(:, n)+h(n)*k(:, 3));
   fs = x(:, n) + h(n)/6*(k(:, 1)+2*k(:, 1)+2*k(:, 1)+k(:, 1));
   %Calculating solution - half step
   h_half = h(n)/2;
   hs = x(:, n);
   for i = 1:1:2
       k(:, 1) = dxdt(t(n), hs);
       k(:, 2) = dxdt(t(n), hs+h_half*k(:, 1)/2);
       k(:, 3) = dxdt(t(n), hs+h_half*k(:, 2)/2);
       k(:, 4) = dxdt(t(n), hs+h_half*k(:, 3));
       hs = hs + h_half/6*(k(:, 1)+2*k(:, 1)+2*k(:, 1)+k(:, 1));
   end
   x(:, n+1) = hs;
   %Error estimate
   err = (hs-fs)/(2^4-1);
   e(:, n+1) = err;
   %Step correction
   ei = abs(hs)*eRel+eAbs;
   a = min((ei./abs(err)).^(1/5));
   hProp = s*a*h(n);
   
   if s*a >= 1
       if t(n)+h(n) == interval(2)
           return
       end
       t(n+1) = t(n)+h(n);
       h(n+1) = min([hProp,B*h(n),interval(2)-t(n)]);
       n = n+1;
   else
       if hProp < hmin
           error("Not possible with this hmin");
       else
           h(n) = hProp;
       end
   end
end

end

