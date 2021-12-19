I = imread('C:\Users\priya\Downloads\test.png');
%imshow(I);
size(I);
grayImage = rgb2gray(I);

%adding noise
grayImage = imnoise(grayImage,'gaussian');

oldImageSize = size(grayImage);

%applying padding zero
newImage = zeros(oldImageSize(1)+4, oldImageSize(2)+4);
newImage = uint8(newImage);
mLength = size(newImage);
k=1;
l=1;
for i=1:oldImageSize(1)
    for j=1:oldImageSize(2)
        a = grayImage(i,j);
        newImage(i+2,j+2) = a;
        %l = l+1;
    end
    %k = k+1;
end

%plotting original gray image with padding
subplot(1,2,1)
imshow(newImage)
title('Original Image')

%empty matrix for filtered image
filteredImage = uint8(zeros(oldImageSize(1)+4, oldImageSize(2)+4));

%average filter
for i=3:oldImageSize(1)+2
    for j=3:oldImageSize(2)+2
        t = [newImage(i-1,j+1),newImage(i,j+1),newImage(i+1,j+1),newImage(i-1,j),newImage(i,j),newImage(i+1,j),newImage(i-1,j-1),newImage(i,j-1),newImage(i+1,j-1)];
        total = double(0);
        val=double(0);
            for index=1:9
                val = double(t(index));
                total = double(total + val);
            end

        avg=total/9;
        filteredImage(i,j) = (uint8(avg));
        %l = l+1;
    end
    %k = k+1;
end

%plotting the filtered image
subplot(1,2,2)
imshow(filteredImage)
title('Average Filtered Image')
