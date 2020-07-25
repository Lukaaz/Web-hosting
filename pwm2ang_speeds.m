function des_inputs = pwm2ang_speeds(pwm)
    % des_nputs:
        % pwm - 4x1, pwm value into the motors
        
    % outputs:
        % des_inputs - 4x1, angular speeds on the motors
     
    % function:
        % convert PWM values to the motors into the angular speeds of the
        % motors

    global pq;
    des_inputs = (pwm-1000) * pq.max_omega / 1000;
end