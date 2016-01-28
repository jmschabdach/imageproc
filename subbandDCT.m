function h = subbandDCT( image, row, column )
%SUBBANDDCT Examine the DCT coefficient histogram to determine if
%the image has been JPEG compression
%   
%   Inputs: 
%    image - image whose histogram will be examined
%    row - row of the subband to be examined
%    col - column of the subband to be examined
%
%   Output:
%    displays the histogram of the subband's DCT coefficients
%

[Length Width] = size(image);

blockSizeR = 8; % Rows in block.
blockSizeC = 8; % Columns in block.

% Figure out the size of each block (in rows as a unit). Most will be 
% blockSizeR but there may be a remainder with fewer than that.
wholeBlockRows = floor(Length / blockSizeR);
blockVectorR = [blockSizeR * ones(1, wholeBlockRows),...
    rem(Length, blockSizeR)];

% Figure out the size of each block in columns.
wholeBlockCols = floor(Width / blockSizeC);
blockVectorC = [blockSizeC * ones(1, wholeBlockCols),...
    rem(Width, blockSizeC)];

% Create the cell array, ca. Each cell (except for the remainder cells at
% the end of the image) in the array contains a blockSizeR by blockSizeC by
% 3 color array. This line is where the image is actually divided up into
% blocks.

blocks = mat2cell(image, blockVectorR, blockVectorC);
% DCT of each block
[Lblocks Wblocks] = size(blocks);
index = 1;
for i=1:Lblocks-1
    for j = 1:Wblocks-1
        % index
        DCTblocks{index} = dct2(blocks{i,j});
        index = index +1;
    end
end
% take specified row & column and store in vector blocks
for i = 1:length(DCTblocks)
    vector(i) = DCTblocks{1,i}(row,column);
end

% hist histogram of DCT vector
h = histogram(vector,'BinWidth',1);
imageName = inputname(1);
title(['(' num2str(row) ',' num2str(column) ...
    ') DCT Subband Histogram of ' imageName]);
end
