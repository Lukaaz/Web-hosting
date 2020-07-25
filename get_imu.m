function [specific_acc_b, angVel_b] = get_imu(last_state, now_state, delta_time)
    % return acceleration and gyroscope measurements from the simulated
    % both are 3x1 vectors
    
    % state(1) = [x;y;z]
    % state(2) = [dx; dy; dz]
    % state(3) = [phi; theta; psi] (roll; pitch; yaw)
    % state(4) = [dphi; dtheta; dpsi]
    % state(5) = [omega_x; omega_y; omega_z] 
    global pq;
    global r;
    angVel_b = now_state(:, 5) % gyro reading in body frame
    acc_w = (now_state(:,2) - last_state(:,2)) / delta_time; % acceleration in global frame
    specific_acc_w = acc_w + [0;0;pq.g];  % specific acceleration in global frame
    specific_acc_b = w2b(r, specific_acc_w, now_state(:, 3)); %rotate the acceleration measurements to get body frame measurements
    
    % apply some fucking noise
    IMU = imuSensor('accel-gyro');
    IMU.Gyroscope.NoiseDensity = 2e-2; % (rad/s)/sqrt(Hz)
    IMU.Gyroscope.BiasInstability = 5.0e-2; % rad/s
    IMU.Gyroscope.RandomWalk = 0.7e-1; % (rad/s)*sqrt(Hz)
%     IMU.Gyroscope.ConstantBias = [0.02 0.02 0.02]; % rad/s
    IMU.Gyroscope.ConstantBias = [0 0 0]; % rad/s
    
    IMU.Accelerometer.NoiseDensity = 2e-2; % (rad/s)/sqrt(Hz)
    IMU.Accelerometer.BiasInstability = 5.0e-2; % rad/s
    IMU.Accelerometer.RandomWalk = 0.7e-1; % (rad/s)*sqrt(Hz)
    [a, g] = IMU([0 0 9.81 ], [0 0 0] );
    specific_acc_b = specific_acc_b + a';    
    angVel_b = angVel_b + g';
  
    
    
    %     acc = w2b(r, acc, now_state(:, 3)); % acceleration in body frame
    
%     [accel, gyro] = IMU(acc', angVel', quaternion(eul2quat(now_state(:, 3)')) );
%     acc = (now_state(:,2) - last_state(:,2))/pq.dt; % acceleration in global frame
%     acc = w2b(r, acc, now_state(:, 3)); % acceleration in body frame
%     [accel, gyro] = IMU(acc', angVel', quaternion(eul2quat(now_state(:, 3)')) );
end