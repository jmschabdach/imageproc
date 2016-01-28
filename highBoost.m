function [ new_image ] = highBoost( image, alpha )
% highBoost High-boost filter using the Laplacian
%   Inputs: image
%           alpha value
%   This function sharpens the image using a Laplacian filter

A = [0 -0.25 0; -0.25 1 -0.25; 0 -0.25 0];
[L, W] = size(image);
g = ones(L-2, W-2);

for j = 2:L-1
    for k = 2:W-1
        g(j-1:j+1, k-1:k+1) = image(j-1:j+1, k-1:k+1)*A;
    end
end

new_image = image+alpha*g;
new_image = uint8(new_image);
end

