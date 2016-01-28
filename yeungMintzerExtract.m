function [ watermark ] = yeungMintzerExtract( image, key )
% yeungMintzerExtract Extracts the watermark embeded in an image
%   The embedded watermark must be embedded using the Yeung-Mintzer method
%   Inputs: image - image watermarked with the Yeung Mintzer method
%           key - used to generate the lookup table
%   Output: watermark extracted from the image

% Seed the lookup table
rng(key);
% Generate lookup table 
LUTValues = rand(1,256) > .5;

[L W] = size(image);
watermark = zeros(L,W);

for i = 1:L
    for j = 1:W
        watermark(i,j) = LUTValues(image(i,j)+1);
    end
end


end

