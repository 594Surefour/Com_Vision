%读入图片
image1=imread('left.jpg'); 
image2=imread('right.jpg'); 
%将图片转换为灰度图 
gray1=rgb2gray(image1); 
gray2=rgb2gray(image2); 
imageSize=size(gray1); 
%特征检测
p1=detectSURFFeatures(gray1); 
p2=detectSURFFeatures(gray2); 
%导出特征描述子与特征点 
[img1Features,p1]=extractFeatures(gray1,p1); 
[img2Features,p2]=extractFeatures(gray2,p2);
%进行特征匹配
boxPairs = matchFeatures(img1Features, img2Features);
matchedimg1Points=p1(boxPairs(:,1)); 
matchedimg2Points=p2(boxPairs(:,2)); 
%使用随机样本一致性(RANSAC)算法的变体MSAC算法去除误匹配点 
[tform,inlierimg2Points,inlierimg1Points]=estimateGeometricTransform(matchedimg2Points,matchedimg1Points,'projective');
%进行直接拼接
Rfixed=imref2d(size(image1)); 
[registered2,Rregistered]=imwarp(image2,tform); 
imshowpair(image1,Rfixed,registered2,Rregistered,'blend');
