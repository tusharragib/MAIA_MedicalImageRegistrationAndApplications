function atlasTissueSeg(name_fol, test_mask, test_image, test_label, CSF_atlas_vector_resh, WM_atlas_vector_resh, GM_atlas_vector_resh);

testing_image_vector = reshape(test_image, numel(test_image), 1);
testing_labels_vector= reshape(test_label, numel(test_label), 1);
testing_mask_vector= reshape(test_mask, numel(test_mask), 1);


tissue_model_vect_CSF = niftiread(strcat('test-set\tissues_models\', name_fol, '\tissue_model_CSF.nii.gz'));
tissue_model_vect_WM = niftiread(strcat('test-set\tissues_models\', name_fol, '\tissue_model_WM.nii.gz'));
tissue_model_vect_GM = niftiread(strcat('test-set\tissues_models\', name_fol, '\tissue_model_GM.nii.gz'));



tissue_model_vect_CSF = imrotate(tissue_model_vect_CSF,180);
tissue_model_vect_WM = imrotate(tissue_model_vect_WM,180);
tissue_model_vect_GM = imrotate(tissue_model_vect_GM,180);

CSF_tissue_model = tissue_model_vect_CSF;
WM_tissue_model = tissue_model_vect_WM;
GM_tissue_model = tissue_model_vect_GM;

CSF_tissue_model_vector = reshape(CSF_tissue_model, numel(CSF_tissue_model), 1);
WM_tissue_model_vector = reshape(WM_tissue_model, numel(WM_tissue_model), 1);
GM_tissue_model_vector = reshape(GM_tissue_model, numel(GM_tissue_model), 1);


atlas_tissue_model_array = zeros(length(testing_mask_vector), 3);
atlas_tissue_model_array(:,1) = CSF_atlas_vector_resh .* CSF_tissue_model_vector;
atlas_tissue_model_array(:,2) = WM_atlas_vector_resh .* WM_tissue_model_vector;
atlas_tissue_model_array(:,3) = GM_atlas_vector_resh .* GM_tissue_model_vector;



[val,idx] = max(atlas_tissue_model_array,[],2) ;

out_testing_labels_vect = (idx).* double(testing_mask_vector);
out_testing_labels_vect_resh = reshape(out_testing_labels_vect, size(test_image));

out_testing_labels_vect_resh2 = imrotate(out_testing_labels_vect_resh,90);
test_label2 = imrotate(test_label,90);
figure();
imshowpair(double(test_label2(:,:,160)),label2rgb(out_testing_labels_vect_resh2(:,:,160), 'hsv' ,'k'), 'montage')
  

segmented_data = out_testing_labels_vect;
groundtruth_data = testing_labels_vector;

dice_coef = zeros(3, 1);
 for cluster = 1:3
    Seg = (segmented_data == cluster);
    GT = (groundtruth_data == cluster);
    dice_coef(cluster) = dice(Seg, GT);
     
 end
 fprintf('The Dice similarity for CSF is \n');
  disp(dice_coef(1));
  
   fprintf('The Dice similarity for WM is \n');
  disp(dice_coef(2));
  
   fprintf('The Dice similarity for GM is \n');
  disp(dice_coef(3));
 
end