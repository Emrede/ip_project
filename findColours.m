function colours = findColours(img)
%Returns the RGB colors values of predefined coordinates on an image
filter=fspecial('average',10);   %For the colour detection create a
%strong filter to reduce noise fluctuation between the pixels for a
%more accurate colour result
img=imfilter(img,filter);  %Apply filter

figure, imshow(img), title('Output image for returning the RGB values');
colours = repmat(0, [4 4 3]); %Create a 4x4x3 matrix to store the RGB values

for y=1:4
    for x=1:4
        colours(y,x,:) = impixel(img, (x-1)*100+70, (y-1)*100+70);
    end
end
end

