function [dice_coef] = EMSeg(testing_mask_vector, test_image, test_label, CSF_atlas_vector_resh, WM_atlas_vector_resh, GM_atlas_vector_resh)
T1_nii = test_image;
Label_nii = test_label;
%Load the NIFTI Volume for Input Images and GroundTruth  

testing_image =  reshape(T1_nii,numel(T1_nii),1);
testing_labels =  reshape(Label_nii,numel(Label_nii),1);

% Let's reshape nii files to the vector
T1_reshaped= reshape(T1_nii,numel(T1_nii),1);
Label_reshaped= reshape(Label_nii,numel(Label_nii),1);

%Remove 0-s pixels
Label_black= find(~Label_reshaped);
Label_black_no= find(Label_reshaped);


T1_reshaped(Label_black)=[];
nii_files= [T1_reshaped] ;
nii_files=double(nii_files);


testing_mask= reshape(test_mask, numel(test_mask), 1);

testing_image_roi = testing_image.*single(testing_mask);

CSF_atlas = CSF_atlas_vector_resh;
WM_atlas = WM_atlas_vector_resh;
GM_atlas = GM_atlas_vector_resh;

im_mask = (testing_labels > 0);
CSF_atlas_flatten = CSF_atlas(im_mask);
WM_atlas_flatten = WM_atlas(im_mask);
GM_atlas_flatten = GM_atlas(im_mask);

atlas_flatten_array = zeros(3, length(CSF_atlas_flatten));
atlas_flatten_array(1, :) = CSF_atlas_flatten;
atlas_flatten_array(2, :) = WM_atlas_flatten;
atlas_flatten_array(3, :) = GM_atlas_flatten;


testing_image_flatten = testing_image_roi(im_mask);
[val,atlas_flatten_array_segmentation] = max(atlas_flatten_array,[],1);
mu = zeros(3,1); 
csf = (atlas_flatten_array_segmentation==1);
wm = (atlas_flatten_array_segmentation==2);
gm = (atlas_flatten_array_segmentation==3);
mu(1,:) = mean(testing_image_flatten(csf));
mu(2,:) = mean(testing_image_flatten(wm));
mu(3,:) = mean(testing_image_flatten(gm));


%membership_weights = zeros(3,1); 
atlas_flatten_array_segmentationdd = atlas_flatten_array_segmentation';
membership_weights(:,1) = (atlas_flatten_array_segmentationdd == 1);
membership_weights(:,2) = (atlas_flatten_array_segmentationdd == 3);
membership_weights(:,3) = (atlas_flatten_array_segmentationdd == 2);
Nk = [sum(atlas_flatten_array_segmentationdd == 1),sum(atlas_flatten_array_segmentationdd == 3),sum(atlas_flatten_array_segmentationdd == 2)];
X=testing_image_flatten';

for i=1:3
    dummy_var = (X-mu(i))';
    xx = (X-mu(i));
end

for i=1:3
    dummy_var = (X-mu(i))';
    xx = (X-mu(i));
    npmultiply = membership_weights(:,i) .* dummy_var;
    c = npmultiply .* xx';
    %co(i) =sum(c*gg);
    co(i) = (1/Nk(i)) *(npmultiply' * xx');
end


alpha = zeros(1, 3);  

for i=1:3
  alpha(i) = Nk(i)/length(X); 
end
  
cluster_number = 3;
number_iterations = 100;
stop_threshold = 0.0000001;
% stop_threshold = 0.0000001;

for number_iter = 1:number_iterations
    
    %e-step
    
    p = estep(cluster_number, nii_files, alpha, mu, co);
    sums = sum(p);
    log_sums=sum(log(sums));
    log_current=sum(log(log_sums));
    w=(p ./ sums);
    
    %m-step
    [mu, co] = mstep(cluster_number, nii_files, w, alpha, mu, co);
    
  p = estep(cluster_number, nii_files, alpha, mu, co);
    %sums = sum(p);
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
file_reshaped=zeros(length(testing_image), 1);
number_slices=256;
file_reshaped(Label_black)=0;
file_reshaped(Label_black_no)=class;
size_Label=size(Label_nii);
result_segmented=reshape(file_reshaped,size_Label(1),size_Label(2),size_Label(3));

result_segmented2 = imrotate(result_segmented,90);
Label_nii2 = imrotate(Label_nii,90);
 %Reconstruction of slices
 for i = 160
   imshowpair(double(Label_nii2(:,:,i)),label2rgb(result_segmented2(:,:,i), 'hsv' ,'k'), 'montage')
   title('GT (Left) and Segmented (Right) for slice = ')
     pause(1)
    
 end
 
 
 %Dice Similarity function 

segmented_data = reshape(result_segmented,numel(result_segmented),1);
groundtruth_data = Label_reshaped;

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
