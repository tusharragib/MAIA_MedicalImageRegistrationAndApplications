function [ Iregistered, M] = affineReg2D( Imoving, Ifixed )
%Example of 2D affine registration
%   Robert Martí  (robert.marti@udg.edu)
%   Based on the files from  D.Kroon University of Twente 

% clean
tic;
clear all; close all; clc;

% Read two imges 
Imoving=im2double(rgb2gray(imread('brain1.png'))); 
Ifixed=im2double(rgb2gray(imread('brain2.png')));

Im=Imoving;
If=Ifixed;

mtype = 'sd'; % metric type: sd: ssd gcc: gradient correlation; cc: cross-correlation
ttype = 'r'; % rigid registration, options: r: rigid, a: affine

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
% numofSubsmp = the number of downsampling
numofSubsmp = 5;
sigma = 1.5;
imageCell = cell(1,numofSubsmp+1);
imageCellif = cell(1,numofSubsmp+1);
imageCell{1} = Im;
imageCellif{1} = If;
%determine number of rows and cols for subplot 
sub.r= max(1,round( (3/4)*sqrt(numofSubsmp+1) ));
sub.c= max(1,ceil( (numofSubsmp+1)/sub.r ));

for subsample = 1: (numofSubsmp+1)
  
   im = imageCell{subsample};
   iF = imageCellif{subsample};
   filtered_image = imgaussfilt(imageCell{subsample},sigma);
   filtered_image_if = imgaussfilt(imageCellif{subsample},sigma);
   imageCell{subsample+1} = imresize(filtered_image, 0.5);
   imageCellif{subsample+1} = imresize(filtered_image_if, 0.5);
       
    [x]=fminsearch(@(x)affine_registration_function(x,scale,imageCell{subsample+1},imageCellif{subsample+1},mtype,ttype),x,optimset('Display','iter','MaxIter',1000, 'TolFun', 1.000000e-10,'TolX',1.000000e-10, 'MaxFunEvals', 1000*length(x)));

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
Icor=affine_transform_2d_double(double(imageCellif{subsample+1}),double(M),0); % 3 stands for cubic interpolation


% Show the registration results
figure,
subplot(2,2,1), imshow(imageCellif{subsample+1}), title('Fixed Image');
subplot(2,2,2), imshow(imageCell{subsample+1}), title('Moving Image');
subplot(2,2,3), imshow(Icor), title('Corrected Image');
subplot(2,2,4), imshow(abs(imageCellif{subsample+1}-Icor)), title('(Fixed-Corrected) Image');

ssimval = ssim(Icor,imageCellif{subsample+1});

%Plotting the metric against iterations
    figure(20); 
    hold on
    plot(subsample,ssimval); 
    xlabel('Number of iterations')
    ylabel('Metric')
    scatter(subsample,ssimval);

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

end


for subsample = numofSubsmp+1: -1: 1
   im = imageCell{subsample};
   iF = imageCellif{subsample};
   %subplot(sub.r,sub.c,subsample);
   %imshow(im);
   %imshow(iF);
   %title(sprintf('Image %d',subsample));
   
   %Upsampling using deconvolution
   PSF=fspecial('gaussian',10, sigma);
   [filtered_image LAGRA] = deconvreg(imageCell{subsample},PSF);
   [filtered_image_if LAGRA] = deconvreg(imageCellif{subsample},PSF);
   imageCell{subsample+1} = imresize(filtered_image, 2);
   imageCellif{subsample+1} = imresize(filtered_image_if, 2);
       
   [x]=fminsearch(@(x)affine_registration_function(x,scale,imageCell{subsample+1},imageCellif{subsample+1},mtype,ttype),x,optimset('Display','iter','MaxIter',1000, 'TolFun', 1.000000e-10,'TolX',1.000000e-10, 'MaxFunEvals', 1000*length(x)));

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
Icor=affine_transform_2d_double(double(imageCellif{subsample+1}),double(M),0); % 3 stands for cubic interpolation


% Show the registration results
figure,
subplot(2,2,1), imshow(imageCellif{subsample+1}), title('Fixed Image');
subplot(2,2,2), imshow(imageCell{subsample+1}), title('Moving Image');
subplot(2,2,3), imshow(Icor), title('Corrected Image');
subplot(2,2,4), imshow(abs(imageCellif{subsample+1}-Icor)), title('(Fixed-Corrected) Image');

ssimval = ssim(Icor,imageCellif{subsample+1});

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

end


toc;

end