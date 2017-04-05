function bars = findBars(img, orientation)
%After finding circles, according to that knowledge (coordinates of the
%circle centers) the function is used to detect two bars by checking the
%eccentricty values of objects in a binary image

%To do that it is needed to apply different power of filter and different
%hsize valued erosion and dilation to the image. Hence, According to the
%orientation images are considered in the 2 case.

if orientation ==1 %If orientation org or noised set these
    img = imgFilter(img,11,5,5);
    se=strel('disk',4);
else %otherweise set these
    img = imgFilter(img,2,5,5);
    se=strel('disk',3);
end

img=imerode(img,se);
% img = bwareaopen(img, 10); % Get rid of small blobs.
img=imdilate(img,se);
figure, imshow(img), title('Eroded Image')

% [centers,radii,metric]=imfindcircles(img,[5 15],'ObjectPolarity','bright','Sensitivity',0.82);
CC = bwconncomp(img); %Get the connected components of binary image

ecc = regionprops(img, 'Eccentricity'); %Eccentricity values of all found objects in the image
centroids = regionprops(CC,'Centroid'); %Centroids of all found objects in the image

bars=[]; %Centroid coordinates of detected bars

for i=1:numel(ecc)
    if ecc(i).Eccentricity>=0.9143 %Higher eccentricty values means a narrower rectangle
        bars = [bars, centroids(i)]; % The centroids of the bars
    end
end
end