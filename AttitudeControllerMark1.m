function des_inputs = AttitudeControllerMark1(state, desired)

    % des_nputs:
        % state - 3x5, usual state matrix variable
        % desired: 4x1, [thrust; yaw_rate; pitch; roll];
        % Thrust - PWM value
        % yaw rate - rad/s
        % pitch - rad
        % roll - rad
    % outputs:
        % inputs - 4x1, PWM inputs to individual motors, 
     
    % function:
        % apply given thrust, P on yaw rate, PD on roll and pitch
        
%     desired_TPRY = desired;
    
    desired_TPRY = [ 2 0 0 0;
                     0 0 0 0];
                 
               % P D   P > 0, D < 0
    PID =       [800 300; % Thrust P D gains
                 40 15; % Pitch P D gains
                 40 15; % Roll P D gains 
                 200 100]; % Yaw P D gains


    % state_measured_last = state_measured;
    % state_measured(1) = [x;y;z]                   world frame
    % state_measured(2) = [dx; dy; dz]              world frame
    % state_measured(3) = [phi; theta; psi]         ~body/world? frame       (roll; pitch; yaw)
    % state_measured(4) = [dphi; dtheta; dpsi]      ~body/world? frame
    % state_measured(5) = [omega_x; omega_y; omega_z]  
    sm = state;

    % z P R Y
    now_states = [sm(3,1) sm(2,3) sm(1,3) sm(3,3); % proportional error
                  sm(3,2) sm(2,4) sm(1,4) sm(3,4)  % derivative error
                   ];   

    errors = desired_TPRY - now_states;

    tpry2m = [ 1  1 -1  1;
               1  1  1 -1;
               1 -1  1  1;
               1 -1 -1 -1];


    ff_T = sqrt(pq.m * pq.g / (4 * pq.Kf)); % total thrust required to keep drone stable in theory
    TPRY = diag(PID * errors) + [ff_T;0;0;0]; % get the TPRY values
    des_inputs = tpry2m * (TPRY);

    des_inputs = max(des_inputs, 0);
    des_inputs = min(des_inputs, pq.max_omega);
end