clc; clear all; close all;

data = load('Features.mat');

%Extracting the xy feature points for each images.
I00 = data.Features(1).xy;
I01 = data.Features(2).xy;
I02 = data.Features(3).xy;
I03 = data.Features(4).xy;

Image_00 = imread("00.png");
Image_01 = imread("01.png");
Image_02 = imread("02.png");
Image_03 = imread("03.png");
%%
%--------------------- Image 01.png---------------------
%Extracting the Eucleadean, Similarity, Affine, and Projective Homography
%matrix for image_00 as fixed and image_01 as moving.
H_Euclidean_00_01 = computeHomography(I00, I01, "Euclidean");
H_Similarity_00_01 = computeHomography(I00, I01, "Similarity");
H_Affine_00_01 = computeHomography(I00, I01, "Affine");
H_Projective_00_01 = computeHomography(I00, I01, "Projective");

tform_euc_01 = projective2d(H_Euclidean_00_01');
tform_sim_01 = projective2d(H_Similarity_00_01');
tform_affine_01 = projective2d(H_Affine_00_01');
tform_proj_01 = projective2d(H_Projective_00_01');

Image_01_warped_euc = imwarp(Image_01, tform_euc_01);
Image_01_warped_similar = imwarp(Image_01, tform_sim_01);
Image_01_warped_affine = imwarp(Image_01, tform_affine_01);
Image_01_warped_projective = imwarp(Image_01, tform_proj_01);

%Reprojection errors
disp('------Reprojection errors of the image 01--------');
sq_diff = repro_error(H_Euclidean_00_01, I00, I01);
disp(sprintf('Eucledean Reprojection error for 00 and 01 is %f',mean(sq_diff)));
sq_diff = repro_error(H_Similarity_00_01, I00, I01);
disp(sprintf('Similarity Reprojection error for 00 and 01 is %f',mean(sq_diff)));
sq_diff = repro_error(H_Affine_00_01, I00, I01);
disp(sprintf('Affine Reprojection error for 00 and 01 is %f',mean(sq_diff)));
sq_diff = repro_error(H_Projective_00_01, I00, I01);
disp(sprintf('Projective Reprojection error for 00 and 01 is %f',mean(sq_diff)));

%Visualising the result for four transformations.
figure(1);
subplot(5,2,1);
imshow(Image_00);
title('Reference image');

subplot(5,2,2);
imshow(Image_01);
title('Original image 01')

subplot(5,2,3);
imshow(Image_01_warped_euc);
title('Euclidian trans');

subplot(5,2,4);
overlay_1 = imfuse(Image_00 ,Image_01_warped_euc ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,5);
imshow(Image_01_warped_similar);
title('Similar trans');

subplot(5,2,6);
overlay_1 = imfuse(Image_00 ,Image_01_warped_similar ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,7);
imshow(Image_01_warped_affine);
title('Affine trans');

subplot(5,2,8);
overlay_1 = imfuse(Image_00 ,Image_01_warped_affine ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,9);
imshow(Image_01_warped_projective);
title('Projective trans');

subplot(5,2,10);
overlay_1 = imfuse(Image_00 ,Image_01_warped_projective ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);



%%
%--------------------- Image 02.png---------------------

%Extracting the Eucleadean, Similarity, Affine, and Projective Homography
%matrix for image_00 as fixed and image_02 as moving.
H_Euclidean_00_02 = computeHomography(I00, I02, "Euclidean");
H_Similarity_00_02 = computeHomography(I00, I02, "Similarity");
H_Affine_00_02 = computeHomography(I00, I02, "Affine");
H_Projective_00_02 = computeHomography(I00, I02, "Projective");

%Visualising the result for four transformations.
tform_euc_02 = projective2d(H_Euclidean_00_02');
tform_sim_02 = projective2d(H_Similarity_00_02');
tform_affine_02 = projective2d(H_Affine_00_02');
tform_proj_02 = projective2d(H_Projective_00_02');

Image_02_warped_euc = imwarp(Image_02, tform_euc_02);
Image_02_warped_sim = imwarp(Image_02, tform_sim_02);
Image_02_warped_affine = imwarp(Image_02, tform_affine_02);
Image_02_warped_projective = imwarp(Image_02, tform_proj_02);

disp('------Reprojection errors of the image 02--------');
sq_diff = repro_error(H_Euclidean_00_02, I00, I02);
disp(sprintf('Eucledean Reprojection error for 00 and 02 is %f',mean(sq_diff)));

sq_diff = repro_error(H_Similarity_00_02, I00, I02);
disp(sprintf('Similarity Reprojection error for 00 and 02 is %f',mean(sq_diff)));

sq_diff = repro_error(H_Affine_00_02, I00, I02);
disp(sprintf('Affine Reprojection error for 00 and 02 is %f',mean(sq_diff)));

sq_diff = repro_error(H_Projective_00_02, I00, I02);
disp(sprintf('Projective Reprojection error for 00 and 02 is %f',mean(sq_diff)));

%Visualising the result for four transformations.
figure(2);
subplot(5,2,1);
imshow(Image_00);
title('Reference image');
subplot(5,2,2);
imshow(Image_02);
title('Original image 02')

subplot(5,2,3);
imshow(Image_02_warped_euc);
title('Euclidian trans');

subplot(5,2,4);
overlay_1 = imfuse(Image_00 ,Image_02_warped_euc ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,5);
imshow(Image_02_warped_sim);
title('Similar trans');

subplot(5,2,6);
overlay_1 = imfuse(Image_00 ,Image_02_warped_sim ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,7);
imshow(Image_02_warped_affine);
title('Affine trans');

subplot(5,2,8);
overlay_1 = imfuse(Image_00 ,Image_02_warped_affine ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,9);
imshow(Image_02_warped_projective);
title('Projective trans');

subplot(5,2,10);
overlay_1 = imfuse(Image_00 ,Image_02_warped_projective ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);


%%
%--------------------- Image 03.png---------------------

%Extracting the Eucleadean, Similarity, Affine, and Projective Homography
%matrix for image_00 as fixed and image_03 as moving.
H_Euclidean_00_03 = computeHomography(I00, I03, "Euclidean");
H_Similarity_00_03 = computeHomography(I00, I03, "Similarity");
H_Affine_00_03 = computeHomography(I00, I03, "Affine");
H_Projective_00_03 = computeHomography(I00, I03, "Projective");


tform_euc_03 = projective2d(H_Euclidean_00_03');
tform_sim_03 = projective2d(H_Similarity_00_03');
tform_affine_03 = projective2d(H_Affine_00_03');
tform_proj_03 = projective2d(H_Projective_00_03');

Image_03_euc_affine = imwarp(Image_03, tform_euc_03);
Image_03_sim_affine = imwarp(Image_03, tform_sim_03);
Image_03_warped_affine = imwarp(Image_03, tform_affine_03);
Image_03_warped_projective = imwarp(Image_03, tform_proj_03);

disp('------Reprojection errors of the image 03--------');
sq_diff = repro_error(H_Euclidean_00_03, I00, I03);
disp(sprintf('Eucledean Reprojection error for 00 and 03 is %f',mean(sq_diff)));

sq_diff = repro_error(H_Similarity_00_03, I00, I03);
disp(sprintf('Similarity Reprojection error for 00 and 03 is %f',mean(sq_diff)));

sq_diff = repro_error(H_Affine_00_03, I00, I03);
disp(sprintf('Affine Reprojection error for 00 and 03 is %f',mean(sq_diff)));

sq_diff = repro_error(H_Projective_00_03, I00, I03);
disp(sprintf('Projective Reprojection error for 00 and 03 is %f',mean(sq_diff)));

%Visualising the result for four transformations.
figure(3);
subplot(5,2,1);
imshow(Image_00);
title('Reference image');

subplot(5,2,2);
imshow(Image_03);
title('Original image 03')

subplot(5,2,3);
imshow(Image_03_euc_affine);
title('Euclidian trans');

subplot(5,2,4);
overlay_1 = imfuse(Image_00 ,Image_03_euc_affine ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,5);
imshow(Image_03_sim_affine);
title('Similar trans');

subplot(5,2,6);
overlay_1 = imfuse(Image_00 ,Image_03_sim_affine ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,7);
imshow(Image_03_warped_affine);
title('Affine trans');

subplot(5,2,8);
overlay_1 = imfuse(Image_00 ,Image_03_warped_affine ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,9);
imshow(Image_03_warped_projective);
title('Projective trans');

subplot(5,2,10);
overlay_1 = imfuse(Image_00 ,Image_03_warped_projective ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);
%%
%----------------------------Retina images------------------
%Adding the VL_feat's paths
addpath('./vlfeat-0.9.21/toolbox/demo');
run('./vlfeat-0.9.21/toolbox/vl_setup')

Image_ret_00 = imread("DataSet00/retina1.png");
Image_ret_01 = imread("DataSet00/retina2.png");

[~, ~, I00_1, I01] = match(Image_ret_00, Image_ret_01);
[feat_fixed_retina, feat_moving_retina, fixed, moving] = match(Image_ret_00, Image_ret_01);


%Extracting the Eucleadean, Similarity, Affine, and Projective Homography
%matrix for image_00 as fixed and image_01 as moving.
H_Euclidean_00_01 = computeHomography(I00_1, I01, "Euclidean");
H_Similarity_00_01 = computeHomography(I00_1, I01, "Similarity");
H_Affine_00_01 = computeHomography(I00_1, I01, "Affine");
H_Projective_00_01 = computeHomography(I00_1, I01, "Projective");

tform_affine_ret_euc = projective2d(H_Euclidean_00_01');
tform_affine_ret_sim = projective2d(H_Similarity_00_01');
tform_affine_ret_aff = projective2d(H_Affine_00_01');
tform_proj__ret_proj = projective2d(H_Projective_00_01');

Image_ret_euc = imwarp(Image_ret_01, tform_affine_ret_euc);
Image_ret_sim = imwarp(Image_ret_01, tform_affine_ret_sim);
Image_ret_aff = imwarp(Image_ret_01, tform_affine_ret_aff);
Image_ret_proj = imwarp(Image_ret_01, tform_proj__ret_proj);

%Reprojection errors
disp('------Reprojection errors of the Retina images--------');
sq_diff = repro_error(H_Similarity_00_01, I00_1, I01);
disp(sprintf('Eucledean Reprojection error for I00_1 and 01 is %f',mean(sq_diff)));

%Reprojection errors
sq_diff = repro_error(H_Similarity_00_01, I00_1, I01);
disp(sprintf('Similarity Reprojection error for I00_1 and 01 is %f',mean(sq_diff)));

%Reprojection errors
sq_diff = repro_error(H_Affine_00_01, I00_1, I01);
disp(sprintf('Affine Reprojection error for I00_1 and 01 is %f',mean(sq_diff)));

%Reprojection errors
sq_diff = repro_error(H_Projective_00_01, I00_1, I01);
disp(sprintf('Projective Reprojection error for I00_1 and 01 is %f',mean(sq_diff)));

%Visualising the result for four transformations.
figure(4);
subplot(5,2,1);
imshow(Image_ret_00);
title('Reference image Retina 1');

subplot(5,2,2);
imshow(Image_ret_01);
title('Original image Retina 2')

subplot(5,2,3);
imshow(Image_ret_euc);
title('Euclidian trans');

subplot(5,2,4);
overlay_1 = imfuse(Image_ret_00 ,Image_ret_euc ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,5);
imshow(Image_ret_sim);
title('Similar trans');

subplot(5,2,6);
overlay_1 = imfuse(Image_ret_00 ,Image_ret_sim ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,7);
imshow(Image_ret_aff);
title('Affine trans');


subplot(5,2,8);
overlay_1 = imfuse(Image_ret_00 ,Image_ret_aff ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,9);
imshow(Image_ret_proj);
title('Projective trans');

subplot(5,2,10);
overlay_1 = imfuse(Image_ret_00 ,Image_ret_proj ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);


%%
%Adding the VL_feat's paths
addpath('./vlfeat-0.9.21/toolbox/demo');
run('./vlfeat-0.9.21/toolbox/vl_setup')

Image_skin_02 = imread("DataSet00/skin1.jpg");
Image_skin_03 = imread("DataSet00/skin2.jpg");

[~, ~, I00_2, I02] = match(Image_skin_02, Image_skin_03);
[feat_fixed_skin, feat_moving_skin, fixed, moving] = match(Image_skin_02, Image_skin_03);

%Extracting the Eucleadean, Similarity, Affine, and Projective Homography
%matrix for image_00 as fixed and image_01 as moving.
H_Euclidean_00_02 = computeHomography(I00_2, I02, "Euclidean");
H_Similarity_00_02 = computeHomography(I00_2, I02, "Similarity");
H_Affine_00_02 = computeHomography(I00_2, I02, "Affine");
H_Projective_00_02 = computeHomography(I00_2, I02, "Projective");

tform_affine_skin_euc = projective2d(H_Euclidean_00_02');
tform_affine_skin_sim = projective2d(H_Similarity_00_02');
tform_affine_skin_aff = projective2d(H_Affine_00_02');
tform_proj__skin_proj = projective2d(H_Projective_00_02');

Image_skin_euc = imwarp(Image_skin_03, tform_affine_skin_euc);
Image_skin_sim = imwarp(Image_skin_03, tform_affine_skin_sim);
Image_skin_aff = imwarp(Image_skin_03, tform_affine_skin_aff);
Image_skin_proj = imwarp(Image_skin_03, tform_proj__skin_proj);

%Reprojection errors
disp('------Reprojection errors of the Skin images--------');
sq_diff = repro_error(H_Similarity_00_02, I00_2, I02);
disp(sprintf('Eucledean Reprojection error for I00_2 and 02 is %f',mean(sq_diff)));

%Reprojection errors
sq_diff = repro_error(H_Similarity_00_02, I00_2, I02);
disp(sprintf('Similarity Reprojection error for I00_2 and 02 is %f',mean(sq_diff)));

%Reprojection errors
sq_diff = repro_error(H_Affine_00_02, I00_2, I02);
disp(sprintf('Affine Reprojection error for I00_2 and 02 is %f',mean(sq_diff)));

%Reprojection errors
sq_diff = repro_error(H_Projective_00_02, I00_2, I02);
disp(sprintf('Projective Reprojection error for I00_2 and 02 is %f',mean(sq_diff)));

%Visualising the result for four transformations.
figure(5);
subplot(5,2,1);
imshow(Image_skin_02);
title('Reference image Skin 1');

subplot(5,2,2);
imshow(Image_skin_03);
title('Original image Skin 2')

subplot(5,2,3);
imshow(Image_skin_euc);
title('Euclidian trans');

subplot(5,2,4);
overlay_1 = imfuse(Image_skin_02 ,Image_skin_euc ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,5);
imshow(Image_skin_sim);
title('Similar trans');

subplot(5,2,6);
overlay_1 = imfuse(Image_skin_02, Image_skin_sim ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,7);
imshow(Image_skin_aff);
title('Affine trans');

subplot(5,2,8);
overlay_1 = imfuse(Image_skin_02, Image_skin_aff ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,9);
imshow(Image_skin_proj);
title('Projective trans');

subplot(5,2,10);
overlay_1 = imfuse(Image_skin_02,Image_skin_proj ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);


%%
% RANSAC
%Retina image

%Extracting the Eucleadean, Similarity, Affine, and Projective Homography
%matrix for image_00 as fixed and image_01 as moving.
[H_Euclidean_00_01, error_retina_0] = computeHomographyRANSAC(I00_1, I01, "Euclidean");
[H_Similarity_00_01, error_retina_1] = computeHomographyRANSAC(I00_1, I01, "Similarity");
[H_Affine_00_01, error_retina_2] = computeHomographyRANSAC(I00_1, I01, "Affine");
[H_Projective_00_01, error_retina_3] = computeHomographyRANSAC(I00_1, I01, "Projective");

tform_euc_01_ransac = affine2d(H_Euclidean_00_01');
tform_sim_01_ransac = affine2d(H_Similarity_00_01');
tform_affine_01_ransac = affine2d(H_Affine_00_01');
tform_proj_01_ransac = projective2d(H_Projective_00_01');

Image_01_warped_euc_ransac = imwarp(Image_ret_01, tform_euc_01_ransac);
Image_01_warped_sim_ransac = imwarp(Image_ret_01, tform_sim_01_ransac);
Image_01_warped_affine_ransac = imwarp(Image_ret_01, tform_affine_01_ransac);
Image_01_warped_projective_ransac = imwarp(Image_ret_01, tform_proj_01_ransac);

disp('------Reprojection errors of the Retina images with RANSAC--------');
disp(sprintf('Euclidean Reprojection error for Retina2 and Retina1 is %f',mean(error_retina_0)));
disp(sprintf('Similarity Reprojection error for Retina2 and Retina1 is %f',mean(error_retina_1)));
disp(sprintf('Affine Reprojection error for Retina2 and Retina1 is %f',mean(error_retina_2)));
disp(sprintf('Projective Reprojection error for Retina2 and Retina1 is %f',mean(error_retina_3)));

%Visualising the result for four transformations.
figure(7);
subplot(5,2,1);
imshow(Image_ret_00);
title('Reference image Retina 1');

subplot(5,2,2);
imshow(Image_ret_01);
title('Original image Retina 2')

subplot(5,2,3);
imshow(Image_01_warped_euc_ransac);
title('Euclidian trans');

subplot(5,2,4);
overlay_1 = imfuse(Image_ret_00, Image_01_warped_euc_ransac ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,5);
imshow(Image_01_warped_sim_ransac);
title('Similar trans');

subplot(5,2,6);
overlay_1 = imfuse(Image_ret_00, Image_01_warped_sim_ransac ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,7);
imshow(Image_01_warped_affine_ransac);
title('Affine trans');

subplot(5,2,8);
overlay_1 = imfuse(Image_ret_00, Image_01_warped_affine_ransac ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,9);
imshow(Image_01_warped_projective_ransac);
title('Projective trans');

subplot(5,2,10);
overlay_1 = imfuse(Image_ret_00,Image_01_warped_projective_ransac ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

%%
%RANSAC Skin image
%Extracting the Eucleadean, Similarity, Affine, and Projective Homography
%matrix for image_00 as fixed and image_02 as moving.
[H_Euclidean_00_02, error_skin_0] = computeHomographyRANSAC(I00_2, I02, "Euclidean");
[H_Similarity_00_02, error_skin_1] = computeHomographyRANSAC(I00_2, I02, "Similarity");
[H_Affine_00_02, error_skin_2] = computeHomographyRANSAC(I00_2, I02, "Affine");
[H_Projective_00_02, error_skin_3] = computeHomographyRANSAC(I00_2, I02, "Projective");

tform_euc_02_ransac = affine2d(H_Euclidean_00_02');
tform_sim_02_ransac = affine2d(H_Similarity_00_02');
tform_affine_02_ransac = affine2d(H_Affine_00_02');
tform_proj_02_ransac = projective2d(H_Projective_00_02');

Image_02_warped_euc_ransac = imwarp(Image_skin_03, tform_euc_02_ransac);
Image_02_warped_sim_ransac = imwarp(Image_skin_03, tform_sim_02_ransac);
Image_02_warped_affine_ransac = imwarp(Image_skin_03, tform_affine_02_ransac);
Image_02_warped_projective_ransac = imwarp(Image_skin_03, tform_proj_02_ransac);


disp('------Reprojection errors of the Retina images with RANSAC--------');
disp(sprintf('Euclidean Reprojection error for Skin2 and Skin1 is %f',mean(error_skin_0)));
disp(sprintf('Similarity Reprojection error for Skin2 and Skin1 is %f',mean(error_skin_1)));
fprintf('Affine Reprojection error for Skin2 and Skin1 is %f\n',mean(error_skin_2));
disp(sprintf('Projective Reprojection error for Skin2 and Skin1 is %f',mean(error_skin_3)));

%Visualising the result for four transformations.
figure(8);
subplot(5,2,1);
imshow(Image_skin_02);
title('Reference image Retina 1');

subplot(5,2,2);
imshow(Image_skin_03);
title('Original image Skin 2')

subplot(5,2,3);
imshow(Image_02_warped_euc_ransac);
title('Euclidian trans');

subplot(5,2,4);
overlay_1 = imfuse(Image_skin_02, Image_02_warped_euc_ransac ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,5);
imshow(Image_02_warped_sim_ransac);
title('Similar trans');

subplot(5,2,6);
overlay_1 = imfuse(Image_skin_02, Image_02_warped_sim_ransac ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,7);
imshow(Image_02_warped_affine_ransac);
title('Affine trans');

subplot(5,2,8);
overlay_1 = imfuse(Image_skin_02, Image_02_warped_affine_ransac ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,9);
imshow(Image_02_warped_projective_ransac);
title('Projective trans');


subplot(5,2,10);
overlay_1 = imfuse(Image_skin_02,Image_02_warped_projective_ransac ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);


%%
% RANSAC
%Retina image with data normalization

[I00_1_norm, I01_norm, T_Features_1, T_Matches_1] = normalization(I00_1, I01);


%Extracting the Eucleadean, Similarity, Affine, and Projective Homography
%matrix for image_00 as fixed and image_01 as moving.
[H_Euclidean_00_01, error_retina_0] = computeHomographyRANSACnorm(I00_1_norm, I01_norm, "Euclidean");
[H_Similarity_00_01, error_retina_1] = computeHomographyRANSACnorm(I00_1_norm, I01_norm, "Similarity");
[H_Affine_00_01, error_retina_2] = computeHomographyRANSACnorm(I00_1_norm, I01_norm, "Affine");
[H_Projective_00_01, error_retina_3] = computeHomographyRANSACnorm(I00_1_norm, I01_norm, "Projective");

tform_euc_01_ransac = affine2d(H_Euclidean_00_01');
tform_sim_01_ransac = affine2d(H_Similarity_00_01');
tform_affine_01_ransac = affine2d(H_Affine_00_01');
tform_proj_01_ransac = projective2d(H_Projective_00_01');

Image_01_warped_euc_ransac = imwarp(Image_ret_01, tform_euc_01_ransac);
Image_01_warped_sim_ransac = imwarp(Image_ret_01, tform_sim_01_ransac);
Image_01_warped_affine_ransac = imwarp(Image_ret_01, tform_affine_01_ransac);
Image_01_warped_projective_ransac = imwarp(Image_ret_01, tform_proj_01_ransac);

disp('------Reprojection errors of the Retina images with RANSAC--------');
disp(sprintf('Euclidean Reprojection error for Retina2 and Retina1 is %f',mean(error_retina_0)));
disp(sprintf('Similarity Reprojection error for Retina2 and Retina1 is %f',mean(error_retina_1)));
disp(sprintf('Affine Reprojection error for Retina2 and Retina1 is %f',mean(error_retina_2)));
disp(sprintf('Projective Reprojection error for Retina2 and Retina1 is %f',mean(error_retina_3)));

%Visualising the result for four transformations.
figure(7);
subplot(5,2,1);
imshow(Image_ret_00);
title('Reference image Retina 1');

subplot(5,2,2);
imshow(Image_ret_01);
title('Original image Retina 2')

subplot(5,2,3);
imshow(Image_01_warped_euc_ransac);
title('Euclidian trans');

subplot(5,2,4);
overlay_1 = imfuse(Image_ret_00, Image_01_warped_euc_ransac ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,5);
imshow(Image_01_warped_sim_ransac);
title('Similar trans');

subplot(5,2,6);
overlay_1 = imfuse(Image_ret_00, Image_01_warped_sim_ransac ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,7);
imshow(Image_01_warped_affine_ransac);
title('Affine trans');

subplot(5,2,8);
overlay_1 = imfuse(Image_ret_00, Image_01_warped_affine_ransac ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,9);
imshow(Image_01_warped_projective_ransac);
title('Projective trans');

subplot(5,2,10);
overlay_1 = imfuse(Image_ret_00,Image_01_warped_projective_ransac ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

%%
%RANSAC Skin image with normalization
%Extracting the Eucleadean, Similarity, Affine, and Projective Homography

%matrix for image_00 as fixed and image_02 as moving.
[I00_2_norm, I02_norm, T_Features_2, T_Matches_2] = normalization(I00_2, I02);

[H_Euclidean_00_02, error_skin_0] = computeHomographyRANSACnorm(I00_2_norm, I02_norm, "Euclidean");
[H_Similarity_00_02, error_skin_1] = computeHomographyRANSACnorm(I00_2_norm, I02_norm, "Similarity");
[H_Affine_00_02, error_skin_2] = computeHomographyRANSACnorm(I00_2_norm, I02_norm, "Affine");
[H_Projective_00_02, error_skin_3] = computeHomographyRANSACnorm(I00_2_norm, I02_norm, "Projective");

tform_euc_02_ransac = affine2d(H_Euclidean_00_02');
tform_sim_02_ransac = affine2d(H_Similarity_00_02');
tform_affine_02_ransac = affine2d(H_Affine_00_02');
tform_proj_02_ransac = projective2d(H_Projective_00_02');

Image_02_warped_euc_ransac = imwarp(Image_skin_03, tform_euc_02_ransac);
Image_02_warped_sim_ransac = imwarp(Image_skin_03, tform_sim_02_ransac);
Image_02_warped_affine_ransac = imwarp(Image_skin_03, tform_affine_02_ransac);
Image_02_warped_projective_ransac = imwarp(Image_skin_03, tform_proj_02_ransac);


disp('------Reprojection errors of the Retina images with RANSAC--------');
disp(sprintf('Euclidean Reprojection error for Skin2 and Skin1 is %f',mean(error_skin_0)));
disp(sprintf('Similarity Reprojection error for Skin2 and Skin1 is %f',mean(error_skin_1)));
fprintf('Affine Reprojection error for Skin2 and Skin1 is %f\n',mean(error_skin_2));
disp(sprintf('Projective Reprojection error for Skin2 and Skin1 is %f',mean(error_skin_3)));

%Visualising the result for four transformations.
figure(8);
subplot(5,2,1);
imshow(Image_skin_02);
title('Reference image Retina 1');

subplot(5,2,2);
imshow(Image_skin_03);
title('Original image Skin 2')

subplot(5,2,3);
imshow(Image_02_warped_euc_ransac);
title('Euclidian trans');

subplot(5,2,4);
overlay_1 = imfuse(Image_skin_02, Image_02_warped_euc_ransac ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,5);
imshow(Image_02_warped_sim_ransac);
title('Similar trans');

subplot(5,2,6);
overlay_1 = imfuse(Image_skin_02, Image_02_warped_sim_ransac ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,7);
imshow(Image_02_warped_affine_ransac);
title('Affine trans');

subplot(5,2,8);
overlay_1 = imfuse(Image_skin_02, Image_02_warped_affine_ransac ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);

subplot(5,2,9);
imshow(Image_02_warped_projective_ransac);
title('Projective trans');


subplot(5,2,10);
overlay_1 = imfuse(Image_skin_02,Image_02_warped_projective_ransac ,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
imshow(overlay_1);