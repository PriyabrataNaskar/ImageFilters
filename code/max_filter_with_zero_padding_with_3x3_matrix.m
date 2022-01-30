[refImage,grayImage,oldImageSize] = preprocess();

%applying padding zero
[newImage,mLength] = zero_padding(oldImageSize, grayImage);

%plotting original gray image with padding
subplot(1,2,1)
imshow(grayImage)
title('Original Image With Noise')

%empty matrix for filtered image
filteredImage = uint8(zeros(oldImageSize(1), oldImageSize(2)));

k=1;l=1;

%max filter
for i=3:oldImageSize(1)+2
    for j=3:oldImageSize(2)+2
        t = [newImage(i-1,j+1),newImage(i,j+1),newImage(i+1,j+1),newImage(i-1,j),newImage(i,j),newImage(i+1,j),newImage(i-1,j-1),newImage(i,j-1),newImage(i+1,j-1)];
        val=max(t);
        
        filteredImage(k,l) = (uint8(val));
        l = l+1;
    end
    l=1;
    k = k+1;
end

[peaksnr, snr] = psnr(filteredImage, refImage);
  
fprintf('\nThe Peak-SNR value is %0.4f', peaksnr);

[ssimval,ssimmap] = ssim(filteredImage, refImage);

fprintf('\nSSIM Value: %f', ssimval)

%plotting the filtered image
subplot(1,2,2)
imshow(filteredImage)
title('Max Filtered Image')
saveas(gcf,'D:\MATLAB PROJECTS\output\max-filter-result.png')