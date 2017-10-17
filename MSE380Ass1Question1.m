close all
%%   Variable Initialization

m1 = 6;     %[kg]
m2 = 12;    %[kg]
b = 80;     %[Ns/m]
k1 = 1000;  %[N/m]
k2 = 1200;  %[N/m]
g = 9.81;   %[m/s^2]
dt = 0.00001;  %[s]

%%  Defining State Space Matrix
A = [0      0       k1      0
     0      0       -k2     k2
     -1/m1  1/m1    -b/m1   b/m1
     0      -1/m2   b/m2    -b/m2];
 
 B = [0
      0
      1
      1];

C = [1      0       0      0    
     0      1       0      0
     1/k1   0       0      0
     1/k1   1/k2    0      0];

D = zeros(4,1);

sys = ss(A, B, C, D);

%%  Define Time Vector

t = 0:dt:15;
u = ones(length(t), 1)*g;

%%  Eulers Method

x = [0
     0
     0
     0];
 
xd = [0
      0
      0
      0];
  
DataArray = [length(t),2];

for i = 1:length(t)
    x = x + xd*dt;
    xd = A*x + B*g;
    y1 = C*x;
    x = y1;
    DataArray(i, 1) = y1(1);
    DataArray(i, 2) = y1(2);
    DataArray(i, 3) = y1(3);
    DataArray(i, 4) = y1(4);
end

%%  State Space Matlab Solution
y = lsim(sys, u, t);

%% Plot Results

figure(1)
subplot(2,1,1)
plot (t,y(:,1),'k','LineWidth',2)
hold on
plot (t, DataArray(:,3),'r', 'LineWidth', 2)
grid on
mylegend=legend ('y1_ODE', 'y1_Euler')
set (mylegend,'FontSize',10,'Location','SouthEast')
myxlabel=xlabel ('time [s]')
myylabel=ylabel ('Displacement [m]')
set (myxlabel,'FontSize',12)
set (myylabel,'FontSize',12)
title('MSE 380 Assignment 1 - Q1 - y1')

subplot(2,1,2)
plot (t, y(:,2),'k', 'LineWidth', 2)
hold on
plot (t, DataArray(:,4),'r', 'LineWidth', 2)
grid on
mylegend=legend ('y2_ODE', 'y2_Euler')
set (mylegend,'FontSize',10,'Location','SouthEast')
myxlabel=xlabel ('time [s]')
myylabel=ylabel ('Displacement [m]')
set (myxlabel,'FontSize',12)
set (myylabel,'FontSize',12)
title('MSE 380 Assignment 1 - Q1 - y2')

