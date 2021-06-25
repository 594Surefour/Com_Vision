%读取图像
img1 = imread('5.png');
%创 建 一 组Gabor滤 波 器， 覆 盖6个 波 长 和4个 方 向。
wavelength = 2.^(0:5) * 3;
orientation = 0:45:135;
g = gabor(wavelength,orientation);
%将图像转换为灰度
img1gray = rgb2gray(im2single(img1)); 
%使用Gabor滤波器对灰度图像进行滤波
gabormag = imgaborfilt(img1gray,g); 
%对每个滤波后的图像进行平滑处理以消除局部变化
for i = 1:length(g)
sigma = 0.5*g(i).Wavelength;
gabormag(:,:,i) = imgaussfilt(gabormag(:,:,i),3*sigma); 
end
%获 取 输 入 图 像 中 所 有 像 素 的x和y坐 标。
nrows = size(img1,1);
ncols = size(img1,2);
[x,y] = meshgrid(1:ncols,1:nrows);
%串 联 有 关 每 个 像 素 的 强 度 信 息、 邻 域 纹 理 信 息 和 空 间 信 息 
featureSet = cat(3,img1gray,gabormag,x,y); 
%使用k均值聚类基于补充特征集将图像分割成5个区域
l2 = imsegkmeans(featureSet,5);
output = labeloverlay(img1,l2); 
imshow(output); 
imwrite(output,'output.png');