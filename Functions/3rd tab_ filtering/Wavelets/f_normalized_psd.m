function [freq,power] = f_normalized_psd(y,T_s)

F_s=1/T_s; %Sampling frequency

L=length(y); %Length of data

Y=fft(y); %FFT of signal
power=sqrt(real(Y).^2 + imag(Y).^2); %Amplitude of Fourier transform
power=2*power./L;

freq=(0:F_s/L:F_s-F_s/L);

semilogy(freq(1:end/2),power(1:end/2))

end