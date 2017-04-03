close all
clear
clc

img = 'imgs/rot_3.png';
radius = [5,15];
[centers4_ok] = detectCircle(img,radius);

if ~isempty(centers4_ok) %|| length(centers4_ok(:,2))~=4
    radius = [3,15];
    [centers4_ok] = detectCircle(img,radius);
end