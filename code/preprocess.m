function [refImage,grayImage,oldImageSize] = preprocess()

I = imread('D:\MATLAB PROJECTS\data\sample_data.jpg');
%imshow(I);
size(I);
refImage = rgb2gray(I);
oldImageSize = size(refImage);

%adding noise
grayImage = imnoise(refImage,'gaussian');

end