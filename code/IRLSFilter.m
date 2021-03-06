I = imread('D:\MATLAB PROJECTS\data\sample_data.jpg');
%imshow(I);
imageSize = size(I);
refImage = rgb2gray(I);
imageRows = imageSize(1);
imageCols = imageSize(2);
F = 10; % number of FRAMES %
M = 0.00; dM = 0.01;   %once make it constant & incresase V from 0.00 to 0.1%
V = 0.00; dV = 0.001;
N = imageRows + imageCols;

%adding noise
grayImage = imnoise(refImage,'gaussian',M,V);

%{ 
    Creating multiple gray image with different amount of noise 
    to produce F Frames 
%}
grayImageFrames = uint8(zeros(F,imageRows, imageCols));

inititalMeanImage = (zeros(imageRows, imageCols));
for index=1:F
    
    %adding noise
    grayImage = imnoise(refImage,'gaussian',M,V);
    inititalMeanImage = inititalMeanImage + double(grayImage);
    M= M + dM;
    V= V + dV;
    grayImageFrames(index,1:imageRows,1:imageCols) = grayImage;
end

inititalMeanImage = inititalMeanImage./F;
inititalMeanImage = uint8(inititalMeanImage);

for index=1:F
    %plotting original gray image with padding
    grayImage = squeeze(grayImageFrames(index,:,:));
    subplot(3,4,index)
    imshow(grayImage)
    title(['Image Frame ',num2str(index),' '])
    %title('Image Frame %d', index)
end

%plot Initial Mean Image
subplot(3,4,index+1)
imshow(inititalMeanImage)
title('Initial Mean Image ')

%calculate PSNR
[peaksnr, snr] = psnr(inititalMeanImage, refImage);
fprintf('\nThe Peak-SNR value of Initial Mean Image: %0.4f', peaksnr);

%calculate SSIM
[ssimval,ssimmap] = ssim(inititalMeanImage, refImage);
fprintf('\nSSIM Value of Initial Mean Image: %f', ssimval);

saveas(gcf,'D:\MATLAB PROJECTS\output\IRLSF-result.png')

iMeanImage = inititalMeanImage;
yIFrames = uint8(zeros(F,imageRows, imageCols));
taoN = (ones(1,N));
bFHelper = (inv((taoN.')*taoN))*(taoN.');

for index=1:F
    %extract original gray image frame
    If = squeeze(grayImageFrames(index,:,:));
    yI =  If - iMeanImage;
    yIFrames(index,1:imageRows,1:imageCols) = yI;
    Bf = bFHelper*yI;
end

