function state = init_at_random()
    % initialize drone at location [x y z], everything else 0
    
    % state(1) = [x;y;z]
    % state(2) = [dx; dy; dz]
    % state(3) = [phi; theta; psi] (roll; pitch; yaw)
    % state(4) = [dphi; dtheta; dpsi]
    % state(5) = [omega_x; omega_y; omega_z] 
    pos = rnd(3, 3);
    pos(3,1) = rand() * 3;
    d_pos = rnd(3,1e-16);
    
    euler = rnd(3,1);
    
    d_euler = rnd(3,1e-16);
    omegas = rnd(3,1e-16);
%     
%     d_pos = [0;0;0];
%     euler = [0;0;0];
%     d_euler = [0;0;0];
%     omegas = [0;0;0];
    
    state = [ pos d_pos euler d_euler omegas];
end