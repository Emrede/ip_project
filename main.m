close all
clear
clc

img = imread('imgs/rot_2.png');
img_org = img;
radius = [5,15];
[centers,radii,metric,notfound] = detectCircle(img,radius);

if ~isempty(centers) && length(centers(:,2))~=4 %If previous values couldn't find the circles
    radius = [3,15]; %Change the radius and search again.
    [centers,radii,metric,notfound] = detectCircle(img,radius);
end

if notfound==1 %check if the centers were found
    disp('Not enough centers were found')
else
    %Show the found circles
    centersStrong5 = centers(1:length(centers(:,2)),:);
    radiiStrong5 = radii(1:length(centers(:,2)));
    metricStrong5 = metric(1:length(centers(:,2)));
    
    figure, imshow(img), viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');
    title('Circles identified on the image.');
end

bars = findBars(img_org);
bar1 = bars(1).Centroid; %is a struct, so it contains a Centroid field.
bar2 = bars(2).Centroid;
bars = [bar1; bar2];

midBars = [(bar1(1)+bar2(1))/2, (bar1(2)+bar2(2))/2];

% cbarDistances = pdist2(centers,bars,'euclidean');
% [C,I] = sort(cbarDistances(2));

%Distances between the middle point coordinates of the two bars and the circles
[cbar1Dist, I] = pdist2(centers,midBars,'euclidean','Smallest',4);

%The first element of I is the index of closest circle to the bar1
%Then the found circle coordinates must be sorted regarding the index values
% [dist1,I] = sort(cbar1Dist);

% if isequal(I1,I2) %If one bar is enough go sort
%     for i=1:4
%         sortedCenters(i,:) = centers(I1(i),:);
%     end
% else %if not, find the middle point of the bars


for i=1:4
    sortedCenters(i,:) = centers(I(i),:);
end


% [D,I] = pdist2(centers,bars,'euclidean','Smallest',4)

%Validating the circle indexes by comparing the distances between bar2 (thin)
% [dist2,I] = sort(cbar1Dist);

imgR=correctRotation(img,img_org,sortedCenters);
imshow(imgR)