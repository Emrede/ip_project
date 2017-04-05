function bars = findBars(img)

img = imgFilter(img,11,5,5);


se=strel('disk',3);
img=imerode(img,se);
% img = bwareaopen(img, 10); % Get rid of small blobs.
img=imdilate(img,se);
figure, imshow(img);
title('budur');

% [centers,radii,metric]=imfindcircles(img,[5 15],'ObjectPolarity','bright','Sensitivity',0.82);
CC = bwconncomp(img); %Take the connected components of binary image

ecc = regionprops(img, 'Eccentricity'); %Eccentricity values of all found objects in the image
centroids = regionprops(CC,'Centroid'); %Centroids of all found objects in the image

figure, imshow(img), title('Eroded Image')
bars=[]; %Centroid coordinates of detected bars

for i=1:numel(ecc)
    if ecc(i).Eccentricity>=0.9143 %Higher eccentricty values means a narrower rectangle
        bars = [bars, centroids(i)]; % The centroids of the bars
    end
end
end