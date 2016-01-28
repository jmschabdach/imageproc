function [ modImage ] = yeungMintzer( image, watermark, key )
% yeungMintzer Embeds a Yeung-Mintzer watermark
%
%   Inputs: image - image to be watermarked
%           watermark - binary watermark with the same dimensions as the
%           image
%           key - key used to generate the lookup table
%   Outputs: returns the modified image

% seed the lookup table
rng(key)
% generate the look up table values
LUTValues = rand(1,256) > .5;

[L W] = size(image);
% image = double(image);


for i=1:L
    for j=1:W
        if(LUTValues(image(i,j)+1) ~= watermark(i,j))
            pix1 = image(i,j);
            pix2 = image(i,j);
            while(LUTValues(pix1+1)~=watermark(i,j))
                pix1 = pix1 + 1;
                if(pix1 >=256)
                    pix1 = -300;
                    break;
                end
            end
            while(LUTValues(pix2+1)~=watermark(i,j))
                pix2 = pix2 - 1;
                if(pix2 <= 0)
                    pix2 = 500;
                    break;
                end
            end
            if(abs(pix1-image(i,j)) < abs(pix2-image(i,j)))
                modImage(i,j) = pix1;
            else
                modImage(i,j) = pix2;
            end
        else
            modImage(i,j) = image(i,j);
        end
    end
end

modImage = uint8(modImage);

end

