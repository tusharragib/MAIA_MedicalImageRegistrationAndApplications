function tissueSeg(testing_mask_vector, test_image, test_label);

load('hist_norm/histogram_norm_CSF.mat');
CSF_histogram_norm=conj(histogram_norm_CSF);
load('hist_norm/histogram_norm_WM.mat');
WM_histogram_norm = conj(histogram_norm_WM);
load('hist_norm/histogram_norm_GM.mat');
GM_histogram_norm = conj(histogram_norm_GM);

testing_image_vector = reshape(test_image, numel(test_image), 1);
testing_labels_vector= reshape(test_label, numel(test_label), 1);

histogram_norm1 = CSF_histogram_norm';
histogram_norm2 = WM_histogram_norm';
histogram_norm3 = GM_histogram_norm';

tissue_model_vect_CSF = zeros(size(testing_labels_vector));
tissue_model_vect_WM = zeros(size(testing_labels_vector));
tissue_model_vect_GM = zeros(size(testing_labels_vector));

for i = 1:range(size(testing_labels_vector))
    
   if(testing_labels_vector(i) == 1)
        
        tissue_model_vect_CSF(i) = histogram_norm1(testing_image_vector(i));
   else
       tissue_model_vect_CSF(i) = 0;
    
   end
   i = i+1;
end

for i = 1:range(size(testing_labels_vector))
    
   if(testing_labels_vector(i) == 2)
    %disp(testing_labels_vector(i));
        tissue_model_vect_WM(i) = histogram_norm2(testing_image_vector(i));
   else
       tissue_model_vect_WM(i) = 0;
    
   end
   i = i+1;
end

for i = 1:range(size(testing_labels_vector))
    
   if(testing_labels_vector(i) == 3)
    %disp(testing_labels_vector(i));
        tissue_model_vect_GM(i) = histogram_norm3(testing_image_vector(i));
   else
       tissue_model_vect_GM(i) = 0;
    
   end
   % = i+1;
end


tissue_flatten_array = zeros(3, length(tissue_model_vect_GM));
tissue_flatten_array(1, :) = tissue_model_vect_CSF;
tissue_flatten_array(2, :) = tissue_model_vect_WM;
tissue_flatten_array(3, :) = tissue_model_vect_GM;

[val,atlas_flatten_array_segmentation] = max(tissue_flatten_array,[],1);

atlas_flatten_array_segmentationdd = atlas_flatten_array_segmentation';


out_testing_labels_vect = (atlas_flatten_array_segmentationdd).* double(testing_mask_vector);

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
 
