function [centers4_ok,radii,metric,notfound] = detectCircle(img,radius)
% img = imread(img); %Read the input image file
img_org = img; %Backup original image
figure, imshow(img)
notfound=0;
centers4_ok=[];

for hsize = 1:3%1:3 %Average filter hsize 1-2
    for a = 6:10%7:10 %Sharpen amount 6-10
        for r=6:10 %Sharpen radius 6-10
            flag=0;
            img = imgFilter(img_org,hsize,r,a); %Filter the image
            %Find the circles to check if they were found correct
            [centers,radii,metric]=imfindcircles(img,radius,'ObjectPolarity','bright');
            if (~isempty(centers) && length(centers(:,2))==4) %If 4 centers found
                centers_4 = centers; %Save it into the centers_4
                D = pdist2(centers_4,centers_4); %And check distances between the centers.
                for i=1:numel(D) %Iterate each distance values.
                    if D(i) < 170 && D(i) ~= 0
                        flag = 1; %If the distance between two centers smaller than
                        break       %170 and equal to 0 go to the next iteration
                    end
                end
            else %If not enough centers detected go to next iteration
                continue
            end
            if flag==1
                continue
            end
            centers4_ok = centers_4;
            %img show code line
            break;
        end
    end
    
end
if isempty (centers4_ok)
    notfound = 1; %If centers weren't found set notfound to the 1
end
end

%%%%%colourMatrix%%%%%%
%orientation = findOrientation(img,centers); %Orientation

%     switch orientation
%         %case 0 %Cancelled
%             %Orientation is original
%             %imgR = img;
%
%         case 1
%             %Orientation is rotated
%             imgR = correctRotation(img);
%
% %         case 2
% %             %Orientation is projective
% %             orthophoto = 'refGrid.png';
% %             unregistered = img;
% %             %Select circles - Oriantate the image
% %             [imgPoints refPoints] = cpselect(unregistered, orthophoto,'Wait', true);
% %             mytform = fitgeotrans(imgPoints,refPoints, 'projective');
% %             imgR=imwarp(unregistered,mytform);
% %             figure
% %             imshow(imgR),title('Projective Corrected')
%
%     end
%Crop the image
%     newCenters = detectCircle(imgR,0);
%     newCenters = sort(newCenters);
%     imgCropped = imcrop(imgR, [newCenters(1,:) 422 422]);
%     figure, imshow(imgCropped), title('Cropped Image');

%Find the colours
%     result = findColours(imgCropped); %Return a 4x4x3 colour matrix as result






