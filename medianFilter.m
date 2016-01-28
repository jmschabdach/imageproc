function [ image ] = medianFilter( image, N )
% medianFilter Median filter using the Laplacian
%   This function sharpens the image using a Laplacian median filter
%   Inputs: 
%       image - image to be filtered
%       N - window size
%
%   Output:
%       newImage - median filtered image

[L, W] = size(image);
image = zeros(size(image));


for j = ceil(N/2):L-ceil(N/2)
    for k = ceil(N/2):W-ceil(N/2)
        A = image(j-floor(N/2):j+floor(N/2),...
            k-floor(N/2):k+floor(N/2));
        A = sort(A);
        image(j,k) = A( ceil(N/2),ceil(N/2) );
    end
end

newImage = image;

end

