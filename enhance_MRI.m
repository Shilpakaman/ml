clc;
clear all;
close all;

I=imread('resized images/MRI5polymorphous-low-grade-neuroepithelial-tumour-of-the-young_output.jpg');
%I=rgb2gray(Img);
%----uniform background
se=strel('disk',15);
bg=imopen(I,se);
eI=I-bg;
ceI=imadjust(eI);
heI=adapthisteq(ceI,'clipLimit',0.01);

err1=immse(I,eI);
peaksnr1=psnr(eI,I);
%ssimval1=ssim(I,eI);
fprintf('\n mse01, psnr01 values are %0.4f , %0.4f\n', err1,peaksnr1);

err2=immse(heI,ceI);
peaksnr2=psnr(heI,ceI);
%ssimval2=ssim(heI,ceI);
fprintf(' mse02, psnr02 values are %0.4f ,%0.4f\n', err2,peaksnr2);

subplot(2,3,1),imshow(I),title('Original MRI image');
subplot(2,3,2),imshow(bg),title('Background');
subplot(2,3,3),imshow(eI),title('After removing background');
subplot(2,3,4),imshow(ceI),title('Contast adjust');
subplot(2,3,5),imshow(heI),title('Histogram equalization CLAHE');


GN=imnoise(heI,'gaussian');
PN=imnoise(heI,'poisson');
SPN=imnoise(heI,'salt & pepper');
SN=imnoise(heI,'speckle');

imwrite(GN,'D:\Matlab basics\resized images\MGNI.jpg');
imwrite(PN,'D:\Matlab basics\resized images\MPNI.jpg');
imwrite(SPN,'D:\Matlab basics\resized images\MSPNI.jpg');
imwrite(SN,'D:\Matlab basics\resized images\MSNI.jpg');

fprintf('\n Gaussian noise\n');
GF = imgaussfilt(GN);
err01=immse(GN,GF);
peaksnr01=psnr(GN,GF);
fprintf('mse1, psnr1 values are %0.4f ,%0.4f\n', err01,peaksnr01);

MF = medfilt2(GN);
err02=immse(GN,MF);
peaksnr02=psnr(GN,MF);
fprintf('mse2, psnr2 values are %0.4f ,%0.4f\n', err02,peaksnr02);

WF = wiener2(GN);
err03=immse(GN,WF);
peaksnr03=psnr(GN,WF);
fprintf('mse3, psnr3 values are %0.4f ,%0.4f\n', err03,peaksnr03);

BLF = imbilatfilt(GN);
err04=immse(GN,BLF);
peaksnr04=psnr(GN,BLF);
fprintf('mse4, psnr4 values are %0.4f ,%0.4f\n', err04,peaksnr04);

NLMF = imnlmfilt(GN);
err05=immse(GN,NLMF);
peaksnr05=psnr(GN,NLMF);
fprintf('mse5, psnr5 values are %0.4f ,%0.4f\n', err05,peaksnr05);

figure,montage({GN,GF,MF,WF,BLF,NLMF});
title({'Image with gaussain noise, Gaussian Filter, Median Filter,Wiener Filter','Bilateral Filter,NonLocal Means Filter'});

fprintf('\n Poisson noise\n');
GF = imgaussfilt(PN);
err01=immse(PN,GF);
peaksnr01=psnr(PN,GF);
fprintf('mse1, psnr1 values are %0.4f ,%0.4f\n', err01,peaksnr01);

MF = medfilt2(PN);
err02=immse(PN,MF);
peaksnr02=psnr(PN,MF);
fprintf('mse2, psnr2 values are %0.4f ,%0.4f\n', err02,peaksnr02);

WF = wiener2(PN);
err03=immse(PN,WF);
peaksnr03=psnr(PN,WF);
fprintf('mse3, psnr3 values are %0.4f ,%0.4f\n', err03,peaksnr03);

BLF = imbilatfilt(PN);
err04=immse(PN,BLF);
peaksnr04=psnr(PN,BLF);
fprintf('mse4, psnr4 values are %0.4f ,%0.4f\n', err04,peaksnr04);

NLMF = imnlmfilt(PN);
err05=immse(PN,NLMF);
peaksnr05=psnr(PN,NLMF);
fprintf('mse4, psnr4 values are %0.4f ,%0.4f\n', err05,peaksnr05);

figure,montage({PN,GF,MF,WF,BLF,NLMF});
title({'Image with poisson noise, Gaussian Filter, Median Filter,Wiener Filter','Bilateral Filter,NonLocal Means Filter'});

fprintf('\n Salt & Pepper noise\n');
GF = imgaussfilt(SPN);
err01=immse(SPN,GF);
peaksnr01=psnr(SPN,GF);
fprintf('mse1, psnr1 values are %0.4f ,%0.4f\n', err01,peaksnr01);

MF = medfilt2(SPN);
err02=immse(SPN,MF);
peaksnr02=psnr(SPN,MF);
fprintf('mse2, psnr2 values are %0.4f ,%0.4f\n', err02,peaksnr02);

WF = wiener2(SPN);
err03=immse(SPN,WF);
peaksnr03=psnr(SPN,WF);
fprintf('mse3, psnr3 values are %0.4f ,%0.4f\n', err03,peaksnr03);

BLF = imbilatfilt(SPN);
err04=immse(SPN,BLF);
peaksnr04=psnr(SPN,BLF);
fprintf('mse4, psnr4 values are %0.4f ,%0.4f\n', err04,peaksnr04);

NLMF = imnlmfilt(SPN);
err05=immse(SPN,NLMF);
peaksnr05=psnr(SPN,NLMF);
fprintf('mse5, psnr5 values are %0.4f ,%0.4f\n', err05,peaksnr05);

figure,montage({SPN,GF,MF,WF,BLF,NLMF});
title({'Image with salt & pepper noise, Gaussian Filter, Median Filter,Wiener Filter','Bilateral Filter,NonLocal Means Filter'});

fprintf('\n Speckle noise\n');
GF = imgaussfilt(SN);
err01=immse(SN,GF);
peaksnr01=psnr(SN,GF);
fprintf('mse1, psnr1 values are %0.4f ,%0.4f\n', err01,peaksnr01);

MF = medfilt2(SN);
err02=immse(SN,MF);
peaksnr02=psnr(SN,MF);
fprintf('mse2, psnr2 values are %0.4f ,%0.4f\n', err02,peaksnr02);

WF = wiener2(SN);
err03=immse(SN,WF);
peaksnr03=psnr(SN,WF);
fprintf('mse3, psnr3 values are %0.4f ,%0.4f\n', err03,peaksnr03);

BLF = imbilatfilt(SN);
err04=immse(SN,BLF);
peaksnr04=psnr(SN,BLF);
fprintf('mse4, psnr4 values are %0.4f ,%0.4f\n', err04,peaksnr04);

NLMF = imnlmfilt(SN);
err05=immse(SN,NLMF);
peaksnr05=psnr(SN,NLMF);
fprintf('mse5, psnr5 values are %0.4f ,%0.4f\n', err05,peaksnr05);

figure,montage({SN,GF,MF,WF,BLF,NLMF});
title({'Image speckle noise, Gaussian Filter, Median Filter,Wiener Filter','Bilateral Filter,NonLocal Means Filter'});

