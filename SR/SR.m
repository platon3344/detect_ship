function [ImgOut,saliencyMap,imgRoberts] = SR(imgSrc)
%% Read image from file
% filePath='E:\datum\视觉实现船只检测\船只图\3.jpg';
% inImg = im2double(rgb2gray(imread(filePath)));
inImg = imgSrc;
imgh=size(inImg,1);
imgw=size(inImg,2);
% imshow(inImg);

%%inImg = imresize(inImg, 64/size(inImg, 2));

%% Spectral Residual
myFFT = fft2(inImg);
myLogAmplitude = log(abs(myFFT));
myPhase = angle(myFFT);
% mySpectralResidual = myLogAmplitude - imfilter(myLogAmplitude, fspecial('average', 3), 'replicate');
mySpectralResidual = 1;
saliencyMap = abs(ifft2(exp(mySpectralResidual + i*myPhase))).^2;
img=saliencyMap;
img=img/max(img(:));
lamda=7;
threshold =lamda* sum(img(:))/(imgh*imgw);
saliencyMap=im2bw(img,threshold);

% After Effect
saliencyMap = mat2gray(imfilter(saliencyMap, fspecial('gaussian', [12, 12], 0.8)));
saliencyMap = medfilt2(saliencyMap);
% imshow(saliencyMap);
% figure;
% hist(saliencyMap);


%% sobel
% img = inImg;
% 
% w=fspecial('gaussian',[5 5]);
% img=imfilter(img,w,'replicate');
% 
% w=fspecial('prewitt');
% img_w=imfilter(img,w,'replicate');      %求横边缘
% w=w';
% img_h=imfilter(img,w,'replicate');      %求竖边缘
% imgSobel=sqrt(img_w.^2+img_h.^2);        %注意这里不是简单的求平均，而是平方和在开方。我曾经好长一段时间都搞错了
% figure;
% subplot(121);imshow(imgSobel);


%% robert 
img = inImg;
w = [1 0 ; 0 -1];
img_w = imfilter(img,w,'replicate');
w= [0 1 ; -1 0 ];
img_h=imfilter(img,w,'replicate');
imgRoberts = sqrt(img_w.^2+img_h.^2);
% figure;
% imshow(imgRoberts);

%% 合成
alpha=0.9;
% img = alpha*saliencyMap + (1-alpha)*imgSobel;
img = alpha*saliencyMap + (1-alpha)*imgRoberts;
% %% 形态学
% se = strel('disk',1);
% img=imerode(img,se);
% se = strel('disk',10);
% img = imdilate(img,se);
% %% 分割
% img=img/max(img(:));
% lamda=3.5;
% threshold =lamda* sum(img(:))/(imgh*imgw);
% img=im2bw(img,threshold);
% % imshow(img);
ImgOut = img;
end
