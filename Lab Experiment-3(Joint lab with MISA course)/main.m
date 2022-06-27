clc;
clear all;
close all;
%Please add all folders and subfolders to the path. Thanks! :)
% Change th number of the file, for example 1003, 1004, 1005 ...    
name = '1038';
% Change th number of the f, for example 03, 04, 107, 110 ...  
name_fol = '38';
test_image = niftiread(strcat('test-set/testing-images/',name, '.nii.gz'));
test_label = niftiread(strcat('test-set/testing-labels/', name, '_3C.nii.gz'));
test_mask = niftiread(strcat('test-set/testing-mask/', name, '_1C.nii.gz'));

testing_image_vector = reshape(test_image, numel(test_image), 1);
testing_labels_vector= reshape(test_label, numel(test_label), 1);
testing_mask_vector= reshape(test_mask, numel(test_mask), 1);

CSF_atlas_vector = niftiread(strcat('test-set\registered_atlas\',name_fol, '\csf\bspline\result.0.nii.gz'));
WM_atlas_vector = niftiread(strcat('test-set\registered_atlas\',name_fol, '\wm\bspline\result.0.nii.gz'));
GM_atlas_vector = niftiread(strcat('test-set\registered_atlas\',name_fol, '\gm\bspline\result.0.nii.gz'));

CSF_atlas_vector = imrotate(CSF_atlas_vector,180);
WM_atlas_vector = imrotate(WM_atlas_vector,180);
GM_atlas_vector = imrotate(GM_atlas_vector,180);

CSF_atlas_vector_resh = reshape(CSF_atlas_vector, numel(CSF_atlas_vector), 1);
WM_atlas_vector_resh = reshape(WM_atlas_vector, numel(WM_atlas_vector), 1);
GM_atlas_vector_resh = reshape(GM_atlas_vector, numel(GM_atlas_vector), 1);

tissue_model_CSF = niftiread('atlas/CSF_tissue_model.nii.gz');
tissue_model_WM = niftiread('atlas/WM_tissue_model.nii.gz');
tissue_model_GM = niftiread('atlas/GM_tissue_model.nii.gz');


CSF_atlas_mni = niftiread(strcat('test-set\registered_atlas\', name_fol, '\mni\csf\bspline\result.0.nii.gz'));
WM_atlas_mni = niftiread(strcat('test-set\registered_atlas\', name_fol, '\mni\wm\bspline\result.0.nii.gz'));
GM_atlas_mni = niftiread(strcat('test-set\registered_atlas\', name_fol, '\mni\gm\bspline\result.0.nii.gz'));


%Switch the segmentation
n = 9;
switch n
    case 1
    % 1.Tissue models Segmentation:
    tissueSeg(testing_mask_vector, test_image, test_label);
    
    case 2
    % 2. Atlas Segmentation (Label propagation):
    dice_coef = atlasSeg(test_image, test_label, test_mask, testing_image_vector, testing_labels_vector, testing_mask_vector, CSF_atlas_vector_resh, WM_atlas_vector_resh, GM_atlas_vector_resh);

    case 3    
    % 3. Tissue + Atlas
    atlasTissueSeg(name_fol,test_mask, test_image, test_label, CSF_atlas_vector_resh, WM_atlas_vector_resh, GM_atlas_vector_resh);

    case 4
    % 4. EM Segmentation
    EMSeg(test_image, test_label);

    case 5
    % 5. EM Segmentation + tissue models initialisation
    EMTisSeg(testing_mask_vector, test_image, test_label, tissue_model_CSF, tissue_model_WM, tissue_model_GM);

    case 6
    % 6. EM Segmentation + tissue models initialisation
    EMTisSeg(testing_mask_vector, test_image, test_label, CSF_atlas_vector_resh, WM_atlas_vector_resh, GM_atlas_vector_resh);

    case 7
    % 7.  EM (k-means) + atlas
    EMAtlasSeg(test_image, test_label, testing_image_vector, testing_labels_vector, testing_mask_vector, CSF_atlas_vector_resh, WM_atlas_vector_resh, GM_atlas_vector_resh);
    
    case 8
    % 8. The tissue models & label propagation (1.3) initialisation after EM 
    TisLabAtlasAfterEMSeg(test_image, test_label, testing_image_vector, testing_labels_vector, testing_mask_vector, CSF_atlas_vector_resh, WM_atlas_vector_resh, GM_atlas_vector_resh);

    case 9
    % 9. MNI + EM + Label propagation initialisation
    MNIEMLabelPropSeg(test_mask, test_image, test_label, CSF_atlas_mni, WM_atlas_mni, GM_atlas_mni);
end