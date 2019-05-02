clear;
close all;

I = imread('Sinogram_Source_-_Two_Squares_Phantom.png');

% I = phantom(128);

[r,c] = size(I);

xOrigin = floor(r/2);
yOrigin = floor(c/2);

theta = 0:1:179;

pFirst = floor(sqrt((r-xOrigin)^2+(c-yOrigin)^2))+1;
rSize  = 2*pFirst+1;

R = zeros(rSize, length(theta));

for ag = theta
    numAngle = ag/180*pi;
    SinA     = sin(numAngle);
    CosA     = cos(numAngle);
    
    xcos = zeros(2*c,1);
    ysin = zeros(2*r,1);
    
    for i = 1:r
        y = yOrigin - i;
        ysin(2*i)   = (y+0.25)*SinA;
        ysin(2*i-1) = (y-0.25)*SinA;
    end
    for j=1:c
        x = j - xOrigin;
        xcos(2*j)   = (x+0.25)*CosA;
        xcos(2*j-1) = (x-0.25)*CosA;
    end

    for j = 1:c % columns - x
        for i = 1:r % rows - y
            if I(i,j) ~= 0
                p = double(I(i,j))*0.25;
                tho = xcos(2*j)+ysin(2*i)+pFirst; R = contribute(R,tho,ag,p);
                tho = xcos(2*j-1)+ysin(2*i)+pFirst; R = contribute(R,tho,ag,p);
                tho = xcos(2*j)+ysin(2*i-1)+pFirst; R = contribute(R,tho,ag,p);
                tho = xcos(2*j-1)+ysin(2*i-1)+pFirst; R = contribute(R,tho,ag,p);
            end
        end
    end
end

imshow(R,[])

function R = contribute(R, tho, ag, p)
    if tho >0
        Rr = floor(tho);
    else
        Rr = floor(tho)-1;
    end
    delta = tho - Rr;
    R(Rr+1,ag+1) = R(Rr+1,ag+1) + p*(1-delta);
    R(Rr+2,ag+1) = R(Rr+2,ag+1) + p*delta;
end