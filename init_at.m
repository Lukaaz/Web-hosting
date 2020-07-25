function state = init_at(location)
    % initialize drone at location [x y z], everything else 0
    
    % state(1) = [x;y;z]
    % state(2) = [dx; dy; dz]
    % state(3) = [phi; theta; psi] (roll; pitch; yaw)
    % state(4) = [dphi; dtheta; dpsi]
    % state(5) = [omega_x; omega_y; omega_z] 
    pos = location;
    d_pos = [1e-16;1e-16;1e-16];
    euler = [1e-16;1e-16;1e-16];
    d_euler = [1e-16;1e-16;1e-16];
    omegas = [1e-16;1e-16;1e-16];
%     
%     d_pos = [0;0;0];
%     euler = [0;0;0];
%     d_euler = [0;0;0];
%     omegas = [0;0;0];
    
    state = [ pos d_pos euler d_euler omegas];
end