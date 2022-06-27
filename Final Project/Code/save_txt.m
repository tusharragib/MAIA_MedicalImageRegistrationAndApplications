clc; clear all; close all;
% paths for inputs
image = 'copd1';
folder_reg_ = strcat('registered\', image, '\transformix\');
name_Ifile_land = 'outputpoints.txt';
%Read trsnformed landmarks of inhale
landmarksI = fopen(strcat(folder_reg_, name_Ifile_land));
%Read trsnformed landmarks of exhale
copd1_300_iBH_xyz = textscan(landmarksI,'%s','Delimiter',';');
registered_array = [];
%Loop to take only output points
for i = 4:6:1800
    if i == 4
        d = copd1_300_iBH_xyz{1}(i,1);
        k = d{1}(1,22:31);
        n = str2num(k);
        registered_array = vertcat(registered_array,n);
    else
        d = copd1_300_iBH_xyz{1}(i,1);
        k = d{1}(1,22:31);
        n = str2num(k);
        registered_array = vertcat(registered_array,n);
    end

end
writematrix(registered_array,strcat('t_', image, '_300_iBH_xyz_r1.txt'));
