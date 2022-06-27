function [dice_coef] = atlasSeg(test_image, test_label, test_mask, testing_image_vector, testing_labels_vector, testing_mask_vector, CSF_atlas_vector_resh, WM_atlas_vector_resh, GM_atlas_vector_resh)
atlas_array = zeros(length(testing_mask_vector), 3);
atlas_array(:,1) = CSF_atlas_vector_resh;
atlas_array(:,2) = WM_atlas_vector_resh;
atlas_array(:,3) = GM_atlas_vector_resh;

[val,idx] = max(atlas_array,[],2) ;

out_atlas_vect = (idx).* double(testing_mask_vector);
out_atlas_vect_resh = reshape(out_atlas_vect, size(test_image));

out_atlas_vect_resh = imrotate(out_atlas_vect_resh,90);
test_label = imrotate(test_label,90);

figure();
imshowpair(double(test_label(:,:,160)),label2rgb(out_atlas_vect_resh(:,:,160), 'hsv' ,'k'), 'montage')
title('Atlas Segmentation. GT (Left) and Segmented (Right)');    

segmented_data = out_atlas_vect;
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