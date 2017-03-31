function imgR = correctRotation(img)

    %img=imread('imgs/rot_2.png');
    BW=im2bw(img); %Convert image into binary
    BW = imcomplement(BW); %Take its complement 
    se=strel('disk',11); %Define a structure for the filter
    BW = imerode(BW,se); %Erode the image
    
    CC = bwconncomp(BW); %Take the connected components of binary image

    s = regionprops(BW, 'Eccentricity'); %Eccentricity values of all found objects in the image
    centroids = regionprops(CC,'Centroid'); %Centroids of all found objects in the image
    
    figure, imshow(BW), title('Eroded Image')
    ctr_rectangels=[]; %Centroid coordinates of detected rectangles
    
    for i=1:numel(s)
        if s(i).Eccentricity>=0.93 %Higher eccentricty values means a narrower rectangle
            ctr_rectangels = [ctr_rectangels, centroids(i)]; % The coordinates of rectangle centroids
        end
    end
    
    centers = detectCircle(img,0); %Find center coordinates of the circles in the image by using detectCircle function
    
    dists=[]; %Distances between first centroid and the others
    for i=1:length(centers)
        dists = [dists, pdist2(centers(i,:), ctr_rectangels(1).Centroid)];
        %ctr_rectangle is a struct, so it contains a Centroid field.
    end
    
    %The first element of Idx is the index of closest circle centroid to the first rectangular
    %Then the first Idx should be placed into the top left corner
    [sDists,Idx] = sort(dists); 

    %Oriantate the image
    centers=detectCircle(img, 0);
    dists=[]; %Distances between first point and the others
    for i=2:length(centers)
        dists =[dists, pdist2(centers(1,:), centers(i,:))]; %Distances betweeen first found point and the rest
    end

    [sorted_dists,I] = sort(dists); %Sorts the elements of dists in ascending order

    %The coordinates of top left and bottom right corner of the pattern is
    %defined previously to compare given 2 points (top left and bottom
    %right) by using Non Reflective Similarity property and warp the image
    %according to these points.
    
    fixedPoints  = [25.5 25.5; 444.5 444.5];
    movingPoints = [centers(Idx(1),:);centers(Idx(4),:)];
    
    tform = fitgeotrans(movingPoints,fixedPoints,'nonreflectivesimilarity')
    unregistered = img;
    imgR=imwarp(unregistered,tform);
    
    figure, imshow(imgR), title('Warped Image');
end