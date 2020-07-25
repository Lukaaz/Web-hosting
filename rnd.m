function res = rnd(dim, scaling_factor)
    res = zeros(dim, 1);
    for i = 1:dim
        res(i) = (rand()-0.5) * 2 * scaling_factor;
    end
end