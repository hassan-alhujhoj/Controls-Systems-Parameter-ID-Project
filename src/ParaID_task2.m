%% Example one - Linear Least squares - One Unkown
clear
clc

data = load('StudentID_number35352633.mat');
m = data(1).Mass;
matrix = data(1).Project_Data;
c = data(1).Damping;

[n,p] = size(matrix);
vg_double_dot = matrix(:,1); 
v = matrix(:,2); 
v_dot = matrix(:,3); 
v_double_dot = matrix(:,4);
z = matrix(:,5);


xy_sum = sum(x.*y);
xx_sum = sum(x.*x);
theta_hat = xy_sum/xx_sum;

xp = 0:1;
yp = theta_hat.*xp;

figure(1);
plot(x, y, 'bo');
xlabel('Disp');
ylabel('Force');
grid on;

%% Example one - Cost Function - One Unkown
step_1 = 0.05;
theta_1 = 0:step_1:10;
mm = size(theta_1,2); % take the size of the columb eg nxp take p

J = zeros(mm,1);
col = 1;
for t1 = theta_1
    J_current = 0;
    for i = 1:n
        J_temp = (y(i) - t1*x(i))^2;
        J_current = J_current + J_temp;
    end
    J(col) = J_current;
    col = col + 1;
end

plot(theta_1, J, 'b');
xlabel('theta');
ylabel('J(theta)');
J_min = min(J);

