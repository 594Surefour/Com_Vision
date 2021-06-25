% 读取视频 
videoReader=VideoReader('car.mov','CurrentTime',0.4); 
%建 立 光 流 计 算 对 象， 
opticFlow=opticalFlowLK('NoiseThreshold',0.009);
%建立窗体
h=figure;
movegui(h);
hViewPanel=uipanel(h,'Position',[0 0 1 1],'Title','光 流 计 算'); 
hPlot=axes(hViewPanel);
%逐帧进行计算
while hasFrame(videoReader)
    frameRGB=readFrame(videoReader); %读 取 一 帧 
    frameGray=rgb2gray(frameRGB); %将 其 转 换 为 灰 度 图 
    flow=estimateFlow(opticFlow,frameGray);%进 行 光 流 计 算 
    imshow(frameRGB)
    hold on
    plot(flow,'DecimationFactor',[5 5],'ScaleFactor',35,'Parent',hPlot); 
    hold off
    pause(10^-3) 
end