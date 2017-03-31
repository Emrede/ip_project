function orientation = findOrientation(img)
    %img=imread('imgs/rot_1.png');
    img_org=img;

    figure, imshow(img), title('Original Image');
    centers=detectCircle(img, 1);
    
    if length(centers)==4
        % At first it is another calculation approach is applied to correct
        % the rotated patterns without considering the bars which are placed
        % in the left top corner of the patterns.
        
        % Due to the original and noised files do not need to be processed
        % the code snippet below is cancelled. Now, if there's no 4 different circle
        % center found in the input file, it is assumed as a projective pattern
        % and sent into the case 2.
        
        % Even though some parts of this function was benefited to 
        % correcting rotated images in the correctRotation function.
        
%         dists=[]; %Distances between first found point and the others
%         
%         for i=2:length(centers)
%             dists =[dists, pdist2(centers(1,:), centers(i,:))]; %Distances betweeen first found point and the rest
%         end
%         
%         [sorted_dists,I] = sort(dists); %Sorts the elements of dists in ascending order
%         
%         %http://uk.mathworks.com/help/images/ref/fitgeotrans.html
%         fixedPoints  = [444.5 444.5; 444.5 25.5 ;25.5 25.5; 25.5 444.5];
%         movingPoints = [centers(1,:); centers(I(1)+1,:); centers(I(3)+1,:); centers(I(2)+1,:)];
%         
%         %Note: The orders of this points must be same!
%         tform = fitgeotrans(movingPoints,fixedPoints,'affine');
% 
%         %The center coordinates of minimum distanced circle and its index number
%         u=[centers(1,1) centers(1,2)]; %Center point of the first circle
%         v=[centers(I(1)+1,1) centers(I(1)+1,2)]; %Center point of the neighbour circle to the first one
%         
%         %Calculation of the angle between axis-x and an edge of the pattern
%         dx = u(2) - u(1);
%         dy = v(2) - v(1);
%         angle = (180/pi) * atan2(dy, dx)
% 
%         angleMod = mod(angle, 90);  %Take mod 90 of the angle to distinguish
%         angleMod = abs(angleMod);   %if it is perpendicular or parallel to the axis-x
%         
%         if angleMod<=5 && angleMod>=0 || angleMod<=90 && angleMod>=85 %If angle is approximately -90
%             orientation=0; %Orientation is original
%             fprintf('Orientation is original')
%         else
            orientation=1; %Orientation is rotated
%             fprintf('Orientation is rotated')
%         end

    else
        fprintf('Not enough center points are found.');
        orientation=2; %Orientation is projective
    end
end