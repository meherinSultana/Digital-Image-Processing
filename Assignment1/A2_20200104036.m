I = imread('input.jpg');
I = rgb2gray(I);
figure;
imshow(I);
title('Input Image');

[rows, cols] = size(I);
mirror_image = zeros(rows, cols, 1 , 'uint8');
for i = 1:rows
    for j = 1:cols
        mirror_image(i, j) = I(i, cols-j+1);
    end
end

figure;
imshow(mirror_image);
title('Mirror Image');

merged_image = cat(2, mirror_image, I);
figure;
imshow(merged_image);
title('Output Image');

imwrite(merged_image, 'output.jpg');