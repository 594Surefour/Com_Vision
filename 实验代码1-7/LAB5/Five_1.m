%创 建 探 测 对 象， 类 型 为 脸 部 探 测 
faceDetector=vision.CascadeObjectDetector(); 
%读取视频文件 
videoFileReader=VideoReader('person.mov'); 
%逐帧读取 
videoFrame=readFrame(videoFileReader); 
%使用探测对象进行探测
box=step(faceDetector,videoFrame);
%在探测到的面部周围绘制矩形 
videoOut=insertObjectAnnotation(videoFrame,'rectangle',box,'Face'); 
%将RGB色 彩 空 间 转 换 为HSV色 彩 空 间， 以 便 读 取 肤 色 作 为 目 标 跟 踪 的 特 征 
[hueChannel,~,~] = rgb2hsv(videoFrame);
%对 鼻 子 进 行 检 测， 供 后 续 初 始 化 直 方 图 
noseDetector=vision.CascadeObjectDetector('Nose', 'UseROI', true);
noseBBox=step(noseDetector,videoFrame,box(1,:));
%创建跟踪器
tracker=vision.HistogramBasedTracker;
%初始化直方图 
initializeObject(tracker,hueChannel,noseBBox(1,:));
%创 建 视 频 播 放 器 对 象， 以 便 呈 现 结 果 
videoPlayer=vision.VideoPlayer;
while hasFrame(videoFileReader) 
    %逐帧读取
    videoFrame=readFrame(videoFileReader);
    %RGB空间转换为HSV空间
    [hueChannel,~,~]=rgb2hsv(videoFrame);
    %对面部进行跟踪
    box=step(tracker,hueChannel);
    %在检测到的面部附近插入矩形 
    videoOut=insertObjectAnnotation(videoFrame,'rectangle',box,'Face'); 
    step(videoPlayer,videoOut);
end
%播放结果 
release(videoPlayer);