%% Radon Transform version 3
clear
close all;

%% image and projection initial settings

% import image (suppose is a square)
I = im2double(imread('./source_images/128Phantom.png'));
% I = phantom(128);
ROI = 100; % size of region of interest (mm)
img_x_n = size(I,2);
img_y_n = size(I,1);
pixel_size = ROI/img_x_n; % pixel size
% rescale to physical units (mm)
img_x = -floor(img_x_n/2)*pixel_size+(1- (-1)^(img_x_n+1))/2*pixel_size/2:pixel_size:floor(img_x_n/2)*pixel_size-(1- (-1)^(img_x_n+1))/2*pixel_size/2;
img_y = -floor(img_y_n/2)*pixel_size+(1- (-1)^(img_y_n+1))/2*pixel_size/2:pixel_size:floor(img_y_n/2)*pixel_size-(1- (-1)^(img_y_n+1))/2*pixel_size/2;

% projection settings
nrays = 512; % number of rays for each view
L = 300; % length of x-ray sensor (mm)
interval_size = L/nrays; % interval size between rays
nviews = 128; % number of views
views = linspace(0,180-180/nviews,nviews)/180*pi; % views (radian)
% list of tho on the x-ray sensor
tho = -interval_size/2-(nrays/2-1)*interval_size:interval_size:interval_size/2+(nrays/2-1)*interval_size;

%% projection
R = zeros(nrays,nviews); % inital projection
for phi_index = 1:length(views) % for each angle
    phi = views(phi_index);
    
    sin_phi = sin(phi);
    cos_phi = cos(phi);
    n_vector = [cos_phi;sin_phi]; % normal vector of rays
    
    % tho = [x,y]*n_vector 
    %     = [x,y]*[cos_phi,sin_phi]'
    %     = x*cos_phi + y*sin_phi
    % Since the image is discreted,
    % split one pixel into four subpixels to improve accuracy
    img_subx = sort([img_x-pixel_size/2,img_x]);
    img_suby = sort([img_y-pixel_size/2,img_y]);
    [X,Y] = meshgrid(img_subx,-img_suby);
    tho_map = X.*cos_phi +Y.*sin_phi;
    
    for i = 1:2*img_y_n
        for j = 1:2*img_x_n
            x = ceil(j/2); % index for the original image
            y = ceil(i/2);
            if I(y,x) ~= 0
                [d,in] = min(abs(tho_map(i,j)-tho)); % find projection positions on x-ray sensor
                if d > interval_size
                    continue; % in case of x-ray sensor is too small
                end
                % proportionally split to nearest two projection bins
                R(in,phi_index) = R(in,phi_index) + (interval_size-d)/interval_size*I(y,x)/4;
                if tho_map(i,j)-tho(in) > 0 && in < length(tho)
                    R(in+1,phi_index) = R(in+1,phi_index) + d/interval_size*I(y,x)/4;
                elseif in > 1
                    R(in-1,phi_index) = R(in-1,phi_index) + d/interval_size*I(y,x)/4;
                end
            end
        end
    end
end

%% plot out results

subplot(1,2,1)
imshow(R,[]);title('RdTr3.m')
axis on;
xlabel(['projections / ',num2str(180/nviews),'˚']);

subplot(1,2,2)
Matlab_R = radon(I,views/pi*180);
imshow(Matlab_R,[]);title('Matlab build-in function')
axis on;
xlabel(['projections / ',num2str(180/nviews),'˚']);