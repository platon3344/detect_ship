clc;clear;close all;
addpath('./Gabor Matlab/');
Gaborsetting;
imageName = 'E:\datum\�Ӿ�ʵ�ִ�ֻ���\��ֻͼ\1.jpg';
img = imread(imageName);
imgI = max(img,[],3);%���ֵ��
ipt.dat = img;
imgGabor = Create_GaborF(ipt,par); %Gabor�任
imgG = imgGabor.gdat;
    


