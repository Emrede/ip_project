function [imgR,warpInfo] = correctRotation(img,img_org,centers)



% [centers,radii,metric,notfound] = detectCircle(img,[5,15]); 

%Find center coordinates of the circles in the image by using detectCircle function

%Oriantate the image


%The coordinates of top left and bottom right corner of the pattern is
%defined previously to compare given 2 points (top left and bottom
%right) by using Non Reflective Similarity property and warp the image
%according to these points.

%The first indexed circle was assumed to be placed into the top left corner
fixedPoints  = [16 16; 16 426; 426 16; 426 426; ];
% fixedPoints  = [426 16;  426 426; 16 426; 16 16];
movingPoints = centers;%(Idx(1),:);centers(Idx(4),:)];

tform = fitgeotrans(movingPoints,fixedPoints,'projective');
unregistered = img_org;
[imgR,warpInfo]=imwarp(unregistered,tform);

figure, imshow(imgR), title('Warped Image');
end