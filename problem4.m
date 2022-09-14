clear all

%define variables
fileID = fopen('problem4.bin','r');
x = fread(fileID, 'single');
fclose(fileID);
f = 50*10^3;%frequency
f_samp = 2.205 * 10^(6);%frequency of sample
delta_t = 1/f_samp;
endpt = (size(x)-1) * delta_t;%end of time vector

%create time vector and x_out
t = [0:delta_t:endpt];
t = transpose(t);%t same dim as x and demodulator
demod = cos(2*pi*f*t);
x_out = x .* demod;%V source for low pass filter

%plots for x and x_out
plot(t,x,'b')
hold on
plot(t,x_out,'r')
%xlabel('Time');
%ylabel('Amplitude');
%hold off

%values for low pass filter
L = 253.3*10^(-6);%henry
C = 1*10^(-6);%farad
R = 11.254;%ohms
b = 1/(R*C);
c = 1/(L*C);


y_0 = 0;
y_prime_0 = 0;
y1 = zeros(size(t));
y2 = zeros(size(t));
%x = ones(size(t));

%discretized diff eq for low pass filter
for n = 1:1:length(t)-1
    if n == 1
        y1(1) = y_0;
        y2(1) = y_prime_0;
    end
    y1(n+1) = y1(n) + delta_t*y2(n);
    y2(n+1) = delta_t*(c*x_out(n) - b*y2(n) -c*y1(n))+y2(n);
end
size(y1)

%plot comparing y(t) to x_out
figure(1);
plot(t,x_out,'r')
hold on
plot(t,y1, 'b');
xlabel('Time');
ylabel('Amplitude');
hold off

%used to play sample
%x_audio = downsample(y1,100);
%sound(x_audio,22.05e3);
%sound(downsample(x_out,100),22.05e3);
