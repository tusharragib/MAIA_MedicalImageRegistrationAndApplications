function [dice_coef] = EMAtlasSeg(test_image, test_label, testing_image_vector, testing_labels_vector, testing_mask_vector, CSF_atlas_vector_resh, WM_atlas_vector_resh, GM_atlas_vector_resh)
T1_nii = test_image;
Label_nii = test_label;  
 
% Let's reshape nii files to the vector
T1_reshaped= reshape(T1_nii,numel(T1_nii),1);
Label_reshaped= reshape(Label_nii,numel(Label_nii),1);
%Remove 0-s pixels
Label_black= find(~Label_reshaped);
Label_black_no= find(Label_reshaped);
T1_reshaped(Label_black)=[];
nii_files= [T1_reshaped] ;
nii_files=double(nii_files);
%Let's initialize parameters
alpha = [1/3 1/3 1/3];
mean = [100 200 500];
covariance = [1000  2000  1000];
cluster_number = 3;
number_iterations = 10;
stop_threshold = 0.0001;
% stop_threshold = 0.0000001;
for number_iter = 1:number_iterations
    %e-step
    p = estep(cluster_number, nii_files, alpha, mean, covariance);
    sums = sum(p);
    log_sums=sum(log(sums));
    log_current=sum(log(log_sums));
    w=(p ./ sums);

    %m-step
    [mean, covariance] = mstep(cluster_number, nii_files, w, alpha, mean, covariance); 
    p = estep(cluster_number, nii_files, alpha, mean, covariance);
    sums = sum(p);
    log_sums=sum(log(sums));
    log_updated=sum(log(log_sums));
    Error=log_updated-log_current;
    Diff_Error(number_iter)=Error;   
     if(abs(Error)<stop_threshold) 
        break; 
    end 
    number_iter=number_iter+1;
end

w2=w';
[~,class]=max(w2);
% Reshape to the image with 0-s pixels
file_reshaped=zeros(length(nii_files), 1);
number_slices=256;
file_reshaped(Label_black)=0;
file_reshaped(Label_black_no)=class;
size_Label=size(Label_nii);
result_segmented=reshape(file_reshaped,size_Label(1),size_Label(2),size_Label(3));

CSF_EM_vector = (file_reshaped == 1);
WM_EM_vector = (file_reshaped == 2);
GM_EM_vector = (file_reshaped == 3);


atlas_EM_array = zeros(length(testing_mask_vector), 3);
atlas_EM_array(:,1) = CSF_atlas_vector_resh .* CSF_EM_vector;
atlas_EM_array(:,2) = WM_atlas_vector_resh .* WM_EM_vector;
atlas_EM_array(:,3) = GM_atlas_vector_resh .* GM_EM_vector;


[val,idx] = max(atlas_EM_array,[],2) ;

out_testing_labels_atlas_EM = (idx).* double(testing_mask_vector);
out_testing_labels_atlas_EM_resh = reshape(out_testing_labels_atlas_EM, size(test_image));

result_segmented2 = imrotate(out_testing_labels_atlas_EM_resh,90);
Label_nii2 = imrotate(test_label,90);
figure();
imshowpair(double(Label_nii2(:,:,160)),label2rgb(result_segmented2(:,:,160), 'hsv' ,'k'), 'montage')

segmented_data = out_testing_labels_atlas_EM;
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

