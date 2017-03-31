function centers = detectCircle(img, isShowCircle)
  
  	%img=imread('imgs/rot_3.png');
	img_org = img;
    
	filter=fspecial('average',4);   %Create a filter
	img=imfilter(img,filter);  %Apply filter on binary image
	
	%Brightness adjustment should be automated.
	img = imadjust(img,[0.0; 0.60],[0.0; 1.0]);% Increase brightness
% 	figure,	imshow(img), title('Bright Image');
	
	img=im2bw(img); %Convert to Binary
	img=imcomplement(img); %Inverse image
% 	figure, imshow(img), title('Image Complement');
	
	se=strel('disk',4);
	img=imerode(img,ones(1));%3
% 	figure, imshow(img), title('Eroded Image');
	
	% http://uk.mathworks.com/help/images/ref/imfindcircles.html
	radius=[15,45];
	[centers,radii,metric]=imfindcircles(img,radius);
    if isShowCircle
        if length(centers)>=4
            centersStrong5 = centers(1:4,:);
            radiiStrong5 = radii(1:4);
            metricStrong5 = metric(1:4);

            figure, imshow(img), viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');
            title('Found Circles On Image');
        end
    end
end