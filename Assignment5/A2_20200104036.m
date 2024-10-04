a = imread('Image1.jpg');
figure, imshow(a, []), title('Fig a: Input');

if size(a, 3) == 3
    a = rgb2gray(a);
end

laplacian_mask = [0 -1 0; -1 4 -1; 0 -1 0];
b = manual_filter(double(a), laplacian_mask);
figure, imshow(b, []), title('Fig b: Laplacian Filtered');

c = double(a) + b; 
figure, imshow(c, []), title('Fig c: Laplacian Enhanced');

sobel_mask_x = [-1 0 1; -2 0 2; -1 0 1];
sobel_mask_y = [-1 -2 -1; 0 0 0; 1 2 1];
sobel_x = manual_filter(double(a), sobel_mask_x);
sobel_y = manual_filter(double(a), sobel_mask_y);
d = abs(sobel_x) + abs(sobel_y);
figure, imshow(d, []), title('Fig d: Sobel Filtered');

avg_mask = ones(5, 5) / 25;
e = manual_filter(d, avg_mask);
figure, imshow(e, []), title('Fig e: Average Filtered');

f = c .* e;
figure, imshow(f, []), title('Fig f: Product of c and e');

g = double(a) + f;
figure, imshow(g, []), title('Fig g: Addition of a and f');

h = 1 * (double(a) .^ 0.5);
figure, imshow(h, []), title('Fig h: Power Law Transformation');

figure;
%figure('Units', 'normalized', 'OuterPosition', [0, 0, 1, 1]);
subplot(2, 4, 1), imshow(a, []), title('Fig a: Input');
subplot(2, 4, 2), imshow(b, []), title('Fig b: Laplacian Filtered');
subplot(2, 4, 3), imshow(c, []), title('Fig c: Laplacian Enhanced');
subplot(2, 4, 4), imshow(d, []), title('Fig d: Sobel Filtered');
subplot(2, 4, 5), imshow(e, []), title('Fig e: Average Filtered');
subplot(2, 4, 6), imshow(f, []), title('Fig f: Product of c and e');
subplot(2, 4, 7), imshow(g, []), title('Fig g: Addition of a and f');
subplot(2, 4, 8), imshow(h, []), title('Fig h: Power Law Transformation');

saveas(gcf, 'subplot_figure.jpg');

function output = manual_filter(image, mask)
    [rows, cols] = size(image);
    kernel_size = size(mask, 1);
    half_size = (kernel_size - 1) / 2;
    output = zeros(rows, cols);
    
    padded_img = zeros(rows + 2 * half_size, cols + 2 * half_size);
    padded_img(half_size+1:end-half_size, half_size+1:end-half_size) = image;

    for i = 1:rows
        for j = 1:cols
            region = padded_img(i:i+kernel_size-1, j:j+kernel_size-1);
            output(i, j) = sum(sum(region .* mask));
        end
    end
end
