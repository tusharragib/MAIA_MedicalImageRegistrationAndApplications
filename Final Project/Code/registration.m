% Reset the workspace
clear all; close all, clc;
% paths for inputs
%voxels = 0[0.97;   0.97;   2.5
         %1 0.625;  0.625;  2.5
         %2% 0.645;  0.645;  2.5
         %3% 0.652;  0.652;  2.5
         %4% 0.590;  0.590;  2.5
         %5 0.647;  0.647;  2.5
         %6 0.633;  0.633;  2.5
         %7% 0.625;  0.625;  2.5
         %8% 0.586;  0.586;  2.5
         %9% 0.664;  0.664;  2.5
         %10% 0.742;  0.742;  2.5];
                
%Write the index of the volume         
image = 'copd1';
%Write voxel spacing according to the image
voxel_spacing = [0.625;  0.625;  2.5];
%path to fixed and image landmarks
fixed_points_path = strcat('C:\Users\HP\Desktop\Spain\MIRA\PRoject\Project\train\', image, '\', image, '_300_iBH_xyz_r1.txt');
moving_points_path = strcat('C:\Users\HP\Desktop\Spain\MIRA\PRoject\Project\train\', image, '\', image, '_300_eBH_xyz_r1.txt');

% paths for new inputs
fixed_image_path = strcat('C:\Users\HP\Desktop\Spain\MIRA\PRoject\Project\train\', image, '\', image, '_iBHCT.nii');
moving_image_path = strcat('C:\Users\HP\Desktop\Spain\MIRA\PRoject\Project\train\', image, '\', image, '_eBHCT.nii'); 
fixed_image_path_mask = strcat('C:\Users\HP\Desktop\Spain\MIRA\PRoject\Project\train\', image, '\', image, '_mask_iBHCT.nii');
moving_image_path_mask = strcat('C:\Users\HP\Desktop\Spain\MIRA\PRoject\Project\train\', image, '\', image, '_mask_eBHCT.nii'); 

% paths for outputs
elastix_out = strcat('C:\Users\HP\Desktop\Spain\MIRA\PRoject\Project\registered\', image);
transformix_out = strcat('C:\Users\HP\Desktop\Spain\MIRA\PRoject\Project\registered\', image, '\transformix\');
registered_points_path = strcat('C:\Users\HP\Desktop\Spain\MIRA\PRoject\Project\registered\', image, '\transformix\outputpoints.txt');

% path for input parameters files
param1 = 'C:\Users\HP\Desktop\Spain\MIRA\PRoject\Project\Par0009\Parameters.Par0009.affine.txt';
param2 = 'C:\Users\HP\Desktop\Spain\MIRA\PRoject\Project\Par0009\Parameters.Par0009.elastic.txt';

% Make and run the command for elastix
cmd = strcat('elastix -f'," ",fixed_image_path," ",'-m '," ",moving_image_path," ",... 
            "-fMask", " ", fixed_image_path_mask, " ","-mMask"," ", moving_image_path_mask," ",...
            '-p'," ", param1," ",'-p'," ", param2," ", '-out'," ", elastix_out); 
system(cmd);
% Get the paths for transform parameters files
transform_param_names = strcat(elastix_out,'\TransformParameters.1.txt');

% Now make and run command for transformix
cmd = strcat('transformix -def'," ",fixed_points_path," ",'-out '," ",transformix_out," ",...
            '-tp'," ", transform_param_names);
system(cmd);
disp(image);

% Read the result of transformed landmarks. Uncomments next lines if you
% register train dataset.
%name_Ifile_land = strcat(transformix_out,'outputpoints.txt');
%name_Efile_land = moving_points_path;
%landmarksI = fopen(strcat(name_Ifile_land));
%landmarksE = fopen(name_Efile_land);

%pointsI = textscan(landmarksI,'%s','Delimiter',';');
%pointsE = fscanf(landmarksE,'%f');

%[tre_mean,tre_std] = tre(pointsI, pointsE, voxel_spacing);

%disp(tre_mean);
%disp(tre_std);