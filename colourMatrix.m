function result=colourMatrix(filename)

img = imread(filename); %proj_2, proj_5, proj1_2, proj1_4,
img_org = img; % proj2_3, proj2_4, proj2_5
radius = [5,15];
[centers,radii,metric,notfound] = detectCircle(img,radius);

%If previous values couldn't find the circles change the radius and search again.
% if ~isempty(centers) && length(centers(:,2))~=4
%     radius = [3,15];
%     [centers,radii,metric,notfound] = detectCircle(img,radius);
% end

if notfound==1 %check if the centers were found
    disp('Not enough centers were found')
else %If the centers found go on and detect the bars and warp the image.
    centersStrong5 = centers(1:length(centers(:,2)),:);
    radiiStrong5 = radii(1:length(centers(:,2)));
    metricStrong5 = metric(1:length(centers(:,2)));
    
    %Shows the found circles
    figure, imshow(img), viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');
    title('Identified circles on the image');
    
    cDistances = pdist2(centers,centers,'euclidean'); %Finds distances between the centers
    orientation = findOrientation(cDistances);
    
    bars = findBars(img_org, orientation);
    bar1 = bars(1).Centroid; %is a struct, it contains a Centroid field.
    bar2 = bars(2).Centroid;
    bars = [bar1; bar2];
    
    %Distances between the middle point coordinates of the two bars and the circles
    midBars = [(bar1(1)+bar2(1))/2, (bar1(2)+bar2(2))/2];
    %Returns distances sorted, smallest first.
    [cbarsDist, I] = pdist2(centers,midBars,'euclidean','Smallest',4);
    
    for i=1:4
        sortedCenters(i,:) = centers(I(i),:);
    end
    
    [imgW,warpInfo]=correctRotation(img,img_org,sortedCenters);
%     figure, imshow(imgW)
    %%Cropping process%%
    xmin = abs(warpInfo.XWorldLimits(1));
    ymin = abs(warpInfo.YWorldLimits(1));
    rect = [xmin, ymin, 440, 440]; %Crop rectangle
    imgC = imcrop(imgW, rect);  %Crop the given image
    figure, imshow(imgC), title('Cropped image');
    %%Cropping process%%
    result = findColours(imgC) %Return the RGB colour matrix.
end
end