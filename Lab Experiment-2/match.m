function [feat_fixed, feat_moving, fixed, moving] = match(Ia, Ib)
    % Function to obtain matches using vlfeat with two images
    
    % Returns:
    % Features (Fixed): Nx2 matrices storing the features in the image Ia[x, y]
    % Matches (Moving): Nx2 matrices storing the correspondences in the image Ib[x', y']
   
    %Adding the VL_feat's paths
    addpath('./vlfeat-0.9.21/toolbox/demo');
    addpath('./siftDemoV4')
    run('./vlfeat-0.9.21/toolbox/vl_setup')
    
    peak_thresh = 0;

    [fa,da] = vl_sift(im2single(rgb2gray(Ia)), 'PeakThresh', peak_thresh) ;
    [fb,db] = vl_sift(im2single(rgb2gray(Ib)), 'PeakThresh', peak_thresh) ;

    [matches, scores] = vl_ubcmatch(da,db);   %Scores: Squared Euclidean distance between the matches

    [value, idx] = sort(scores, 'descend');
    matches = matches(:, idx) ;

    xa = fa(1,matches(1,:));
    xb = fb(1,matches(2,:));
    ya = fa(2,matches(1,:));
    yb = fb(2,matches(2,:));
    
    feat_fixed = [fa; da]';
    feat_moving = [fb; db]';
    
    fixed = [xa; ya]';   %Fixed Image
    moving = [xb; yb]';  %Moving Image    
end