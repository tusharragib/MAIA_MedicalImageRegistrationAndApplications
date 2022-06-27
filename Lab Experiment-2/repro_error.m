function sq_diff = repro_error(H, Features, Matches)

    % Applying homography 
    Homogeneous_Matches = [Matches'; ones(1,length(Matches))];
    Transformed_Matches = H * Homogeneous_Matches;
    Transformed_Matches = Transformed_Matches(1:2,:)./Transformed_Matches(3,:);

    % Applying inverse homography 
    Homogeneous_Features = [Features'; ones(1,length(Features))];
    Transformed_Features = inv(H) * Homogeneous_Features;
    Transformed_Features = Transformed_Features(1:2,:)./Transformed_Features(3,:);
    
    % Calculate errors
    Transformed_Matches = Transformed_Matches(1:2,:)';
    sq_diff1 = (Features - Transformed_Matches).^2;
    sq_diff1 = sqrt(sum(sq_diff1, 2));
    
    Transformed_Features = Transformed_Features(1:2,:)';
    sq_diff2 = (Matches - Transformed_Features).^2;
    sq_diff2 = sqrt(sum(sq_diff2, 2));
    
    sq_diff = sq_diff1 + sq_diff2;
end

