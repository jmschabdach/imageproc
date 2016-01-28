function [ sim ] = similarity( original, extracted )
%similarity Calculate the similarity of two vectors
%   Inputs:
%       original - the original watermark (vector)
%       extracted - the extracted watermark (vector)
%
%   Output:
%       sim - similarity between the two vectors

[Lo, Wo] = size(original);
if (Wo > Lo) 
    original = original'; 
end

[Le, We] = size(extracted);
if (We > Le)
    extracted = extracted';
end

sim = (extracted'*original)/sqrt(sum(extracted.^2));

end

