clear all
y_0 = 167.9;%VL(0-)
abs(y_0);
angle(y_0)*180/pi;
R = 144;%ohms
L = 0.00265;%mH
tau = L/R;
T = 1/60;
delta_t = 5*tau/100;% < T/100
phi = 0;
A = 1.1785;%mag of i for t>0
omega = 2 * pi * 60;
a = tau/delta_t;%used to discretize diff eq
Z = 144 + j*0.999;%impedence after switch opens

%particular sol
t = [0:delta_t:6*tau];
yp = zeros(size(t));
x = R*  (A* cos(omega * t - phi*pi/180)+1.1785*exp(-t/tau));%multiply by R to get VL
for n = 1:1:length(t)-1
    if n == 1
        yp(1) = y_0;
        yp(n+1) = ((x(n))-yp(n)+a*yp(n))/a;
    else
        yp(n+1) = ((x(n))-yp(n)+a*yp(n))/a;
    end
end
figure(1);
plot(t,yp);
xlabel('Time');
ylabel('Voltage VL');
