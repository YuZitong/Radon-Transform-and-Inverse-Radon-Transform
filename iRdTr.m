clear;

R = load('RdTr.mat');
R = R.R;
[p,t] = size(R);

imgsize = floor(p/sqrt(2));

if mod(log2(imgsize),1) ~= 0
    imgsize = 2^(nextpow2((imgsize))-1);
end

theta = linspace(0,180,t+1);
theta(end) = [];
n_vector = zeros(length(theta),2);
n_vector(:,1) = cos(theta/180*pi)';
n_vector(:,2) = sin(theta/180*pi)';

[X,Y] = meshgrid(linspace(1,imgsize,imgsize),linspace(1,imgsize,imgsize));

imgmap = zeros(imgsize^2,2);
imgmap(:,1) = X(:);
imgmap(:,2) = Y(:);

t = imgmap*n_vector';
t(t<1) = 1;
t = floor(t);

reconstructed = zeros(imgsize^2,1);
for i = 1:179
    reconstructed = reconstructed + R(t(:,i),i);
end
reshape(reconstructed/2/pi,128,128);
imshow(ans,[])