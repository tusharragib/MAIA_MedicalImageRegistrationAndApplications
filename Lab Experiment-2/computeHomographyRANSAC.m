function [H, err] = computeHomographyRANSAC(Features, Matches, Model)
    
    % Setting threshold value
    thresh = 1;
    
    % Setting the stopping condition for RANSAC
    max_iterations = 5000;
    des_percent_inliers = 0.85;
    
    % Checking nos of Features and Matches
    N = length(Features);
    if length(Features) ~= length(Matches)
        error('Length of features does not match length of matches');
    end
    
    % Start of RANSAC algorithm
    if Model == "Projective"
        num_correspond = 4;
    elseif Model == "Euclidean"
        num_correspond = 2;
    elseif Model == "Affine"
        num_correspond = 3;
    elseif Model == "Similarity"
        num_correspond = 2;
        
    end
    
    best_inliers = [0];
    
    for i=1:max_iterations
        
        %Randomly select from features and matches arrays
        selected_feat = randperm(N, num_correspond);
    

        % Format features array 
        Features_RANSAC = Features(selected_feat,:);
        Matches_RANSAC = Matches(selected_feat,:);
        % Compute H for selected features
        H = computeHomography(Features_RANSAC, Matches_RANSAC, Model);
        
        % Calculate errors
        
        % Apply homography 
        Homogeneous_Matches = [Matches'; ones(1,length(Matches))];
        Transformed_Matches = H * Homogeneous_Matches;
        Transformed_Matches = Transformed_Matches(1:2,:)./Transformed_Matches(3,:);

        % Calculate errors
        Transformed_Matches = Transformed_Matches(1:2,:)';
        sq_diff = (Features - Transformed_Matches).^2;
        sum_sq_diff = sum(sq_diff, 2);
        % Need to square threshold
        thresh_sq = thresh^2;
        %thresh_sq = thresh;
        
        % Check for inliers and outliers
        inliers = sum_sq_diff < thresh_sq;
        num_inliers = sum(inliers);
        percent_inliers = num_inliers/length(Features);
        if percent_inliers > des_percent_inliers
            best_inliers = inliers;
            break;
        end
        
        if percent_inliers > (sum(best_inliers) / length(Features))
            best_inliers = inliers;
        end   
    end
    
    display(strcat('Num. iterations: ', num2str(sum(i))))
    display(strcat('The highest number of inliers: ', num2str(sum(best_inliers))));

    % Compute final H
    Features_RANSAC = Features(best_inliers,:);
    Matches_RANSAC = Matches(best_inliers,:);
    H = computeHomography(Features_RANSAC, Matches_RANSAC, Model);
    err = mean(error(H, Features_RANSAC, Matches_RANSAC))
end