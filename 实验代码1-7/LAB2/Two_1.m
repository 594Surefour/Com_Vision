img=imread('origina.png');
img_gray=rgb2gray(img); 
BW = imbinarize(img_gray,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);
figure;
imshow(BW);
title('Binary Version of Image');


area=bwarea(BW); 
euler=bweuler(BW); 
conn=bwconncomp(BW);