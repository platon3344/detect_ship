clc;clear;close all;
% Read image from file
filePath='./img/5001.jpg';
tic
inImg = im2double(rgb2gray(imread(filePath)));
rioW = 1:620;
inImg = inImg(rioW,:);
imgh=size(inImg,1);
imgw=size(inImg,2);
% figure;imshow(inImg);

%%
% Spectral Residual
tic
myFFT = fft2(inImg);
myLogAmplitude = log(abs(myFFT));
myPhase = angle(myFFT);
% mySpectralResidual = myLogAmplitude - imfilter(myLogAmplitude, fspecial('average', 3), 'replicate');
mySpectralResidual = 1;
saliencyMap = abs(ifft2(exp(mySpectralResidual + i*myPhase))).^2;
toc;
% figure;imshow(saliencyMap);

% img=saliencyMap;
% img=img/max(img(:));
% lamda=7;
% threshold =lamda* sum(img(:))/(imgh*imgw);
% saliencyMap=im2bw(img,threshold);
% % figure;imshow(saliencyMap);title('binary');
% 
% % After Effect
% saliencyMap = mat2gray(imfilter(saliencyMap, fspecial('gaussian', [12, 12], 0.8)));
% % figure;imshow(saliencyMap);
% saliencyMap = medfilt2(saliencyMap);
% % figure;imshow(saliencyMap);


%% robert 
img = inImg;
w = [1 0 ; 0 -1];
img_w = imfilter(img,w,'replicate');
w= [0 1 ; -1 0 ];
img_h=imfilter(img,w,'replicate');
imgRoberts = sqrt(img_w.^2+img_h.^2);
% figure;imshow(imgRoberts);title('robert');

%% ºÏ³É
alpha=0.9;
% img = alpha*saliencyMap + (1-alpha)*imgSobel;
img = alpha*saliencyMap + (1-alpha)*imgRoberts;
se = strel('disk',1);
img=imerode(img,se);
se = strel('disk',10);
img = imdilate(img,se);
toc
% figure;imshow(img);title('compose img');

img=img/max(img(:));
lamda=5;
threshold =lamda* sum(img(:))/(imgh*imgw);
img=im2bw(img,threshold);

% figure;imshow(img);
ImgOut = img;

toc;