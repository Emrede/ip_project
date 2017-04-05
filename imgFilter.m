function img = imgFilter(img,hsize,r,a)
%This function filters the image with a average filter and also sharpens,
%converts it to the binary and gets it complement than erode. Basically, it
%prepares the image for the circle detection process and it takes four
%inputs.

%     filter = fspecial('gaussian',15);   %Reduce noise
%     img = imfilter(img,filter);
filter = fspecial('average',hsize);
img = imfilter(img,filter);

%     img = imsharpen(img,'Radius',5,'Amount',6); %Rot3: 5-6
img = imsharpen(img,'Radius',r,'Amount',a);

%     img = imadjust(img,[0.0; 0.60],[0.0; 1.0]);

img=im2bw(img,0.1);
%     img = bwareaopen(img, 1000); % Get rid of small blobs.
img=imcomplement(img);


se=strel('disk',1);
img=imerode(img,se);
%     figure, imshow(img), title('First filter');
%      se=strel('disk',2);
%     img=imdilate(img,se);
%     imshow(img)
end

