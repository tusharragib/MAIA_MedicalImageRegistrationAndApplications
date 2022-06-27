function [ Iregistered, M] = affineReg2D( Imoving, Ifixed )
%Example of 2D affine registration
%   Robert Martí  (robert.marti@udg.edu)
%   Based on the files from  D.Kroon University of Twente 

% clean
tic;
clear all; close all; clc;

% Read two imges 
Imoving=im2double(rgb2gray(imread('brain4.png'))); 
Ifixed=im2double(rgb2gray(imread('brain2.png')));

Im=Imoving;
If=Ifixed;

mtype = 'gcc'; % metric type: sd: ssd gcc: gradient correlation; cc: cross-correlation
ttype = 'a'; % rigid registration, options: r: rigid, a: affine

% Parameter scaling of the Translation and Rotation
% and initial parameters
switch ttype
    case 'r'

        x=[0 0 0];
        scale = [1 1 0.1];
    case 'a'
        %x=[0 1 0.3 2 1 0 0];
        x=[0 0 0 1 1 0 0];
        scale = [1 1 0.1 1 1 0.0001 0.0001];
end;



x=x./scale;
    
    
[x]=fminsearch(@(x)affine_registration_function(x,scale,Im,If,mtype,ttype),x,optimset('Display','iter','MaxIter',1000, 'TolFun', 1.000000e-10,'TolX',1.000000e-10, 'MaxFunEvals', 1000*length(x)));

x=x.*scale;

switch ttype
	case 'r'
        % Make the affine transformation matrix
         M=[ cos(x(3)) sin(x(3)) x(1);
            -sin(x(3)) cos(x(3)) x(2);
           0 0 1];

 
        case 'a'
        % Make the affine transformation matrix
        M_rotate=[ cos(x(3)) sin(x(3)) x(1);
            -sin(x(3)) cos(x(3)) x(2);    
           0 0 1];
       
       M_scale = [x(4) 0 0;
        0 x(5) 0;
        0 0 1];

        M_shear =[1 x(6) 0;
        x(7) 1 0;
        0 0 1];
       
        M=M_rotate*M_scale*M_shear;
end;

     

 % Transform the image 
Icor=affine_transform_2d_double(double(Im),double(M),0); % 3 stands for cubic interpolation


% Show the registration results
figure,
subplot(2,2,1), imshow(If), title('Fixed Image');
subplot(2,2,2), imshow(Im), title('Moving Image');
subplot(2,2,3), imshow(Icor), title('Corrected Image');
subplot(2,2,4), imshow(abs(If-Icor)), title('(Fixed-Corrected) Image');

ssimval = ssim(Icor,If);

% Parameters Findings and Printing/Displaying 
switch ttype
    case 'r'
    fprintf('\n -------------Rigid Parameters------------ \n \n ');
    fprintf('Translation in X dirrection is %.4f \n \n',x(1));
    fprintf('Translation in Y dirrection is %.4f \n \n',x(2));
    fprintf('Rotation about M/2 and N/2 is %.4f \n \n',x(3));
    fprintf('Best quantative metric (%s) is %.4f \n \n',mtype, ssimval);
    
    case 'a'
    fprintf('\n -------------Affine Parameters------------ \n \n ');
    fprintf('Translation in X dirrection is %.4f \n \n ',x(1));
    fprintf('Translation in Y dirrection is %.4f \n \n',x(2));
    fprintf('Rotation about M/2 and N/2 is %.4f \n \n',x(3));
    fprintf('Scaling in X direction is %.4f \n \n',x(4));
    fprintf('Scaling in Y direction is %.4f \n \n',x(5));
    fprintf('Horizontal Shearing is %.4f \n \n',x(6));
    fprintf('Vertical Shearing is %d \n \n',x(7));
    fprintf('Best quantative metric (%s) is %.4f \n \n',mtype, ssimval);
end

toc;

end



