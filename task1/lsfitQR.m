function [p] = lsfitQR(x, y, d)
%LSFITQR finds a polynomial of degree d fitting the points (x, y)
%   uses the least squares approximation with QR factorization

%Error handling
if floor(d) ~= d
    error("Degree of polynomial not an integer");
end
szy = size(y);
if szy(1) ~= 1 && szy(2) ~= 1
    error("Y not a vector");
end
szx = size(x);
if szx(1) ~= 1 && szx(2) ~= 1
    error("X not a vector");
end
if szy(1) == 1
    y = y';
end

%Creating matrix A

A = zeros(length(x),d+1);
for i = 1:1:length(x)
    for j = 0:1:d
        A(i, j+1) = x(i)^j;
    end
end

%Factorizing A
[Q, R] = QRfactorize(A);

%Solving the equations
p = inv(R)*(Q'*y);
p = p';
p = fliplr(p);

end