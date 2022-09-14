clear all
%values of circuit elements
R = 900;
C = 0.1 * 10^(-12);
L = 100 * 10^(-9);
%initial voltage
y_0 = 0;
y_prime_0 = 0;
%variables for diff eq
b = R/L;
c = 1/(L*C);
s = roots([1 b c]);
tau = -1/real(s(1))%time constant
omega_d = imag(s(1))%damping coeff
T_d = 2*pi/omega_d;%period
delta_t = T_d/100;%delta t to discretize

t = [0:delta_t:10*T_d];
y1 = zeros(size(t));
y2 = zeros(size(t));
x = ones(size(t));

for n = 1:1:length(t)-1
    if n == 1
        y1(1) = y_0;
        y2(1) = y_prime_0;
    end
    y1(n+1) = y1(n) + delta_t*y2(n);
    y2(n+1) = delta_t*(x(n) - b*y2(n) -c*y1(n))+y2(n);
end
figure(1);
plot(t,y1,t,(1/c)*ones(size(t)));
xlabel('time')
ylabel('voltage')