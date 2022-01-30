function [newImage,mLength] = zero_padding(oldImageSize, grayImage)
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
end