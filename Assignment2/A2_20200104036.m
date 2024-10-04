I = imread('input1.JPEG');
mx = max(I(:));
L = 2^(floor(log2(double(mx)))+1);

figure();
subplot(1,2,1); 
imshow(I);
title('Input Image');

[row, col] = size(I);

I = im2double(I);
A = min(I(:));
B = max(I(:));
D = B - A;
M = L - 1;
R = I - A;
R = R ./ D;
R = R .* M;
R = R + A;
R = uint8(R);

subplot(1,2,2); 
imshow(R);
title('Output Image');

imwrite(R, 'output.jpg');
