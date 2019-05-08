clear;

R = load('RdTr.mat');
R = R.R;
[p,t] = size(R);

imgsize = floor(p/sqrt(2));

if mod(log2(imgsize),1) ~= 0
    imgsize = 2^(nextpow2((imgsize))-1);
end

theta = linspace(0,180-180/t,t);

tol = 1e-2;
error = Inf;

img_last = zeros(imgsize);
while error >tol
    for i = 1:length(theta)
        phi = (i-1)*180/length(theta);
        img_last = imrotate(img_last,phi,'bilinear','crop');
        projection = sum(img_last,2);
        error = projection - R(:,i);
    end
end