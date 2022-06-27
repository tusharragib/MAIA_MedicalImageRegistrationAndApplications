function [tre_mean,tre_std] = tre(pointsI, pointsE, voxel_spacing)
registered_array = [];
for i = 4:6:1800
    if i == 4
        d = pointsI{1}(i,1);
        k = d{1}(1,22:31);
        n = str2num(k);
        registered_array = vertcat(registered_array,n);
    else
        d = pointsI{1}(i,1);
        k = d{1}(1,22:31);
        n = str2num(k);
        registered_array = vertcat(registered_array,n);
    end

end
% inputs to the TRE calculation function
voxel_spacing = voxel_spacing;
target_points = pointsE; 



%[tre_mean,tre_std] = calculateTRE(target_points, registered_points, voxel_spacing);

voxel_mm = [voxel_spacing];
dim_points = size(target_points,2);
num_points = size(target_points,1)/3;
voxel_mm = repmat(voxel_mm,[num_points, dim_points]);

registered_points = reshape(registered_array', size(pointsE));

target_points_mm = target_points.*voxel_mm;
registered_points_mm = registered_points.*voxel_mm;


target_points_mm = reshape(target_points_mm',[dim_points*3,num_points]);
registered_points_mm = reshape(registered_points_mm',[dim_points*3,num_points]);


for i = 1:num_points
    tre(i) = sqrt(sum((target_points_mm(:,i)-registered_points_mm(:,i)).^2));
end
tre_mean = mean(tre);
tre_std = std(tre);




end

