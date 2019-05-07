clear;

R = load('ph.mat');
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

rec = zeros(imgsize);
frames = zeros(imgsize,imgsize,length(theta));
for angle = theta+1
    for i = 1:p
        if R(i,angle) ~= 0
            r = i-p/2;
            for x = -imgsize/2+1:imgsize/2-1
                for y = -imgsize/2+1:imgsize/2-1
                    if floor(x*n_vector(angle,1)+y*n_vector(angle,2) - r) == 0
                        rec(-y+imgsize/2,x+imgsize/2) = rec(-y+imgsize/2,x+imgsize/2) + R(i,angle);
                    end
                end
            end
        end
    end
    frames(:,:,angle) = (rec-min(rec(:)))/(max(rec(:))-min(rec(:)));
end
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