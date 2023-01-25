function belief = imassignment(cam, belief)

% current_state
% prev_state
% initial belief
% prediction initially setting to 0

current_state = [];
prev_state = [];

% to be completed
colour = [1,2,3]; %blue,red,black
blue = [0.1, 0.1, 0.1, 0.1, 0.7, 0.1, 0.7, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.7, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.7, 0.1];
red = [0.7, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.7, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.7, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.7];
black = [0.1, 0.7, 0.7, 0.7, 0.1, 0.7, 0.1, 0.7, 0.1, 0.7, 0.7, 0.7, 0.7, 0.1, 0.7, 0.7, 0.1, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.1, 0.1];
%world_map = [];

sensor_model(1,:) = blue;
sensor_model(2,:) = red;
sensor_model(3,:) = black;

for i = 1:25
    current_state(i) = i;
    prev_state(i) = i;
end

up_matrix = [];
down_matrix = [];
right_matrix = [];
left_matrix = [];
for i = 1:length(current_state)
    curr = current_state(i);
    for j = 1:length(prev_state)
        prev = prev_state(j);
        up_res = motion_model(curr,prev,"F");
        up_matrix = [up_matrix, up_res];
        down_res = motion_model(curr,prev,"B");
        down_matrix = [down_matrix, down_res];
        right_res = motion_model(curr, prev, "R");
        right_matrix = [right_matrix, right_res];
        left_res = motion_model(curr, prev, "L");
        left_matrix = [left_matrix, left_res];
    end
end

up_matrix_reshaped = reshape(up_matrix, 25, 25);
up_matrix_reshaped = transpose(up_matrix_reshaped);
down_matrix_reshaped = reshape(down_matrix, 25, 25);
down_matrix_reshaped = transpose(down_matrix_reshaped);
right_matrix_reshaped = reshape(right_matrix, 25, 25);
right_matrix_reshaped = transpose(right_matrix_reshaped);
left_matrix_reshaped = reshape(left_matrix, 25, 25);
left_matrix_reshaped = transpose(left_matrix_reshaped);

for i = 1:1
    % control model

    action = input("F/B/L/R: ", "s");
    %prediction code
    %output Prediction

    for j = 1:length(belief)
        pred_belief(j) = 0
        for k = 1:length(belief)
            if action == "F"
                pred_belief(j) = pred_belief(j) + up_matrix_reshaped(k,j) * belief(k)
            elseif action == "B"
                pred_belief(j) = pred_belief(j) + down_matrix_reshaped(k,j) * belief(k)
            elseif action == "R"
                pred_belief(j) = pred_belief(j) + right_matrix_reshaped(k,j) * belief(k)
            elseif action == "L"
                pred_belief(j) = pred_belief(j) + left_matrix_reshaped(k,j) * belief(k)
            end
        end
    end

    %Sensing and Updation
    %cam = webcam('C270 HD WEBCAM', 'resolution', '1280x720'); %should write
    colour = ColourDetection(cam);
 
    for p = 1:length(pred_belief)
        belief(p) = sensor_model(colour, p) * pred_belief(p);
    end
    eta = 1/(sum(belief));
    belief = eta*belief;

    %heatmap(belief)
end
end