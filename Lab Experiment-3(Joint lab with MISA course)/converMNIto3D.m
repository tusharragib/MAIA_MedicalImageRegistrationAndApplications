clc;
clear all;
close all;

mni_atlas = niftiread('MNITemplateAtlas/atlas.nii.gz');
disp(size(mni_atlas));

mni_atlas_3d_CSF = mni_atlas(:,:,:,2);
mni_atlas_3d_WM = mni_atlas(:,:,:,3);
mni_atlas_3d_GM = mni_atlas(:,:,:,4);

%mni_atlas_3d_resh = reshape(mni_atlas_3d, numel(mni_atlas_3d), 1);

mni_atlas_3d_CSF = imrotate(mni_atlas_3d_CSF,180);
mni_atlas_3d_WM = imrotate(mni_atlas_3d_WM,180);
mni_atlas_3d_GM = imrotate(mni_atlas_3d_GM,180);


niftiwrite(mni_atlas_3d_CSF,'MNITemplateAtlas/mni_atlas_3d_CSF', 'Compressed',true);
niftiwrite(mni_atlas_3d_WM,'MNITemplateAtlas/mni_atlas_3d_WM', 'Compressed',true);
niftiwrite(mni_atlas_3d_GM,'MNITemplateAtlas/mni_atlas_3d_GM', 'Compressed',true);

subplot(3,3,1);
imshow(double(mni_atlas_3d_CSF(:,:,100)));
title('atlas_CSF');
    
subplot(3,3,2);
imshow(double(mni_atlas_3d_WM(:,:,100)));
title('atlas_CSF');

subplot(3,3,3);
imshow(double(mni_atlas_3d_GM(:,:,100)));
title('atlas_CSF');

