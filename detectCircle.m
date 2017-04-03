function [centers,radii,metric,centers4_ok] = detectCircle(img,radius)
    img = imread(img); %Read the input image file
    img_org = img; %Backup original image
    figure, imshow(img)

    for hsize = 1:3
        for a = 6:10
            for r=6:10
                flag=0;
                img = imgFilter(img_org,hsize,r,a); %Filter the image
                [centers,radii,metric]=imfindcircles(img,radius,'ObjectPolarity','bright'); %Find the circles
                if (~isempty(centers) && length(centers(:,2))==4)
                    centers_4 = centers;
                    D = pdist2(centers_4,centers_4); %Distances between the centers.
                    for i=1:numel(D)
                       if D(i) < 80 && D(i) ~= 0 %rot_3 gg fix it.
                           flag = 1;
                           break
                       end
                    end
                else
                    continue
                end
                if flag==1
                    continue
                end
                
                centers4_ok = centers;

                centersStrong5 = centers(1:length(centers(:,2)),:);
                radiiStrong5 = radii(1:length(centers(:,2)));
                metricStrong5 = metric(1:length(centers(:,2)));

                figure, imshow(img), viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');
                title('Found Circles On Image');
        
                break;                
            end
        end
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






