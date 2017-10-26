close all
%%   Initialize Variables
R = 0.5;        %[m]
r = 0.04;       %[m]
rho_oil = 850;  %[kg/m^3]
c_oil = 1970;   %[J/kgK]
Lc = 1.2;       %[m]
rho_w = 1000;   %[kg/m^3]
c_w = 4190;     %[J/kgK]
h_w = 100;      %[W/Km^2]
k_sp = 1;       %[W/mK]


%%  Initalize and interpolate Ambient Temp

T_amb_discrete=[7 7 8 10 13 15 16 16 17 17 18 17 16 15 13 12 10 9 9];
hours = 0:length(T_amb_discrete)-1;
Time = 0:(length(T_amb_discrete)-1)*3600-1;
T_amb = interp1 (hours,T_amb_discrete,Time/3600,'spline');


%%  Initial Conditions

T0 = [200
      10];

%%  Intialize State Space

%   [dT_oil/dt , dT_w/dt]
A = [-k_sp*(R^2)*3/(r*((R-r)^3)*rho_oil*c_oil)  k_sp*(R^2)*3/(r*((R-r)^3)*rho_oil*c_oil)
     0                                          -h_w*(Lc^2)/(((Lc^3)-(4/3)*pi()*(R^3))*rho_w*c_w)];
 
B = [0
     h_w*(Lc^2)/(((Lc^3)-(4/3)*pi()*(R^3))*rho_w*c_w)];
 
C = [1  0
     0  1];

%%  Simulation

sys = ss(A, B, C, []);
y = lsim(sys, T_amb , Time, T0);

%% Plot Results

figure(1)
subplot(2,1,1)
plot (Time,y(:,1),'k','LineWidth',2)
hold on
plot (Time, y(:,2),'r', 'LineWidth', 2)
hold on
plot (Time, T_amb,'g', 'LineWidth', 2)
grid on
mylegend=legend ('T_oil', 'T_water', 'T_amb')
set (mylegend,'FontSize',10,'Location','SouthEast')
myxlabel=xlabel ('time [s]')
myylabel=ylabel ('Temperature [{\circ}C]')
set (myxlabel,'FontSize',12)
set (myylabel,'FontSize',12)
title('MSE 380 Assignment 1 - Q2 - System Temperature')

subplot(2,1,2)
plot (Time, y(:,2),'r', 'LineWidth', 2)
hold on
plot (Time, T_amb,'g', 'LineWidth', 2)
grid on
mylegend=legend ('T_water', 'T_amb')
set (mylegend,'FontSize',10,'Location','SouthEast')
myxlabel=xlabel ('time [s]')
myylabel=ylabel ('Temperature [{\circ}C]')
set (myxlabel,'FontSize',12)
set (myylabel,'FontSize',12)
title('MSE 380 Assignment 1 - Q2 - Ambient and Water Temperature')
