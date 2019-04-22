% ���㷨��˼·��
% 1����ͨ�����ε�db5��С���ֽ⣬ÿ��ȡ�ĵ�Ƶϵ����Ȼ��ͨ��fft�仯ȡ����λ���ԣ�����ifft�仯���õ���λͼ��
% 2��ͨ��robert���ӻ���sobel���ӣ���ȡͼ��ı�Ե��Ϣ��
% 3����Ȩ�ϳ������õ�����ͼ��
clc;clear;close all;
% Read image from file
filePath='./img/5001.jpg';

tic;
inImg = im2double(rgb2gray(imread(filePath)));
rioW = 1:620;
inImg = inImg(rioW,:);
imgh=size(inImg,1);
imgw=size(inImg,2);
figure;imshow(inImg);

%%inImg = imresize(inImg, 64/size(inImg, 2));
% wavelet 
dbN = 'db5';
[ca1,ch1,cv1,cd1] = dwt2(inImg,dbN);
% imshow(ca1,[]);
[ca2,ch1,cv1,cd1] = dwt2(ca1,dbN);
[ca3,ch1,cv1,cd1] = dwt2(ca2,dbN);
% imshow(ca3,[])


%%
% Spectral Residual
myFFT = fft2(ca3);
myLogAmplitude = log(abs(myFFT));
myPhase = angle(myFFT);
% mySpectralResidual = myLogAmplitude - imfilter(myLogAmplitude, fspecial('average', 3), 'replicate');
mySpectralResidual = 1;
saliencyMap = abs(ifft2(exp(mySpectralResidual + i*myPhase))).^2;
figure;imshow(saliencyMap);

% img=saliencyMap;
% img=img/max(img(:));
% lamda=10;
% threshold =lamda* sum(img(:))/(imgh*imgw/64);
% saliencyMap=im2bw(img,threshold);
% figure;imshow(saliencyMap);title('binary');

% After Effect
% saliencyMap = mat2gray(imfilter(saliencyMap, fspecial('gaussian', [12, 12], 0.8)));
% % figure;imshow(saliencyMap);
% saliencyMap = medfilt2(saliencyMap);
% % figure;imshow(saliencyMap);


%% sobel
% img = inImg;
% 
% w=fspecial('gaussian',[5 5]);
% img=imfilter(img,w,'replicate');
% 
% w=fspecial('prewitt');
% img_w=imfilter(img,w,'replicate');      %����Ե
% w=w';
% img_h=imfilter(img,w,'replicate');      %������Ե
% imgSobel=sqrt(img_w.^2+img_h.^2);        %ע�����ﲻ�Ǽ򵥵���ƽ��������ƽ�����ڿ������������ó�һ��ʱ�䶼�����
% figure;
% subplot(121);imshow(imgSobel);


%% robert 
img = ca3;
w = [1 0 ; 0 -1];
img_w = imfilter(img,w,'replicate');
w= [0 1 ; -1 0 ];
img_h=imfilter(img,w,'replicate');
imgRoberts = sqrt(img_w.^2+img_h.^2);
figure;imshow(imgRoberts);title('robert');

%% �ϳ�
alpha=0.9;
% img = alpha*saliencyMap + (1-alpha)*imgSobel;
img = alpha*saliencyMap + (1-alpha)*imgRoberts;
% se = strel('disk',1);
% img=imerode(img,se);
% se = strel('disk',10);
% img = imdilate(img,se);
% figure;imshow(img);title('compose img');

imgZeros1  = zeros(size(img,1),size(img,2));
recon1 = idwt2(img,imgZeros1,imgZeros1,imgZeros1,dbN);
imgZeros2  = zeros(size(recon1,1),size(recon1,2));
recon2 = idwt2(recon1,imgZeros2,imgZeros2,imgZeros2,dbN);
imgZeros3  = zeros(size(recon2,1),size(recon2,2));
recon3 = idwt2(recon2,imgZeros3,imgZeros3,imgZeros3,dbN);


img = recon3;
img=img/max(img(:));
lamda=5;
threshold =lamda* sum(img(:))/(imgh*imgw);
img=im2bw(img,threshold);

figure;imshow(img);
ImgOut = img;

toc;