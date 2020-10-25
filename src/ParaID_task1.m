%% Task One - Linear Least squares - Two Unkowns
clear
clc

data = load('StudentID_number35352633.mat');
%constants
m = data(1).Mass;
matrix = data(1).Project_Data;
c = data(1).Damping;
%[n,p] = size(matrix);

%variables
dvg = matrix(:,1); 
v = matrix(:,2); 
dv = matrix(:,3); 
ddv = matrix(:,4);
z = matrix(:,5); % Hysteric component

r_force = - m*dvg - m*ddv - c*dv;
A = [v z];
theta = (inv(A.'*A))*(A.'*r_force);
F = A*theta;

% Therefore
alpha = 1 / ((theta(2)/theta(1)) + 1);
k0 = theta(1)/alpha;

figure(1);
scatter3(z,v,r_force, 10);
hold on;
plot3(z, v, r_force, 'r', 'LineWidth',7, 'LineJoin',"round");
title('Force vs Displacement and hysteretic element') 
xlabel('Hysteretic element (z)')
ylabel('Displacement (v)')
zlabel('Restoring Force (F)')
legend('raw data', 'predicted');
grid on;
hold off;

%% Task One - Cost Function - Two Unkowns
theta_array_1 = linspace(-30, 30, 40);
theta_array_2 = linspace(-30, 30, 40);
n = length(theta_array_1);
p = length(theta_array_2);

for i = 1 : n
    for k = 1 : p
        J(i,k) = sum(r_force - theta_array_1(i).*z - theta_array_2(k).*v).^2;
    end
end
[t1, t2] = meshgrid(theta_array_1, theta_array_2);
J_min = sum(r_force - theta(1).*z - theta(2).*v).^2;

surf(t1, t2, J);
hold on;
plot3(theta(1), theta(2), J_min, 'ro', 'MarkerSize', 2.5, 'LineWidth', 10);
colorbar;
xlabel('theta_1');
ylabel('theta_2');
zlabel('J(theta)');
title('J(theta) Vs theta1 and theta2');
hold Off;

contour(t1, t2, J, 10);
hold on;
plot3(theta(1), theta(2), J_min, 'ro', 'MarkerSize', 2.5, 'LineWidth', 10);
xlabel('theta1');
ylabel('theta2');
title('theta1 Vs theta2');
grid on;
hold off;