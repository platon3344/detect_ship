clear;clc;close all;
video = VideoReader('ch01_20171030144528.avi');
startFrame = 182; % 4200, 5000,
data = read(video,Inf);
nFrames = video.NumberOfFrames;
high = video.Height;
width = video.Width;
rate = video.FrameRate;
mov(1:nFrames) = struct('cdata',zeros(high,width,3,'uint8'),'colormap',[]);
%read one frame every time
cutIdx = 620;
%% 
% 1788֡��Ӧ�˻�
%%
for i = startFrame:nFrames
    mov(i).cdata = read(video,i);
    srcImg = mov(i).cdata;
    srcImg = im2double(rgb2gray(srcImg));
    srcImg = srcImg(1:cutIdx,:);
    srcImg = histeq(srcImg);
     disp('��ǰ��֡����'),disp(i);
%      imgFileName = strcat('./img/',num2str(i),'.jpg');
%      imwrite(srcImg,imgFileName);
%      imshow(srcImg);
     subplot(221);imshow(srcImg),title('ԭʼͼƬ');     
     drawnow;
    [outImg,saliencyMap,imgRoberts] = SR(srcImg);
    subplot(222);hist(srcImg); title('�����Լ����㷨');
%     imshow(outImg);
    drawnow;
    subplot(223);imshow(saliencyMap);
    subplot(224);imshow(imgRoberts);
%     subplot(224);hist(outImg);title('���ֱ��ͼ');
end