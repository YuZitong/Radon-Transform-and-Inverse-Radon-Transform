I = imread('Sinogram_Source_-_Two_Squares_Phantom.png');

[r,c] = size(I);
I = zeros(r,c);
I(64,64) = 255;
I = I/255;

% tho
tho = 185;

% theta
theta = 0:1:179;

R = zeros(tho, length(theta));
for i = 1:tho
    parfor j = 1:length(theta)
        R(i,j) = intgrl(I,i,theta(j));
    end
end

function f = intgrl(I,tho,phi)
    [r,c] = size(I);
    f = 0;
    for i = 1:r
        for j = 1:c
            f = f + I(i,j)*Ddirac(tho-i*cos(phi/180*pi)-j*sin(phi/180*pi));
        end
    end
end

function f = Ddirac(x)
% discreted dirac delta fcn
% input: x
% output: 1 if x==0, 0 otherwise
    if abs(x) <= 1/sqrt(2)
        f = 1;
    else
        f = 0;
    end
end