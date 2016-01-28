function [ K ] = blockingDetection( image )
%blockingDetection Detects blocking elements present in an image from JPEG
%compression
%   This function implements Fan and de Quieroz's JPEG blocking artifact
%   detection algorithm. It returns the strength of the blocking
%   fingerprints
%   
%   Input: image - the image to be checked for blocking artifacts
%   Output: K - the strength of the blocking artifacts

% Part 1: Calculate Z' and Z''
% Divide the image into 8x8 blocks
[L, W] = size(image);
blocksL = L/8;
blocksW = W/8;
numBlocks = (blocksL-1)*(blocksW-1);
Zp = zeros(blocksL, blocksW);
Zpp = zeros(blocksL, blocksW);
for i = 1:blocksL-1
    for j = 1:blocksW-1
        A = double(image((i-1)*8+4, (j-1)*8+4));
        B = double(image((i-1)*8+4, (j-1)*8+5));
        C = double(image((i-1)*8+5, (j-1)*8+4));
        D = double(image((i-1)*8+5, (j-1)*8+5));
        E = double(image(i*8, j*8));
        F = double(image(i*8, j*8+1));
        G = double(image(i*8+1, j*8));
        H = double(image(i*8+1, j*8+1));
        Zp(i,j) = abs(A-B-C+D);
        Zpp(i,j) = abs(E-F-G+H);
    end
end

% Part 2: Calculate the normalized histogram
Hi = hist(Zp(:), 0:50);
Hi = Hi/numBlocks;
Hii = hist(Zpp(:), 0:50);
Hii = Hii/numBlocks;

figure
plot(Hi);
hold on
plot(Hii, 'r');
title('Histogram');
legend('H_I', 'H_{II}');

% Part 3: Measure K
K = sum(sum(abs(Hi-Hii)));

end