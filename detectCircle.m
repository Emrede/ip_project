function [centers,radii,metric] = detectCircle(img)
  %%%%%FILTER%%%%%%
  	%img=imread('imgs/rot_3.png');
% 	img_org = img;
%     
% 	filter=fspecial('average',4);   %Create a filter
% 	img=imfilter(img,filter);  %Apply filter on binary image
% 	
% 	%Brightness adjustment should be automated.
% 	img = imadjust(img,[0.0; 0.60],[0.0; 1.0]);% Increase brightness
% % 	figure,	imshow(img), title('Bright Image');
% 	
% 	img=im2bw(img); %Convert to Binary
% 	img=imcomplement(img); %Inverse image
% % 	figure, imshow(img), title('Image Complement');
% 	
% 	se=strel('disk',1);
% 	img=imerode(img,ones(1)); 
% % 	figure, imshow(img), title('Eroded Image');
% 	%%%%%FILTER%%%%%%

	% http://uk.mathworks.com/help/images/ref/imfindcircles.html
    
% 	radius=[5,15];%For Org images
    radius=[5,15];
	[centers,radii,metric]=imfindcircles(img,radius,'ObjectPolarity','bright');
    %If 4 centroids wasn't found, increase the search radius.
%     if(length(centers)<4)
% %         se=strel('disk',1);
% %         img=imdilate(img,se); 
%         radius=[16,30];
%         [centers2,radii2,metric2]=imfindcircles(img,radius);
% % %         centers = centers + centers2;
%     end
    %SHOW THE CENTERS ON THE IMAGE%
%     if isShowCircle
    %Show circles if 4 centers found
%     if (~isempty(centers) && length(centers(:,2))==4)%~isempty(centers)
%         centersStrong5 = centers(1:length(centers(:,2)),:);
%         radiiStrong5 = radii(1:length(centers(:,2)));
%         metricStrong5 = metric(1:length(centers(:,2)));
% 
%         figure, imshow(img), viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');
%         title('Found Circles On Image');
% %         end
%     end
end