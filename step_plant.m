function new_state = step_plant(state, inputs)
    % state(1) = [x;y;z]
    % state(2) = [dx; dy; dz]
    % state(3) = [phi; theta; psi] (roll; pitch; yaw)
    % state(4) = [dphi; dtheta; dpsi]
    % state(5) = [omega_x; omega_y; omega_z] 
    
    % inputs = [sp1 sp2 sp3 sp4]
    global pq;
    global r;
    F = pq.Kf * (inputs .^2);
    M = pq.Km * inputs .^2;
    
%     new_state = init_at_zero();
    
    %propogate postition as an integral of velocity
    new_state(:,1) = state(:,1) + pq.dt * state(:,2); 

    %propogate velocity according to Newton's law
    new_state(:,2) = state(:,2) +  1 /pq.m * pq.dt * ( [0; 0; -pq.m * pq.g] + b2w(r, [0;0;sum(F)], state(:,3)) );
    
    moments =  [  pq.L * (F(2) + F(3) - F(1) - F(4));   % roll
                  pq.L * (-F(3) - F(4) + F(1) + F(2));   % pitch
                  M(1) + M(3) - M(2) - M(4)  ];         % yaw
    
    %propogate angular position as an integral of angular velocity
    new_state(:,3) = state(:,3) + pq.dt * state(:,4);
    
    %propogate omegas according to Euler's equation
    new_state(:,5) = state(:,5) + inv(pq.I) * pq.dt * ( moments - cross(state(:,5), pq.I * state(:,5)) );
    
    %translate propgated omega into derivative of euler angles using a matrix
    new_state(:,4) = omega2deuler(r, new_state(:,5), state(:,3));
    
%     if (new_state(3, 1) <= pq.floor)
%         disp("YOU HIT THE FLOOR")
% %         new_state = init_at_zero();
%         pq.hit = 1;
%     end
end