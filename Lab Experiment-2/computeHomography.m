function H = computeHomography(Features, Matches, Model)

N = length(Features);

% Extracting the x and y coordinates of fixed image.
X_fixed = Features(:,1);
Y_fixed = Features(:,2);

% Extracting the x and y coordinates of moving image.
X_moving = Matches(:,1);
Y_moving = Matches(:,2);

% Format features array 
X_fixed = reshape([X_fixed'; zeros(size(X_fixed'))],[],1);
Y_fixed = reshape([Y_fixed'; zeros(size(Y_fixed'))],[],1);
Y_fixed = padarray(Y_fixed,1,0,'pre');  %padarray( A , padsize , padval )
Y_fixed(end)=[];
Features_reform = X_fixed + Y_fixed;

if Model == "Euclidean"
    % Case 3 DOF
    % Solve as similarity
    temp_M = zeros(2*N,4);
    for i=1:N
        temp_M((2*i)-1,:) = [X_moving(i) -Y_moving(i) 1 0];
        temp_M((2*i),:)= [Y_moving(i) X_moving(i) 0 1];
    end
    % Least squares solution approximation
    H = temp_M \ Features_reform;
    a = H(1);
    b = H(2);
    c = H(3);
    d = H(4);

    % Solve for scaling factor
    s = sqrt(a^2 + b^2);
    a = a/s;
    b = b/s;
    H = [a -b c; 
        b a d; 
        0 0 1];


elseif Model == "Similarity"
    % Case 4 DOF
    temp_M = zeros(2*N,4);
    for i=1:N
        temp_M((2*i)-1,:) = [X_moving(i) -Y_moving(i) 1 0];
        temp_M((2*i),:)= [Y_moving(i) X_moving(i) 0 1];
    end

    % Least squares solution approximation
    H = temp_M \ Features_reform;
    H = [H(1) -H(2) H(3);
        H(2) H(1) H(4);
        0 0 1];
        
        
elseif Model == "Affine"
    % Case 6 DOF
    temp_M = zeros(2*N,6);
    for i=1:N
        temp_M((2*i)-1,:) = [X_moving(i) Y_moving(i) 1 0 0 0];
        temp_M((2*i),:) = [0 0 0 X_moving(i) Y_moving(i) 1];
    end
    % Least squares solution approximation
    H = temp_M \ Features_reform;
    H = [H(1) H(2) H(3); 
        H(4) H(5) H(6); 
        0 0 1];
        
        
elseif Model == "Projective"
    % Case 8 DOF
    temp_M = zeros(2*N,8);
    for i=1:N
        temp_M((2*i)-1,:) = [X_moving(i) Y_moving(i) 1 0 0 0 -X_fixed(i)*X_moving(i) -X_fixed(i)*Y_moving(i)];
        temp_M((2*i),:) = [0 0 0 X_moving(i) Y_moving(i) 1 -Y_fixed(i)*X_moving(i) -Y_fixed(i)*Y_moving(i)];
    end

    % Least squares solution approximation
    H = temp_M \ Features_reform;
    H = padarray(H,1,1,'post');
    H = [H(1) H(2) H(3); 
        H(4) H(5) H(6); 
        H(7) H(8) H(9)];
        
    end

end