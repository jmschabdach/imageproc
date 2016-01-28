function [plane] = extractPlane(image, planeLevel)
% extractPlane extracts a particular bit plane from the image and returns it 
% Input: image - the image whose plane is being extracted
%        planeLevel - the bit plane level to be extracted
% Output: plane - the extracted plane

image = double(image);
plane = mod(floor(image/(2^planeLevel)),2);

end