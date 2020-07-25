function state = apply_environmental_disturbance(state_now)
    % state(1) = [x;y;z]
    % state(2) = [dx; dy; dz]
    % state(3) = [phi; theta; psi] (roll; pitch; yaw)
    % state(4) = [dphi; dtheta; dpsi]
    % state(5) = [omega_x; omega_y; omega_z] 
    global pq;
    global r;
    state = state_now;
    for i = 1:3
        state(i, 2) = state(i, 2) + pq.speed_noise * 2*(rand()-0.5);
        state(i, 5) = state(i, 5) + pq.ang_speed_noise * 2*(rand()-0.5);
    end
    state(:,4) = omega2deuler(r, state(:,5), state(:,1));
end