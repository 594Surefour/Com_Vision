clc;clear all;close all;

Img = imread('galaxy.jpg');
%galaxy.jpg
%fin1.bmp

Img = Img(:,:,1);
Img = double(Img);
% Img = 200*ones(100);
% Img(20:80,10:30)= 140;
% Img(20:80,40:70)= 180;
% Img(20:80,80:90)=50;
[row,col] = size(Img);
phi = ones(row,col);
phi(10:row-10,10:col-10) = -1;
u = - phi;
[c, h] = contour(u, [0 0], 'r');
title('Initial contour');
% hold off;

sigma = 1;
G = fspecial('gaussian', 5, sigma);

delt = 1;
Iter = 100;
mu = 25;%this parameter needs to be tuned according to the images

for n = 1:Iter
    [ux, uy] = gradient(u);
   
    c1 = sum(sum(Img.*(u<0)))/(sum(sum(u<0)));% we use the standard Heaviside function which yields similar results to regularized one.
    c2 = sum(sum(Img.*(u>=0)))/(sum(sum(u>=0)));
    
    spf = Img - (c1 + c2)/2;
    spf = spf/(max(abs(spf(:))));
    
    u = u + delt*(mu*spf.*sqrt(ux.^2 + uy.^2));
    
    if mod(n,10)==0
    imagesc(Img,[0 255]); colormap(gray);hold on;
    [c, h] = contour(u, [0 0], 'r');
    iterNum = [num2str(n), 'iterations'];
    title(iterNum);
    pause(0.02);
    end
    u = (u >= 0) - ( u< 0);% the selective step.
    u = conv2(u, G, 'same');
end
imagesc(Img,[0 255]);colormap(gray);hold on;
[c, h] = contour(u, [0 0], 'b');



    
