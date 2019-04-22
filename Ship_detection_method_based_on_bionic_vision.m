clc;clear;close all;
addpath('./Gabor Matlab/');
Gaborsetting;
imageName = 'E:\datum\视觉实现船只检测\船只图\1.jpg';
img = imread(imageName);
imgI = max(img,[],3);%最大值点
ipt.dat = img;
imgGabor = Create_GaborF(ipt,par); %Gabor变换
imgG = imgGabor.gdat;
    


