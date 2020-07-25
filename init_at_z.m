function state = init_at_z(z)
    % initialize drone at location [0 0 z], everything else 0
    state = init_at([1e-16;1e-16;z]);
end