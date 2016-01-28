function [ wmk_hat, sim ] = sswExtract( wmkedImg, originalImg,N, alpha, key )
%SSWEXTRACT Extracts a spread-spectrum embedded watermark
%   Algorithm steps
%   1. Compute the 2D DCT of the image
%   2. Find N largest DCT coefficients (excluding the DC coefficient)
%   3. Extract the watermark from the selected DCT coefficients
%   
%   Inputs:
%       wmkedImg - the watermarked image
%       originalImg - unwatermarked version of the image
%       key - to generate the original watermark
%       N - length of the watermark
%       alpha - embedding strength of the watermark
%
%   Outputs:
%       watermark - the extracted watermark sequence
%       sim - similarity between the extracted watermark and the original
%             watermark

[L, W] = size(wmkedImg);
wmk_hat = zeros(N,1);

% First part of algorithm - DCT
imDCT = dct2(wmkedImg);
origDCT = dct2(originalImg);

% Second part of algorithm - get N largest coeffs
origDCT(1,1) = 0; % eliminate DC component

% imVector = reshape(imDCT, L*W, 1);
[imVector, idxs] = sort(origDCT(:), 'descend');
coeffs = idxs(1:N,1);

% Third part of algorithm - extract the watermark
for k = 1:N
    wmk_hat(k,1) = (imDCT(coeffs(k))/origDCT(coeffs(k)) - 1)/alpha;
end

% Check against the original watermark
rng(key); % seed the lookup table
wmk = randn(N,1); % generate the lookup table values, binary
sim = similarity(wmk, wmk_hat);

end

