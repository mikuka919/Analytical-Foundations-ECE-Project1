clear all

%define variables
fileID = fopen('problem5.bin','r');
x_in = fread(fileID, 'single');
fclose(fileID);
f = 50*10^3;%frequency
f_samp = 2.205 * 10^(6);%frequency of sample
delta_t = 1/f_samp;


%index variables
index = 0;

%create x vector
for n = 1:1:length(x_in)/2
    x(n) = x_in(n+index)+j*x_in(n+index+1);
    index = index + 1;
end
x = transpose(x);
%%end of part b

%create time vector
endpt = (length(x)-1) * delta_t;%end of time vector
t = [0:delta_t:endpt];
t = transpose(t);

x_3 = exp(-j*2*pi*f*t);%x3 vector

%x_out vectors
x_out = x .* x_3;
x_real = real(x_out);
x_imag = imag(x_out);

x_audio = downsample(x_real,100);
x_audio2 = downsample(x_imag,100);
%sound(x_audio,22.05e3);
sound(x_audio2,22.05e3);


