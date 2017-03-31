function colours = findColours(img)
    filter=fspecial('average',10);   %Create a filter
	img=imfilter(img,filter);  %Apply filter

    figure, imshow(img), title('Noise Reduction');
    colours = repmat(0, [4 4 3]); %Create a 4x4x3 matrix to store the RGB values
    
    for y=1:4
        for x=1:4
            colours(y,x,:) = impixel(img, (x-1)*100+65, (y-1)*100+65); 
        end
    end
end

