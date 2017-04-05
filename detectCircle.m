function [centers4_ok,radii,metric,notfound] = detectCircle(img,radius)
%The function detectes circles and iterates changing by filter values in a
%defined interval. When it finds 4 proper centers, returns them

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
