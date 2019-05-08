clear;

R = load('./RdTr_results/ph.mat');
R = R.R;
[p,t] = size(R);
fftR = fft(R);
H = triang(p);
fftR = bsxfun(@times, fftR, H);
R = ifft(fftR,'symmetric');


imgsize = floor(p/sqrt(2));

if mod(log2(imgsize),1) ~= 0
    imgsize = 2^(nextpow2((imgsize))-1);
end

theta = linspace(0,180-180/t,t);
n_vector = zeros(length(theta),2);
n_vector(:,1) = cos(theta/180*pi)';
n_vector(:,2) = sin(theta/180*pi)';

rec = zeros(imgsize);
frames = zeros(imgsize,imgsize,length(theta));
for ag = 1:length(theta)
    for i = 1:p
        if R(i,ag) ~= 0
            r = i-p/2;
            for x = -imgsize/2+1:imgsize/2-1
                for y = -imgsize/2+1:imgsize/2-1
                    if round(x*n_vector(ag,1)+y*n_vector(ag,2) - floor(r)) == 0
                        rec(-y+imgsize/2,x+imgsize/2) = rec(-y+imgsize/2,x+imgsize/2) + R(i,ag);
                    end
                end
            end
        end
    end
    frames(:,:,ag) = (rec-min(rec(:)))/(max(rec(:))-min(rec(:)));
end
% rec1 = (rec-sum(R(:,1)))/(p-1);
figure;
imshow(rec,[])
save_3D_matrix_as_gif('rec.gif',frames)

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