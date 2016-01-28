function [ new_image ] = gammacorrection( image, gamma )
% gammacorrection Corrects the gamma value of the given image
%   Inputs: an image that has already been read in
%           a gamma value for gamma correction, gamma > 0
%   This function uses the mapping 
%           y = 255*(image/255)^gamma
%   to determine the modified pixel values. 

y = 255.*(image./255).^gamma;
new_image = uint8(y);
end

