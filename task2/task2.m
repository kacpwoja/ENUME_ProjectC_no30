clear;
close all;

%Interval and starting values
interval = [0, 20];
xStart = [10, 0];

% -------------------------------------------
% 
% Runge-Kutta 4 constant step - finding step
% 
% -------------------------------------------
h = 0.02;
figure(1);
title("Runge-Kutta 4th order, constant step");

subplot(2,2,1);
hold on;
grid on;
title("x1(t)");

subplot(2,2,2);
hold on;
grid on;
title("x2(t)");

subplot(2,2,[3, 4]);
hold on;
grid on;
title("x1(t), zoomed");
legend('show');
legend('Location', 'eastoutside');
xlim([5.86, 5.89]);
ylim([0.64, 0.67]);

for i = 1:1:10
    [t, x] = RK4constant(@dx, interval, xStart, h);
    subplot(2,2,1);
    plot(t, x(1,:), 'DisplayName', sprintf("Step = %0.5f", h));
    
    subplot(2,2,[3, 4]);
    plot(t, x(1,:), 'DisplayName', sprintf("Step = %0.5f", h));
    
    subplot(2,2,2);
    plot(t, x(2,:), 'DisplayName', sprintf("Step = %0.5f", h));
    
    h = h/2;
end

saveas(1, "./plots/RK4constant.png");
saveas(1, "./plots/RK4constant.fig");

%Runge-Kutta 4 constant step - optimal step
[t, x] = RK4constant(@dx, interval, xStart, 0.005);
figure('Position', [10,10, 1000, 400]);
subplot(1,2,1);
plot(x(1, :), x(2, :));
grid on;
box off;
title("x2(x1)");

subplot(1,2,2);
hold on;
plot(t, x(1, :), 'DisplayName', 'x1');
plot(t, x(2, :), 'DisplayName', 'x2');
grid on;
box off;
title("x1(t) and x2(t)");
legend('show');

saveas(2, "./plots/RK4constantOPTIMAL.png");
saveas(2, "./plots/RK4constantOPTIMAL.fig");

%Runge-Kutta 4 constant step - bigger step
[t, x] = RK4constant(@dx, interval, xStart, 0.02);
figure('Position', [10,10, 1000, 400]);
subplot(1,2,1);
plot(x(1, :), x(2, :));
grid on;
box off;
title("x2(x1)");

subplot(1,2,2);
hold on;
plot(t, x(1, :), 'DisplayName', 'x1');
plot(t, x(2, :), 'DisplayName', 'x2');
grid on;
box off;
title("x1(t) and x2(t)");
legend('show');

saveas(3, "./plots/RK4constantBIG.png");
saveas(3, "./plots/RK4constantBIG.fig");

% -------------------------------------------
% 
% Adams P5EC5E constant step - finding step
% 
% -------------------------------------------
h = 0.0044;

figure(4);
title("Adams P5EC5E, constant step");

subplot(2,2,1);
hold on;
grid on;
title("x1(t)");

subplot(2,2,2);
hold on;
grid on;
title("x2(t)");

subplot(2,2,[3, 4]);
hold on;
grid on;
title("x1(t), zoomed");
legend('show');
legend('Location', 'eastoutside');
xlim([0.25, 0.35]);
ylim([0.6, 1.5]);

for i = 1:1:10
    [t, x] = AdamsP5EC5E(@dx, interval, xStart, h);
    subplot(2,2,1);
    plot(t, x(1,:), 'DisplayName', sprintf("Step = %0.5f", h));
    
    subplot(2,2,[3, 4]);
    plot(t, x(1,:), 'DisplayName', sprintf("Step = %0.5f", h));
    
    subplot(2,2,2);
    plot(t, x(2,:), 'DisplayName', sprintf("Step = %0.5f", h));
    
    h = h/1.5;
end

saveas(4, "./plots/AdamConstant.png");
saveas(4, "./plots/AdamConstant.fig");

%Adams PC constant step - optimal step
[t, x] = AdamsP5EC5E(@dx, interval, xStart, 0.002);
figure('Position', [10,10, 1000, 400]);
subplot(1,2,1);
plot(x(1, :), x(2, :));
grid on;
box off;
title("x2(x1)");

subplot(1,2,2);
hold on;
plot(t, x(1, :), 'DisplayName', 'x1');
plot(t, x(2, :), 'DisplayName', 'x2');
grid on;
box off;
title("x1(t) and x2(t)");
legend('show');

saveas(5, "./plots/AdamOPTIMAL.png");
saveas(5, "./plots/AdamOPTIMAL.fig");

%Adams PC constant step - bigger step
[t, x] = AdamsP5EC5E(@dx, interval, xStart, 0.0044);
figure('Position', [10,10, 1000, 400]);
subplot(1,2,1);
plot(x(1, :), x(2, :));
grid on;
box off;
title("x2(x1)");

subplot(1,2,2);
hold on;
plot(t, x(1, :), 'DisplayName', 'x1');
plot(t, x(2, :), 'DisplayName', 'x2');
grid on;
box off;
title("x1(t) and x2(t)");
legend('show');

saveas(6, "./plots/AdamBIG.png");
saveas(6, "./plots/AdamBIG.fig");

% -------------------------------------------
% 
% Runge-Kutta 4 with variable step
% 
% -------------------------------------------

[t, x, e, h] = RK4variable(@dx, interval, xStart, 1, 1e-8, 1e-8, 1e-8);
figure('Position', [10,10, 1000, 400]);
subplot(1,2,1);
plot(x(1, :), x(2, :));
grid on;
box off;
title("x2(x1)");

subplot(1,2,2);
hold on;
plot(t, x(1, :), 'DisplayName', 'x1');
plot(t, x(2, :), 'DisplayName', 'x2');
grid on;
box off;
title("x1(t) and x2(t)");
legend('show');

saveas(7, "./plots/RK4variable.png");
saveas(7, "./plots/RK4variable.fig");

figure('Position', [10,10, 1000, 400]);
subplot(1,2,1);
plot(t, h);
grid on;
box off;
title("step(t)");

subplot(1,2,2);
hold on;
plot(t, e);
grid on;
box off;
title("Error(t)");

saveas(8, "./plots/RK4variableSE.png");
saveas(8, "./plots/RK4variableSE.fig");

% -------------------------------------------
% 
% ode45
% 
% -------------------------------------------

[t, x] = ode45(@dx, interval, xStart);
figure('Position', [10,10, 1000, 400]);
subplot(1,2,1);
plot(x(:, 1), x(:, 2));
grid on;
box off;
title("x2(x1)");

subplot(1,2,2);
hold on;
plot(t, x(:, 1), 'DisplayName', 'x1');
plot(t, x(:, 2), 'DisplayName', 'x2');
grid on;
box off;
title("x1(t) and x2(t)");
legend('show');

saveas(9, "./plots/ode45.png");
saveas(9, "./plots/ode45.fig");
