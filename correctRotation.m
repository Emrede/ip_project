function [imgW,warpInfo] = correctRotation(img,img_org,centers)

%The coordinates of closest circle to the blocks is considered as the first
%circle and  was assumed to be placed into the top left corner

%The other corners follow regularly following the counter clockwise direction
fixedPoints  = [16 16; 16 426; 426 16; 426 426];
movingPoints = centers;

tform = fitgeotrans(movingPoints,fixedPoints,'projective');
unregistered = img_org;
[imgW,warpInfo]=imwarp(unregistered,tform);

figure, imshow(imgW), title('Warped Image');
end