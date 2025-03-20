%% ADVANCED_MATLAB_PLOTS.M
% A more complex MATLAB demo script showcasing:
% - Tiled layouts with multiple subplots
% - Error bars, dual y-axes, stacked bar plots
% - 3D surface, contour overlays, and colorbars
% - Polar plot with custom ticks
% - Extensive labeling, legends, and annotations

close all; clear; clc;

%% SECTION 1: Generate Synthetic Data
rng(123);  % for reproducibility

% 1A. Time series with "true" sine wave + noise
t = linspace(0, 2*pi, 50);
trueSignal = sin(t);
noise = 0.2 * randn(size(t));
measuredSignal = trueSignal + noise;

% We'll define some arbitrary "errors" for demonstration
errorVals = 0.1 + 0.1 * rand(size(t));

% 1B. Data for stacked bar chart
numGroups = 5;
groupLabels = {'Group A','Group B','Group C','Group D','Group E'};
cat1 = randi([5, 15], 1, numGroups);
cat2 = randi([5, 15], 1, numGroups);
cat3 = randi([5, 15], 1, numGroups);

% 1C. Scatter data + rough correlation
xScatter = linspace(0, 10, 20);
yScatter = 2*xScatter + 3 + randn(size(xScatter))*3;  % y = 2x + 3 + noise

% 1D. Data for 3D surface
[X3, Y3] = meshgrid(-3:0.1:3, -3:0.1:3);
R = sqrt(X3.^2 + Y3.^2) + eps;  % radius for polar coordinate in the plane
Z3 = sin(R)./R;                % Some radial function

% 1E. Data for polar plot
theta = linspace(0, 2*pi, 100);
r = 1 + 0.3*cos(3*theta);

%% SECTION 2: Tiled Layout with Four Plots
% We'll create one figure with four "subplots" via TiledLayout.
figure('Name','Tiled Layout Demo','NumberTitle','off');
tiledlayout(2,2, 'Padding', 'compact', 'TileSpacing', 'compact');

%% (2A) First tile: Line Plot with Error Bars
nexttile;
errorbar(t, measuredSignal, errorVals, '-o', 'LineWidth', 1.2, ...
    'DisplayName','Measured Signal');
hold on;
plot(t, trueSignal, 'k--', 'LineWidth', 1.2, 'DisplayName','True Signal');
title('Line Plot with Error Bars');
xlabel('Time');
ylabel('Amplitude');
legend('Location','best'); 
grid on;

% A small annotation pointing to the first point
text(t(1)+0.1, measuredSignal(1), '\leftarrow Start',...
    'FontWeight','bold','Color',[0.2 0.2 0.8]);

%% (2B) Second tile: Stacked Bar Plot
nexttile;
barData = [cat1; cat2; cat3]';  % dimension: 5 x 3
bar(barData, 'stacked');
title('Stacked Bar Chart');
xlabel('Groups');
ylabel('Values');
xticklabels(groupLabels);
legend({'Cat1','Cat2','Cat3'}, 'Location','best');
grid on;

%% (2C) Third tile: Dual Y-Axis Plot (yyaxis)
nexttile;
yyaxis left;
plot(t, measuredSignal.^2, 'r', 'LineWidth', 1.2, ...
    'DisplayName','Measured^2');
ylabel('Measured^2');
grid on;

yyaxis right;
plot(t, abs(trueSignal), 'b--', 'LineWidth', 1.2, ...
    'DisplayName','|True Signal|');
ylabel('|True Signal|');
xlabel('Time');
title('Dual Y-Axis Plot');
legend('Location','northwest');

%% (2D) Fourth tile: Scatter with Trend Line
nexttile;
scatter(xScatter, yScatter, 'MarkerEdgeColor','k',...
    'MarkerFaceColor',[0.5 0.8 0.5], 'DisplayName','Data Points');
hold on;

% Simple linear regression
p = polyfit(xScatter, yScatter, 1);  % [slope, intercept]
yFit = polyval(p, xScatter);
plot(xScatter, yFit, 'r-', 'LineWidth', 1.3, 'DisplayName','Fit: y=mx+b');
title('Scatter + Regression Line');
xlabel('x');
ylabel('y');
legend('Location','best');
grid on;

%% SECTION 3: 3D Surface Plot with Contour Overlay
figure('Name','3D Surface + Contour','NumberTitle','off');
surf(X3, Y3, Z3);
shading interp;           % smooth shading
colormap parula;          % a colorful colormap
colorbar;                 % add a colorbar
hold on;
contour3(X3, Y3, Z3, 20, 'k');  % overlay contour lines
title('3D Surface with Contour Overlay');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z = sin(r)/r');
grid on;

% A small annotation arrow on the figure (in normalized figure units)
annotation('arrow',[0.2, 0.15],[0.7, 0.55],'Color','red','LineWidth',1.5);

%% SECTION 4: Polar Plot with Custom Ticks
figure('Name','Polar Plot Demo','NumberTitle','off');
polarplot(theta, r, 'LineWidth',1.2);
title('Polar Plot of r = 1 + 0.3cos(3\theta)');
thetalim([0 360]);
rticks([0.5 1 1.5 2]);  % specify radial ticks
grid on;

% Annotate local maxima
[~, idxMax] = max(r);
text(theta(idxMax), r(idxMax), ' \leftarrow Max radius',...
    'FontWeight','bold','HorizontalAlignment','left');

%% FINISHED
% This script has demonstrated several advanced plotting features in MATLAB:
% - Tiled layouts with subplots
% - Error bars, dual y-axes, stacked bar charts
% - Scatter + linear fit
% - 3D surface plot with contour overlay and colorbar
% - Polar plot with custom ticks and annotation
