function [avggratio, allgratios] = IndvGratioVer2(filename) 
    close all;
    clc;
    I = imread(filename);
    I = imcrop(I);
    figure; imshow(I);
    %% Nuclei
    lab = rgb2lab(I);
    ab = lab(:,:,2:3);
    ab = im2single(ab);
    pixel_labels = imsegkmeans(ab,3,'NumAttempts',10);
    figure; imshow(pixel_labels,[]);

    %% 

    nuclei_id = input('Enter number for nuclei (black: 1, gray: 2, white: 3)');
    myelin_id = input('Enter number for myelin (black: 1, gray: 2, white: 3)');
    %dark = input('Is this a dark image?');

    %Segment nuclei
    mask_nuclei = pixel_labels==nuclei_id; %Nuclei
    nuclei = I .* uint8(mask_nuclei);
    %figure; imshow(nuclei); title('Segmented nuclei');

    %Change nuclei color (for later processing)
    redChannel = nuclei(:, :, 1);
    greenChannel = nuclei(:, :, 2);
    blueChannel = nuclei(:, :, 3);

    nonBlackPixels = redChannel >= 100 & greenChannel  == 0;

    targetColor = determineColor(I);

    redChannel(nonBlackPixels) = targetColor(1);
    greenChannel(nonBlackPixels) = targetColor(2);
    blueChannel(nonBlackPixels) = targetColor(3);

    %120 0 220
    % if dark == 0
    %     redChannel(nonBlackPixels) = 120;
    %     greenChannel(nonBlackPixels) = 0;
    %     blueChannel(nonBlackPixels) = 220;
    % else
    %     redChannel(nonBlackPixels) = 48;
    %     greenChannel(nonBlackPixels) = 0;
    %     blueChannel(nonBlackPixels) = 88;
    % end

    I_nuclei = cat(3, redChannel, greenChannel, blueChannel);
    figure; imshow(I_nuclei);
    nuclei_bw = imbinarize(rgb2gray(I_nuclei));

    %Calculate area
    nuclei_bw_filtered = bwareafilt(nuclei_bw,[200 max(cell2mat(struct2cell(regionprops(nuclei_bw,'Area'))))]);
    figure; imshow(nuclei_bw_filtered); title('Nuclei');
    %hold on;
    inner_centroid = struct2cell(regionprops(nuclei_bw_filtered,'centroid'));
    inner_area = struct2cell(regionprops(nuclei_bw_filtered,'area'));
    %imshow(nuclei)
    %% Myelin
    % Find myelin
    mask_myelin = pixel_labels==myelin_id; %Myelin
    myelin = I .* uint8(mask_myelin);
    redChannel = myelin(:, :, 1);
    greenChannel = myelin(:, :, 2);
    blueChannel = myelin(:, :, 3);

    targetColor = colorCalculator(I);

    nonBlackPixels = redChannel <= 255 & redChannel >= determineThreshhold(I) & greenChannel  == 0;


    redChannel(nonBlackPixels) = targetColor(1);
    greenChannel(nonBlackPixels) = targetColor(2);
    blueChannel(nonBlackPixels) = targetColor(3);

    I_temp = cat(3, redChannel, greenChannel, blueChannel);
    %imshow(I_temp);

    I_myelin = I_nuclei + I_temp;
    gs = rgb2gray(I_myelin);
    %gmag = imgradient(gs);
    %figure; imshow(gmag,[])
    %title('Gradient Magnitude')
    se = strel('disk',5);
    Io = imopen(gs,se);
    %imshow(Io);
    %title('Opening')
    Ie = imerode(gs,se);
    Iobr = imreconstruct(Ie,gs);
    %imshow(Iobr);
    %title('Opening-by-Reconstruction');
    Ioc = imclose(Io,se);
    %imshow(Ioc)
    %title('Opening-Closing')
    Iobrd = imdilate(Iobr,se);
    Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr));
    Iobrcbr = imcomplement(Iobrcbr);
    %imshow(Iobrcbr)
    %title('Opening-Closing by Reconstruction')
    myelin_bw = imregionalmax(Iobrcbr);
    %figure; imshow(myelin_bw); title('myelin');

    %Calculate area
    myelin_bw_filtered = bwareafilt(myelin_bw,[250 max(cell2mat(struct2cell(regionprops(myelin_bw,'Area'))))]);
    myelin_bw_filtered = imfill(myelin_bw_filtered,'holes');
    figure; imshow(myelin_bw_filtered); title('Myelin');
    myelin_centroid = struct2cell(regionprops(myelin_bw_filtered,'centroid'));
    myelin_area = struct2cell(regionprops(myelin_bw_filtered,'area'));
    %% 
    g_ratio = zeros(1,length(inner_centroid));
    count_r = 1;
    thresh = 20;
    imshow(I);
    hold on;
    for ii = 1:length(inner_centroid)
        count_temp = 1;
        point = inner_centroid{ii};
        temp = zeros(1,length(myelin_centroid));
        for iii = 1:length(myelin_centroid)
            point2 = myelin_centroid{iii};
            temp(count_temp) = Distance(point2,point);
            count_temp = count_temp + 1; 
        end
        [min_val, ind] = min(temp);
        if (min_val < thresh)
            current_inner_area = inner_area{ii};
            current_myelin_area = myelin_area{ind};
            if (current_inner_area/current_myelin_area <= 0.22)
                current_myelin_area = current_myelin_area/1.5;
            end
            r = gratio(current_inner_area,current_myelin_area);
            if (r >= 0 && r <= 0.95)
                g_ratio(count_r) = r;
                count_r = count_r + 1;
                drawpoint('Position',point);
            end
        end
    end  
    g_ratio_final = g_ratio(g_ratio >= 0.1);
    figure; histogram(g_ratio_final,'NumBins',8);
    title(strcat('n= ', num2str(length(g_ratio_final))));
    avggratio = mean(g_ratio_final);
    allgratios = g_ratio_final;
end