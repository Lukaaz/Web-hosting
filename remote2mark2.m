function des_TPRY = remote2mark2(remote_inputs)
    % inputs:
        % remote_inputs - 4x1, pwm value from the remote
        
    % outputs:
        % des_inputs - 4x1, angular speeds on the motors
     
    % function:
        % convert PWM values to the motors into the angular speeds of the
        % motors
    
    remote_inputs = remote_inputs - [1000; 1500; 1500; 1500];
    
    des_TPRY = zeros(4,1);
    des_TPRY(1) = remote_inputs(1); % thrust, 0 to 1k
    des_TPRY(2) = remote_inputs(2)/500 * pi; % yaw rate, -pi to pi rad/s
    des_TPRY(3) = remote_inputs(3)/500 * pi/4; % pitch, -pi/4 to pi/4 rad
    des_TPRY(4) = remote_inputs(4)/500 * pi/4; % roll, -pi/4 to pi/4 rad

end