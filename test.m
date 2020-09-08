%% 
figure('units','pixel');
I = imread('copy.png');
imshow(I);
pos = ginput(1);
pix_red = I(round(pos(1)),round(pos(2)),1);
pix_green = I(round(pos(1)),round(pos(2)),2);
pix_blue = I(round(pos(1)),round(pos(2)),3);

%% 
I = imread('MAX_BSCPN1_sDPN_distal_fascicle1_smi31+32_mbp_60x.png');
J = imcrop(I);
imshow(J);
%% 
I = imread('copy.png');
gs = rgb2gray(I);
I_contour = imcontour(gs,2);

%% 
I = imread('sfsdfsds.jpg');
colorThresholder(I);
%% 
I = imread('copy.png');
lab_he = rgb2lab(I);
ab = lab_he(:,:,2:3);
ab = im2single(ab);
nColors = 2;
% repeat the clustering 3 times to avoid local minima
pixel_labels = imsegkmeans(ab,nColors,'NumAttempts',3);
figure; imshow(pixel_labels,[])
title('Image Labeled by Cluster Index');
mask1 = pixel_labels==1; %Background
cluster1 = I .* uint8(mask1);
figure; imshow(cluster1)
title('Objects in Cluster 1');
mask2 = pixel_labels==2; %Myelin
cluster2 = I .* uint8(mask2);
figure; imshow(cluster2)
title('Objects in Cluster 2');
mask3 = pixel_labels==3; %Nuclei
cluster3 = I .* uint8(mask3);
figure; imshow(cluster3)
title('Objects in Cluster 3');

%% 
filename = 'JAX45 contra 60x fascicle1.png';
imshow(filename);
%% 

[a, b] = IndvGratioVer2(filename);
