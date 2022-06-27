clc;
clear all;
close all;
%Reading one image for taking the size of slices
image_000 = niftiread('training-set/training-images/1000.nii.gz');
int_label = zeros(size(image_000));
size22 = size(int_label);
int_label_reshaped = reshape(int_label, numel(int_label), 1);
size_of_vector = length(int_label_reshaped);

%Reading training labels and reshaping it 
training_labels = niftiread('training-set/registered_labels/01/bspline/result.nii.gz');
training_labels_vector = reshape(training_labels, numel(training_labels), 1);

%Array with indexed for folders
folder_index = {'01'; '02'; '06'; '07'; '08'; '09'; '10'; '11'; '12'; '13'; '14'; '15'; '17'; '36'};
len_files = length(folder_index);
volume_reshaped = zeros(size_of_vector,len_files);
label_reshaped = zeros(size_of_vector,len_files);
path_directory_volume='training-set/registered_images/'; 
path_directory_label='training-set/registered_labels/'; 

%reading all images=volumes with labels after final registraion - bspline,
%save all volumes and labels to 2 array with length(label_reshaped) and
%number of files (14).
for index=1:length(folder_index)
    files_volume=strcat(path_directory_volume, folder_index{index} , '/bspline/result.0.nii.gz'); 
    filename_volume=files_volume;
    
    files_label=strcat(path_directory_label, folder_index{index} , '/bspline/result.nii.gz'); 
    filename_label=files_label;
    
    volume= niftiread(filename_volume);
    label= niftiread(filename_label);
    volume_resh= reshape(volume, numel(volume), 1);
    label_resh= reshape(label, numel(label), 1);
    
    volume_reshaped(:,index) = volume_resh;
    label_reshaped(:,index) = label_resh;
    disp(filename_volume);
    disp(filename_label);
end



tissue_model_vector_GM = [];
tissue_model_vector_WM = [];
tissue_model_vector_CSF = [];

disp(unique(im_mask_WM));
disp(unique(im_mask_WM));
%Reading the array of all volumes to create tissue model
for index2 = 1:1
  vol_index = volume_reshaped(:, index2);
  var = label_reshaped(:, index2);
  im_mask_CSF = (var == 1);
  maskCSF=~im_mask_CSF;
  compressed_CSF = vol_index(~maskCSF);
  tissue_model_vector_CSF = cat(1, [tissue_model_vector_CSF; compressed_CSF]);
  
  var2 = label_reshaped(:, 1);
  im_mask_WM = (var2 == 2);
  maskWM=~im_mask_WM;
  compressed_WM = vol_index(~maskWM);
  tissue_model_vector_WM = cat(1, [tissue_model_vector_WM; compressed_WM]);
    
    
  im_mask_GM = (var == 3);
  maskGM=~im_mask_GM;
  compressed_GM = vol_index(~maskGM);
  tissue_model_vector_GM = cat(1, [tissue_model_vector_GM;compressed_GM]);

end

figure(1);
iTP_CSF = histogram(tissue_model_vector_CSF,5000);
counts_CSF = iTP_CSF.Values;
title('Histogram of CSF');

figure(2);
iTP_WM = histogram(tissue_model_vector_WM,5000);
counts_WM = iTP_WM.Values;
title('Histogram of WM');

figure(3);
iTP_GM = histogram(tissue_model_vector_GM,5000);
counts_GM = iTP_GM.Values;
title('Histogram of GM');


histogram_norm_CSF = counts_CSF./(counts_CSF+counts_WM+counts_GM);
histogram_norm_CSF(isnan(histogram_norm_CSF))=0;

histogram_norm_WM = counts_WM./(counts_CSF+counts_WM+counts_GM);
histogram_norm_WM(isnan(histogram_norm_WM))=0;

histogram_norm_GM = counts_GM./(counts_CSF+counts_WM+counts_GM);
histogram_norm_GM(isnan(histogram_norm_GM))=0;

figure(4);
hold on
x=0:4999;
scatter(x,histogram_norm_CSF);
scatter(x,histogram_norm_WM);
scatter(x,histogram_norm_GM);
xlabel('Pixel intensty');
ylabel('Histogram probability');
legend('CSF','WM','GM');


save('hist_norm/histogram_norm_CSF.mat','histogram_norm_CSF');

save('hist_norm/histogram_norm_WM.mat','histogram_norm_WM');

save('hist_norm/histogram_norm_GM.mat','histogram_norm_GM');


CSF_array = (label_reshaped==1);
CSF_vect = mean(CSF_array, 2);
CSF_prob_map = reshape(CSF_vect, size22(1), size22(2), size22(3));

WM_array = (label_reshaped==2);
WM_vect = mean(WM_array, 2);
WM_prob_map = reshape(WM_vect, size22(1), size22(2), size22(3));

GM_array = (label_reshaped==3); 
GM_vect = mean(GM_array, 2);
GM_prob_map =reshape(GM_vect, size22(1), size22(2), size22(3));


tissue_model_vect = mean(volume_reshaped, 2);
tissue_model = reshape(tissue_model_vect, size22(1), size22(2), size22(3));
tissue_model = imrotate(tissue_model,180);
CSF_prob_map = imrotate(CSF_prob_map,180);
WM_prob_map = imrotate(WM_prob_map,180);
GM_prob_map = imrotate(GM_prob_map,180);

niftiwrite(CSF_prob_map,'atlas/CSF_prob_map.nii', 'Compressed',true);
niftiwrite(WM_prob_map,'atlas/WM_prob_map.nii', 'Compressed',true);
niftiwrite(GM_prob_map,'atlas/GM_prob_map.nii', 'Compressed',true);
niftiwrite(tissue_model,'atlas/tissue_model.nii', 'Compressed',true);

%Reconstruction of slices
 for i = 150
    figure(2),
    hold on;
    
    subplot(2,3,1);
    imshow(double(CSF_prob_map(:,:,i)));
    title('CSF_prob_map')
   
    subplot(2,3,2);   
    imshow(double(WM_prob_map(:,:,i)));
    title('WM_prob_map')
   
    subplot(2,3,3);
    imshow(double(GM_prob_map(:,:,i)));
    title('GM_prob_map')  
    
    subplot(2,3,4);
    imshow(double(tissue_model(:,:,i)), []);
    title('tissue_model')
   
    
    pause(1)
    
 end
 
