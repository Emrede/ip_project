function orientation = findOrientation(cDistances)
%Detectes the orientation of the input image. It was divided into 2 case,
%1. Original or noised images
%2. Rotated or proj images

orientation = 1; %Orientation is set org or noise by default
n = numel(cDistances);

for i=1:n
    %If there is a distance among centers smaller than 405, image is 
    %rotated or projection
    if cDistances(i)~=0 && cDistances(i) < 405
        orientation = 2 %Orientation is rotated or projective
    end
end
end