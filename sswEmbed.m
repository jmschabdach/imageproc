function [ watermarkedImage, watermark ] = sswEmbed( image, key, N, alpha )
%sswEmbed Uses spread spectrum watermarking to embed a watermark in an
%image
%   Algorithm steps
%   1. Compute the 2D DCT of the image
%   2. Find N largest DCT coefficients (excluding the DC coefficient)
%   3. Create the watermark as a sequence of N random numbers from N(0, 1)
%   4. Embed the watermark into the selected DCT coefficients
%   5. Compute the inverse DCT to get the watermarked image
%   
%   Inputs:
%       image - image to be watermarked
%       key - to generate the watermark
%       N - length of the watermark
%       alpha - embedding strength of the watermark
%
%   Outputs:
%       watermarkedImage

[L, W] = size(image);
watermarkedImage = zeros(size(image));

% First part of algorithm - DCT
imDCT = dct2(image);
imDCT2 = imDCT;

% Second part of algorithm - get N largest coeffs
imDCT2(1,1) = 0; % eliminate the DC component when finding the coefficients
[imVector, idxs] = sort(imDCT2(:), 'descend');
coeffs = idxs(1:N);

% Third part of algorithm - create watermark
rng(key) % seed the lookup table
watermark = randn(N,1); % generate the lookup table values, binary

% Fourth part of algorithm - embed the watermark
for k = 1:N
    imDCT(coeffs(k)) = imDCT(coeffs(k)) + alpha*watermark(k,1)*imDCT(coeffs(k));
end

% Fifth part of algorithm - inverse DCT
watermarkedImage = idct2(imDCT);
watermarkedImage = uint8(watermarkedImage);

end

