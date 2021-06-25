%读取图像
leftimg=imread('left.jpg'); 
leftimg_gray=rgb2gray(leftimg); 
points=detectSURFFeatures(leftimg_gray); 
rightimg=imread('right.jpg'); 
rightimg_gray=rgb2gray(rightimg); 
points_right=detectSURFFeatures(leftimg_gray); 
%获取特征点
[features1,valid_points1] = extractFeatures(leftimg_gray,points); 
[features2,valid_points2] = extractFeatures(rightimg_gray,points_right);
%进行匹配
indexPairs = matchFeatures(features1,features2); 
%计算特征点在原图中的位置
matchedPoints1 = valid_points1(indexPairs(:,1),:); 
matchedPoints2 = valid_points2(indexPairs(:,2),:);
%输出
figure 
showMatchedFeatures(leftimg_gray,rightimg_gray,matchedPoints1,matchedPoints2,'montage');