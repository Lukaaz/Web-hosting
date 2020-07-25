function state = init_at_xy(x, y)
    % initialize drone at location [x y 0], everything else 0
    state = init_at([x;y;1e-16]);
end