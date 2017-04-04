function img = imgFilter(img,hsize,r,a)
%     img = imread('imgs/org.png');fdsafs

%      figure, imshow(img)

%     filter = fspecial('gaussian',15);   %Reduce noise
%     img = imfilter(img,filter);
filter = fspecial('average',hsize); %Rot3: 2
img = imfilter(img,filter);

%     img = imsharpen(img,'Radius',5,'Amount',6); %Rot3: 5-6
img = imsharpen(img,'Radius',r,'Amount',a);

%     figure
%     imshow(img)

%     img = imadjust(img,[0.0; 0.60],[0.0; 1.0]);
%     figure
%     imshow(img)

img=im2bw(img,0.1);
%     img = bwareaopen(img, 1000); % Get rid of small blobs.
img=imcomplement(img);
%     figure
%     imshow(img)

se=strel('disk',1);
img=imerode(img,se);
%     figure, imshow(img)

%      se=strel('disk',2);
%     img=imdilate(img,se);
%     imshow(img)
end

