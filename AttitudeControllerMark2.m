function des_inputs = AttitudeControllerMark2(state, desired)
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

    % Get states
    % state_measured_last = state_measured;
    % state_measured(1) = [x;y;z]                   world frame
    % state_measured(2) = [dx; dy; dz]              world frame
    % state_measured(3) = [phi; theta; psi]         ~body/world? frame       (roll; pitch; yaw)
    % state_measured(4) = [dphi; dtheta; dpsi]      ~body/world? frame
    % state_measured(5) = [omega_x; omega_y; omega_z]  
    psi = state(3,3); 
    phi = state(3,1); d_phi = state(4,1);
    theta = state(3,2);  d_theta = state(4,2);
    
    thrust = desired(1); yaw_rate = desired(2); pitch = desired(3); roll = desired(4);

    % Do PID variables
    Kp_yaw = 1;
    Kp_pitch = 1; Kd_pitch = 1;
    Kp_roll = 1; Kd

    % direct control on thrust
    T = thrust; % T is the force

    % P control on yaw
    Y = Kp_yaw * (psi - yaw_rate);

    % PD control on pitch
    P = Kp_pitch * (phi - pitch) + Kd_pitch * (d_phi - 0);

    % PD control on pitch
    R = Kp_roll * (theta - roll) + Kd_roll * (d_theta - 0);

    TPRY = [T; P; R; Y] / 4;

    tpry2m = [ 1  1 -1  1;
               1  1  1 -1;
               1 -1  1  1;
               1 -1 -1 -1];

    des_inputs = tpry2m * (TPRY);

    % enfroce maximums
    des_inputs = max(des_inputs, 0);
    des_inputs = min(des_inputs, 1000);
    % add a 1000 for pwm
    des_inputs = des_inputs + 1000;
end