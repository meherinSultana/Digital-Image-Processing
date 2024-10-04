I = imread('input.jpg');
I = rgb2gray(I);


[row, col] = size(I);
R = uint8(zeros(row, col));

A = Inf;
B = -Inf;

for i = 1:row
    for j = 1:col
        if I(i, j) < A
            A = I(i, j);
        end
        if I(i, j) > B
            B = I(i, j);
        end
    end
end

D = B - A;
M = 255;

for i = 1:row
    for j = 1:col
        R(i, j) = uint8((double(I(i, j)) - A) / D * M + A);
    end
end

figure;
subplot(1, 2, 1);
imshow(I);
title('Input Image');

subplot(1, 2, 2);
imshow(R);
title('Output Image');