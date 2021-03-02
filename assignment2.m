%% Assignment 2
%  
%
%  Author: Ragini Bakshi, Feb 2021

set(0,'DefaultFigureWindowStyle','docked')
set(0, 'defaultaxesfontsize', 12)
set(0, 'defaultaxesfontname', 'Times New Roman')
set(0, 'DefaultLineLineWidth',2);

clear all
close all

%% Part 1 Ramp
nx = 75;
ny = 50;
part = 1;

figure
[Curr, Vmap, Ex, Ey, eFlowx, eFlowy ] = Solve(nx, ny, nx, ny, 1, 0, [1 0], part);

subplot(2,1,1),H = surf(Vmap');
set(H, 'linestyle', 'none');
view(0,90)
subplot(2,1,2),quiver(Ex', Ey');
axis([0 nx 0 ny]);

%% Part 1 Saddle
part = 2;
figure
[Curr, Vmap, Ex, Ey, eFlowx, eFlowy ] = Solve(nx, ny, nx, ny, 1, 0, [1 1 0 0], part);

view(45, 45)
subplot(2,1,1), H = surf(Vmap');
set(H, 'linestyle', 'none');
view(0,90)
subplot(2,1,2),quiver(Ex', Ey');
axis([0 nx 0 ny]);

Width = 100;
Height = 50;

x = linspace(-Width/2, Width/2, nx);
y = linspace(0, Height, ny);
V = zeros(nx, ny);

figure
view(45, 45)
b = Width/2;
a = Height;

% for n = 1:2:101
%     % loop code for V - did it in eipa
%     
% end
% 
% dV = Vmap - V;
% figure
% surf(dV');
% title('Delta V')
% 
% 
% %% Part 2
% part = 3;
% 
% Width = 200e-9;
% Height = 100e-9;
% 
% Boxes = {};
% Boxes{1}.X = [0.8 1.2]*1e-7;
% Boxes{1}.Y = [0.6 1.0]*1e-7;
% Boxes{1}.BC = 's';
% 
% Boxes{2}.X = [0.8 1.2]*1e-7;
% Boxes{2}.Y = [0.0 0.4]*1e-7;
% Boxes{2}.BC = 's';
% 
% [Curr, Vmap, Ex, Ey, eFlowx, eFlowy ] = Solve(Width, Height, nx, ny, 1, 0.0001, [1 0], Boxes, part);
% 
% figure
% subplot(2,2,1),H = surf(Vmap');
% set(H, 'linestyle', 'none');
% view(0,90)
% subplot(2,1,2),quiver(eFlowx', eFlowy');
% axis([0 nx 0 ny]);
% Curr
% 
% nx = 40;
% ny = 20;
% 
% [Curr, Vmap, Ex, Ey, eFlowx, eFlowy ] = Solve(Width, Height, nx, ny, 1, 0.0001, [1 0], Boxes, part);
% 
% figure
% subplot(2,1,1),H = surf(Vmap');
% set(H, 'linestyle','none');
% view(0,90)
% subplot(2,1,2), quiver(eFlowx', eFlowy');
% axis([0 nx 0 ny]);
% Curr
% 

