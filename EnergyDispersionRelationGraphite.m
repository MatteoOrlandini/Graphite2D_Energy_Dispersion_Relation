% see Saito, Dresselhaus - "Phisical properties of carbon nanotubes" pages
% 27 and 28

clc
clear all;
close all;

%phi_a = 1;
%phi_b = 1;
nano = 10^-9;
a = 1;
e2p = 0;
t = -3.033;
s = 0.129;

Eg2Dn = zeros (100, 100);
Eg2Dp = zeros (100, 100);
k_x = linspace(-2*pi/(sqrt(3)*a), 2*pi/(sqrt(3)*a));
%k_y = -3/2*pi/a : 0.1 : 3/2*pi/a;
k_y = linspace(-2*3/(sqrt(2)*a), 2*3/(sqrt(2)*a));
for i = 1:length(k_y)
   for j = 1:length(k_x)
        omega = sqrt(1+4*cos(sqrt(3)*k_x(j)*a/2)*cos(k_y(i)*a/2)+ 4*cos(k_y(i)*a/2)*cos(k_y(i)*a/2));
        Eg2Dn (i,j) = (e2p + t*omega)/(1 + s*omega);
        Eg2Dp (i,j) = (e2p - t*omega)/(1 - s*omega);
   end
end
figure ('Name','Energy Dispersion Relation 2D Graphite','NumberTitle','off');
ax1 = axes('Position',[0.1 0.1 0.8 0.8]);
title(ax1, "Energy Dispersion Relation 2D Graphite");
surf(ax1, k_x, k_y,  Eg2Dn);
hold on;
surf(k_x, k_y, Eg2Dp);
colorbar('eastoutside');
xlabel ('$k_x$', 'Interpreter','latex');
ylabel ('$k_y$', 'Interpreter','latex');
zlabel ('$E~[eV]$', 'Interpreter','latex', 'Rotation', 0);
text(0,0, max(Eg2Dp,[], 'all'), '$\Gamma$', 'VerticalAlignment', 'bottom', 'FontSize', 16, 'Interpreter','latex');
%find high simmetry points 'k'
min_E = min(Eg2Dp,[], 'all');
for i = 1:length(k_y)
   for j = 1:length(k_x)
       if (Eg2Dp (i,j) == min_E)
           if(k_x(j)<0)
               text(k_x(j), k_y(i), Eg2Dp (i,j), '$K$', 'VerticalAlignment', 'middle', 'FontSize', 16, 'HorizontalAlignment', 'right', 'Interpreter','latex');
           else
               text(k_x(j), k_y(i), Eg2Dp (i,j), '$K$', 'VerticalAlignment', 'middle', 'FontSize', 16, 'HorizontalAlignment', 'left', 'Interpreter','latex');
           end
       end
   end
end
text(0, max(k_y), 0, '$K$', 'VerticalAlignment', 'bottom', 'FontSize', 16, 'HorizontalAlignment', 'center', 'Interpreter','latex');
text(0, -max(k_y), 0, '$K$', 'VerticalAlignment', 'top', 'FontSize', 16, 'HorizontalAlignment', 'center', 'Interpreter','latex');
%find high simmetry points 'M'
max_kx = max(k_x); 
index = find(k_x == max_kx);
omega = sqrt(1+4*cos(sqrt(3)*k_x(index)*a/2)*cos(0*a/2)+ 4*cos(0*a/2)*cos(0*a/2));
Eg2Dp_M_point = (e2p - t*omega)/(1 - s*omega);
text(max_kx, 0, Eg2Dp_M_point, '$M$', 'VerticalAlignment', 'top', 'FontSize', 16, 'HorizontalAlignment', 'left', 'Interpreter','latex');
text(-max_kx, 0, Eg2Dp_M_point, '$M$', 'VerticalAlignment', 'top', 'FontSize', 16, 'HorizontalAlignment', 'right', 'Interpreter','latex');

%hexagon1(a, 0, 0);
[x, y] = hexagon2(a, 0, 0);
ax2= axes('Position', [0.65 0.88 0.1 0.1]);
title(ax2, "Unit cell");
plot(ax2, x, y, 'b');
hold on;
arrow_x = [0 x(3)];
arrow_y = [0   y(3)];
plot (ax2,arrow_x, arrow_y, 'b');
text (x(3)/2, y(3)/2, '$a$', 'FontSize', 9, 'Interpreter', 'latex', 'VerticalAlignment', 'bottom');
text(0,0, '$\Gamma$', 'Interpreter','latex',  'FontSize', 10, 'LineWidth', 9);
text(a*sqrt(3)*0.5, 0.5, '$K$', 'HorizontalAlignment', 'left', 'Interpreter','latex',  'FontSize', 9, 'LineWidth', 9);
text(a*sqrt(3)*0.5, 0, '$M$', 'HorizontalAlignment', 'left', 'Interpreter','latex', 'FontSize', 9, 'LineWidth', 9);