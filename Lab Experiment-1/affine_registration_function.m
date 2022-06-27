function [e]=affine_registration_function(par,scale,Imoving,Ifixed,mtype,ttype)
% This function affine_registration_image, uses affine transfomation of the
% 3D input volume and calculates the registration error after transformation.
%
% I=affine_registration_image(parameters,scale,I1,I2,type);
%
% input,
%   parameters (in 2D) : Rigid vector of length 3 -> [translateX translateY rotate]
%                        or Affine vector of length 7 -> [translateX translateY  
%                                           rotate resizeX resizeY shearXY shearYX]
%
%   parameters (in 3D) : Rigid vector of length 6 : [translateX translateY translateZ
%                                           rotateX rotateY rotateZ]
%                       or Affine vector of length 15 : [translateX translateY translateZ,
%                             rotateX rotateY rotateZ resizeX resizeY resizeZ, 
%                             shearXY, shearXZ, shearYX, shearYZ, shearZX, shearZY]
%   
%   scale: Vector with Scaling of the input parameters with the same lenght
%               as the parameter vector.
%   I1: The 2D/3D image which is affine transformed
%   I2: The second 2D/3D image which is used to calculate the
%       registration error
%   mtype: Metric type: s: sum of squared differences.
%
% outputs,
%   I: An volume image with the registration error between I1 and I2
%
% example,
%
% Function is written by D.Kroon University of Twente (July 2008)
x=par.*scale;

    switch ttype
        case 'r'
        % Make the affine transformation matrix
         M=[ cos(x(3)) sin(x(3)) x(1);
            -sin(x(3)) cos(x(3)) x(2);
           0 0 1];
 
        case 'a'
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


I3=affine_transform_2d_double(double(Imoving),double(M),0); % 3 stands for cubic interpolation
% metric computation
switch mtype
        
    case 'sd' %squared differences
        e=sum((I3(:)-Ifixed(:)).^2)/numel(I3);
    case 'cc' %normalized cross-correlation
        e = sum((I3(:) - mean(I3(:))).*(Ifixed(:) - mean(Ifixed(:)))) / sqrt((sum((I3(:) - mean(I3(:))).^2)*sum( (Ifixed(:) - mean(Ifixed(:)) ) )).^2);
        e=inv(e);
    case 'gcc' %grad normalized cross-correlation
        % let's find the [Gxi, Gyi] for Moving and [Gxf, Gyf] Fixed images
        [Gxi, Gyi] = imgradientxy(I3, 'sobel');
        [Gxf, Gyf] = imgradientxy(Ifixed, 'sobel');
        % let's find the Gmagi and Gmagf magnitude for Moving and Fixed images
        Gmagi = sqrt(Gxi.^2 +Gyi.^2);
        Gmagf = sqrt(Gxf.^2 +Gyf.^2);
        e = (sum(Gxi.*Gxf + Gyi.*Gyf)+ eps)/(sum(Gmagi.*Gmagf) + eps);
    otherwise
        error('Unknown metric type');
        
        
   
end;


