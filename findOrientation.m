function orientation = findOrientation(img, centers)
%     img=imread('noise_1_.png');
%     figure, imshow(img_org), title('Original Image');



if length(centers)==4
    orientation=1;
else
    fprintf('Not enough center points are found.');
    orientation=2; %Orientation is projective
end
end