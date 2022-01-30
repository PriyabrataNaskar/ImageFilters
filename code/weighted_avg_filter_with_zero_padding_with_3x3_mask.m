[refImage,grayImage,oldImageSize] = preprocess();

%applying padding zero
[newImage,mLength] = zero_padding(oldImageSize, grayImage);

%plotting original gray image with padding
subplot(1,2,1)
imshow(grayImage)
title('Original Image With Noise')

%empty matrix for filtered image
filteredImage = uint8(zeros(oldImageSize(1), oldImageSize(2)));

%average filter
k=1;l=1;
for i=3:oldImageSize(1)+2
    for j=3:oldImageSize(2)+2
        t = [newImage(i-1,j+1),2*newImage(i,j+1),newImage(i+1,j+1),2*newImage(i-1,j),4*newImage(i,j),2*newImage(i+1,j),newImage(i-1,j-1),2*newImage(i,j-1),newImage(i+1,j-1)];
        total = double(0);
        val=double(0);
            for index=1:9
                val = double(t(index));
                total = double(total + val);
            end

        avg=total/16;
        filteredImage(k,l) = (uint8(avg));
        l = l+1;
    end
    l=1;
    k = k+1;
end

[peaksnr, snr] = psnr(filteredImage, refImage);
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);

%plotting the filtered image
subplot(1,2,2)
imshow(filteredImage)
title('Weighted Average Filtered Image')

saveas(gcf,'D:\MATLAB PROJECTS\output\avg-filter-result.png')