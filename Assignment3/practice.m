img = imread('cameraman.png');
sigma = input('Enter the value of sigma: ');

id = 36;
remainder = mod(id, 4);

if remainder == 0
    kernel_size = 3;
elseif remainder == 1
    kernel_size = 5;
elseif remainder == 2
    kernel_size = 7;
elseif remainder == 3
    kernel_size = 11;
end

half_size = (kernel_size - 1) / 2;
[x, y] = meshgrid(-half_size:half_size, -half_size:half_size);
kernel = exp(-(x.^2 + y.^2) / (2 * sigma^2));
kernel = kernel / sum(kernel(:));

% Fix kernel centering and Boundary Handling
padded_img = padarray(img, [half_size, half_size], 'replicate', 'both');
filtered_img = zeros(size(img));

% Apply the Gaussian filter
[rows, cols] = size(img);
for i = 1:rows
    for j = 1:cols
        % Extract the region centered around (i, j)
        region = double(padded_img(i:i+2*half_size, j:j+2*half_size)); 
        filtered_img(i, j) = sum(sum(region .* kernel));
    end
end

figure;
subplot(1, 2, 1), imshow(img), title('Original Image');
subplot(1, 2, 2), imshow(uint8(filtered_img)), title('Filtered Image');

imwrite(uint8(filtered_img), 'filtered_image.png');
