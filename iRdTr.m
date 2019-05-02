clear;

R = load('RdTr.mat');
R = R.R;
[p,theta] = size(R);

fftR = fft(R);

order = 2^nextpow2(2*p);
H = ones(1, order);

fftR(length(H),1)=0;

filtfftR = fftR.*H';

ifftR = ifft(filtfftR);

ifftR(p+1:end,:) = [];