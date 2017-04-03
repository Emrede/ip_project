
function result = colourMatrix(img)
    img = imread(img); %Read the input image file
    img_org = img; %Backup original image
    img = imgFilter(img); %Filter the image
    centers = detectCircle(img, 1); %Find the circles
    orientation = findOrientation(img,centers); %Orientation
    
    switch orientation
        %case 0 %Cancelled
            %Orientation is original
            %imgR = img;
            
        case 1
            %Orientation is rotated
            imgR = correctRotation(img);

        case 2
            %Orientation is projective
            orthophoto = 'refGrid.png';
            unregistered = img;
            %Select circles - Oriantate the image
            [imgPoints refPoints] = cpselect(unregistered, orthophoto,'Wait', true);
            mytform = fitgeotrans(imgPoints,refPoints, 'projective');
            imgR=imwarp(unregistered,mytform);
            figure
            imshow(imgR),title('Projective Corrected')

    end
    %Crop the image
    newCenters = detectCircle(imgR,0);
    newCenters = sort(newCenters);
    imgCropped = imcrop(imgR, [newCenters(1,:) 422 422]);
    figure, imshow(imgCropped), title('Cropped Image');
    
    %Find the colours
    result = findColours(imgCropped); %Return a 4x4x3 colour matrix as result
end