clear;

%Sample vectors
x = [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5];
y = [2.0081, -3.6689, -4.9164, -1.8700, -0.0454, 0.5504, -0.8392, -1.0113, 2.6133, 14.6156, 39.6554];

%Sample graph
figure(1)
plot(x, y, 'ob');
xlim([-6, 6]);
ylim([-10, 45]);
grid on;
box off;
title("Samples for task 1");
saveas(1, "./plots/samples.png");
saveas(1, "./plots/samples.fig");

%Without QR
figure(2)
plot(x, y, 'ob', 'DisplayName', 'Samples');
xlim([-6, 6]);
ylim([-10, 45]);
grid on;
box off;
title("Least Squares without QR");
hold on;
legend('show', 'Location', 'northwest');
legend('boxoff');

maxdegree = 5;
xval = linspace(-6, 6);
errNQR = zeros(1, maxdegree+1);
polyNQR = zeros(maxdegree+1);
for degree = 0:1:maxdegree
    %Using the approximating function
    p = lsfit(x, y, degree);
    %Plotting it on the graph
    yval = polyval(p, xval);
    plot(xval, yval, 'DisplayName', sprintf("Degree = %d", degree));
    %Calculating errors for each approximation
    for i = 1:1:length(x)
        vals = polyval(p, x);
        error = abs(vals - y);
    end
    %Saving the errors and approximations
    errNQR(degree+1) = norm(error);
    for i = 1:1:degree+1
        polyNQR(degree+1,maxdegree-degree+i) = p(i);
    end
end

hold off;
saveas(2, "./plots/NQR.png");
saveas(2, "./plots/NQR.fig");

%With QR
figure(3)
plot(x, y, 'ob', 'DisplayName', 'Samples');
xlim([-6, 6]);
ylim([-10, 45]);
grid on;
box off;
title("Least Squares with QR");
hold on;
legend('show', 'Location', 'northwest');
legend('boxoff');

maxdegree = 5;
xval = linspace(-6, 6);
errQR = zeros(1, maxdegree+1);
polyQR = zeros(maxdegree+1);
for degree = 0:1:maxdegree
    %Using the approximating function
    p = lsfitQR(x, y, degree);
    %Plotting it on the graph
    yval = polyval(p, xval);
    plot(xval, yval, 'DisplayName', sprintf("Degree = %d", degree));
    %Calculating errors for each approximation
    for i = 1:1:length(x)
        vals = polyval(p, x);
        error = vals - y;
    end
    %Saving the errors and approximations
    errQR(degree+1) = norm(error);
    for i = 1:1:degree+1
        polyQR(degree+1,maxdegree-degree+i) = p(i);
    end
end

hold off;
saveas(3, "./plots/QR.png");
saveas(3, "./plots/QR.fig");

errDIFF = errNQR - errQR;
polyDIFF = abs(polyNQR - polyQR);