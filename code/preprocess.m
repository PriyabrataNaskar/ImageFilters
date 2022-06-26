function [refImage,grayImage,oldImageSize] = preprocess()

I = imread('D:\MATLAB PROJECTS\data\sample_data.jpg');
%imshow(I);
size(I);
refImage = rgb2gray(I);
oldImageSize = size(refImage);

M = 0.1;  %once make it constant & incresase V from 0.01 to 0.1%
V = 0.00;  

%adding noise
grayImage = imnoise(refImage,'speckle');

end