function probability = motion_model(current_state, prev_state, action)

diff_state = current_state - prev_state;
right_ends = [5,10,15,20,25];
left_ends = [21,16,11,6,1];

if action == "F"
    if diff_state == 5
        probability = 0.8;
    elseif diff_state == 0 || diff_state == 10
        probability = 0.1;
    else
        probability = 0;
    end

elseif action == "L"
    if diff_state == 1
        probability = 0.8;
        if ismember(current_state, left_ends) == 1
            probability = 0;
        end
    elseif diff_state == 0
        probability = 0.1;
    elseif diff_state == 2
        probability = 0.1;
        if ismember(current_state, left_ends) == 1
            probability = 0;
        end
    else
        probability = 0;
    end

elseif action == "B"
    if diff_state == -5
        probability = 0.8;
    elseif diff_state == 0 || diff_state == -10
        probability = 0.1;
    else
        probability = 0;
    end

elseif action == "R"
    if diff_state == -1
        probability = 0.8;
        if ismember(current_state, right_ends) == 1
            probability = 0;
        end
    elseif diff_state == 0
        probability = 0.1;
    elseif diff_state == -2
        probability = 0.1;
        if ismember(current_state, right_ends) == 1
            probability = 0;
        end
    else
        probability = 0;
    end
end
