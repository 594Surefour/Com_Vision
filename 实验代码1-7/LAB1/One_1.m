leftimg=imread('left.jpg'); 
leftimg_gray=rgb2gray(leftimg); 
points=detectSURFFeatures(leftimg_gray);
imshow(leftimg_gray); hold on;
plot(points);