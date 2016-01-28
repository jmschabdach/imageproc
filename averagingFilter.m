function [ newImage ] = averagingFilter( image, N )
% averagingFilter Averaging filter using the Laplacian
%   This function sharpens the image using a Laplacian filter
%
%   Inputs: 
%       image - image to be filtered
%       N - window size
%
%   Outputs:
%       newImage - averaging filtered image

window = ones(N,N);
[L, W] = size(image);
g = ones(L, W);
g = image;


for x = 1+ceil(N/2):L-ceil(N/2)
    for y = ceil(N/2):W-ceil(N/2)
        window = image(x-floor(N/2):x+floor(N/2),...
            y-floor(N/2):y+floor(N/2));
        g(x,y) = mean( mean(window) );
    end
end

new_image = g;
% new_image = uint8(new_image);
end

