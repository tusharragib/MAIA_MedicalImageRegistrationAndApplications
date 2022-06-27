% Reset the workspace
clear all; close all, clc;
folder = fileparts(which('C:\Users\HP\Desktop\Spain\MIRA\PRoject\Project\challengeDay2122\copd0'));   % Get current folder
addpath(genpath(folder));               % Add all subfolders to path

folder_index = {'copd0', 'copd5', 'copd6'};

% length of the array with the folder indexes
len_files = length(folder_index);

tic
% Define all the paths for input and output images,files etc.
for index=1:length(folder_index)
folder = strcat('challengeDay2122\',folder_index{index}, '\');
name_Ifile = strcat(folder_index{index}, '_iBHCT.nii'); 
name_Efile = strcat(folder_index{index}, '_eBHCT.nii'); 
fixed_image_path = strcat(folder, name_Ifile); 
moving_image_path = strcat(folder, name_Efile); 

%Reading nifti files of fixed and moving images
fixed_image = niftiread(fixed_image_path);
moving_image = niftiread(moving_image_path);
% Convert image to single precision
fixed_V = im2single(fixed_image);
moving_V = im2single(moving_image);

fixed_XY = fixed_V(:,:,:);
moving_XY = moving_V(:,:,:);

% Smooth 3D volume using Gaussian filter with sigma=5
fixed_XY = imgaussfilt3(fixed_XY,5);
moving_XY = imgaussfilt3(moving_XY,5);
%Threshold moving image
moving_BW = moving_XY > 5.098000e-01;
% Compute the complement of the image 
moving_BW = imcomplement(moving_BW);
%Suppress light structures connected to image border with 8-connectivity
moving_BW = imclearborder(moving_BW, 8);
%Fill image regions and holes
moving_BW = imfill(moving_BW, 'holes');
radius = 1;
decomposition = 0;
se = strel('disk',radius,decomposition);
%Erode image using disk structural element with radius 1
moving_BW = imerode(moving_BW, se);

%Threshold fixed image
fixed_BW = fixed_XY > 5.098000e-01;
% Compute the complement of the image 
fixed_BW = imcomplement(fixed_BW);
%Suppress light structures connected to image border with 8-connectivity
fixed_BW = imclearborder(fixed_BW, 8);
%Fill image regions and holes
fixed_BW = imfill(fixed_BW, 'holes');
radius = 1;
decomposition = 0;
se = strel('disk',radius,decomposition);
%Erode image using disk structural element with radius 1
fixed_BW = imerode(fixed_BW, se);


fixed_maskedImageXY = fixed_XY;
%Find all pixels of the mask according to ROI (fixed_BW) and make the pixels of ROI 0
fixed_maskedImageXY(~fixed_BW) = 0;
%Fill image regions and holes
fixed_maskedImageXY = imfill(fixed_maskedImageXY,'holes');
% Remove small objects from binary image
fixed_image_n = bwareaopen(fixed_maskedImageXY, 1);

moving_maskedImageXY = moving_XY;
%Find all pixels of the mask according to ROI (moving_BW) and make the pixels of ROI 0
moving_maskedImageXY(~moving_BW) = 0;
%Fill image regions and holes
moving_maskedImageXY = imfill(moving_maskedImageXY,'holes');
% Remove small objects from binary image
moving_image_n = bwareaopen(moving_maskedImageXY, 1);

% Read header of fixed image
hdr_original = niftiinfo(fixed_image_path);
% Read header of moving image
hdr_mni = niftiinfo(moving_image_path);
%Save images
niftiwrite(int16(fixed_image_n), strcat(folder, folder_index{index}, '_mask_iBHCT'), hdr_original);
niftiwrite(int16(moving_image_n), strcat(folder, folder_index{index}, '_mask_eBHCT'),hdr_mni);

disp(fixed_image_path);
disp(moving_image_path);
end
toc
