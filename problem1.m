clear all
y_0 = 0;
%y_0 = 1.276; %value found in part d
tau = 0.045;
T = 1/60;
delta_t = T/100;
A = 6788; %starting voltage divided by resistance of 0.1
omega = 2 * pi * 60;
phi = 87.5 * pi/180;
a = tau/delta_t;

t = [0:delta_t:6*tau];
y = zeros(size(t));
x = A* cos(omega * t - phi);
%x = A * exp(j*omega*t)*exp(-j*phi);
for n = 1:1:length(t)-1
    if n == 1
        y(1) = y_0;
        y(n+1) = ((x(n))-y(n)+a*y(n))/a;
    else
        y(n+1) = ((x(n))-y(n)+a*y(n))/a;
    end
end
figure(1);
plot(t,y);
xlabel('Time')
ylabel('Current')