%% Inverse Radon Transform version 3
close;
clear;
%% initial settings

load('./RdTr_results/RdTr_physical.mat');

nrays = size(R,1);
nviews = size(R,2);
L = 300; % length of x-ray sensor (mm)
interval_size = L/nrays; % interval size between rays
tho = -interval_size/2-(nrays/2-1)*interval_size:interval_size:interval_size/2+(nrays/2-1)*interval_size;

views = linspace(0,180-180/nviews,nviews)/180*pi;

% set the width of fft
width = 2^nextpow2(nrays);

%% Fourier tranform and filter

%fft
R_fft = fft(R, width);

% Ram-lak filter
filter = triang(width);

R_fft_filtered = bsxfun(@times, R_fft, filter);

%% inverse Fourier tranform and back project

% inverse Fourier transform
R_ifft = ifft(R_fft_filtered,'symmetric');

% back project
ROI = L/sqrt(2)-1; % assumed size of the region of interest (mm)
imgsize = ceil(nrays/sqrt(2));
pixel_size = ROI/imgsize; % rescale to physical units (mm)
fbp = zeros(imgsize);
frames = zeros(imgsize,imgsize,nviews);
for phi_index = 1:nviews
    phi = views(phi_index);
    cos_phi = cos(phi);
    sin_phi = sin(phi);
    for x = 1:imgsize
        for y = 1:imgsize
            %tho_p = [x,y]*n_vector 
            %     = [x,y]*[cos_phi,sin_phi]'
            %     = x*cos_phi + y*sin_phi
            % x and y are in physical units (mm)
            tho_p = (x-imgsize/2)*pixel_size*cos_phi + (-y+imgsize/2)*pixel_size*sin_phi;
            [delta,in] = min(abs(tho_p-tho)); % find the nearest projection location on the x-ray sensor
            % two nearest projection bins proportionally contribute to the
            % reconstructed image
            if tho_p > tho(in)
                fbp(y,x)=fbp(y,x)+(interval_size-delta)/interval_size*R_ifft(in,phi_index);
                fbp(y,x)=fbp(y,x)+delta/interval_size*R_ifft(in+1,phi_index);
            else
                fbp(y,x)=fbp(y,x)+(interval_size-delta)/interval_size*R_ifft(in,phi_index);
                fbp(y,x)=fbp(y,x)+delta/interval_size*R_ifft(in-1,phi_index);
            end
        end
    end
    frames(:,:,phi_index) = (fbp-min(fbp(:)))/(max(fbp(:))-min(fbp(:)));
end
fbp = (fbp*pi)/nviews; % rescale the pixel value

%% plot reconstructed image

figure;
I = im2double(imread('./source_images/128Phantom.png'));
subplot(1,2,1)
imshow(fbp)
axis on;
title('reconstructed image');
subplot(1,2,2)
imshow(I)
axis on;
title('original image');

save_3D_matrix_as_gif('rec_physical.gif',frames)

function save_3D_matrix_as_gif(filename, matrix, delaytime)

    if(nargin<2 || nargin>3)
        error('incorrect number of input arguments')
    end
    
    if nargin==2
        delaytime = 0.1;
    end
    
    % adjust range to be between 1 and 256
    matrix = matrix*255 + 1;

    imwrite(squeeze(matrix(:,:,1)),filename,'gif', 'WriteMode','overwrite','DelayTime',delaytime,'LoopCount',Inf);
    for ii = 2:size(matrix,3)
        imwrite(squeeze(matrix(:,:,ii)),filename,'gif', 'WriteMode','append','DelayTime',delaytime);
    end

end