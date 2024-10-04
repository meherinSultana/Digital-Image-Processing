input = imread('cameraman.png');

[pixelCounts, grayLevels] = imhist(input);

totalNumPixels = numel(input);
probabilityDistribution = pixelCounts / totalNumPixels;

cumulativeDistribution = cumsum(probabilityDistribution);

numGrayLevels = 256;
scaledCDF = (numGrayLevels - 1) * cumulativeDistribution;

roundedCDF = round(scaledCDF);

equalizedImage = roundedCDF(double(input) + 1);
equalizedImage = uint8(equalizedImage);

figure;
subplot(2, 2, 1);
imshow(input);
title('Original Image');

subplot(2, 2, 2);
imshow(equalizedImage);
title('Equalized Image');

subplot(2, 2, 3);
imhist(input);
title('Original Histogram');

subplot(2, 2, 4);
imhist(equalizedImage);
title('Equalized Histogram');

imwrite(uint8(equalizedImage), 'equalized_image.png');
