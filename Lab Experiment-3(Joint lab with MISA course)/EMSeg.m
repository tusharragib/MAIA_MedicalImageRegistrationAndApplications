function [dice_coef] = EMSeg(test_image, test_label)
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