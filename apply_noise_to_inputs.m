function noisy = apply_noise_to_inputs(inputs)
    global pq;
    noisy = inputs;
    for i = 1:4
        % check if the rotation speed is above a certain threshold;     
        % if so - apply noise
        if inputs(i) >= 200
            noisy(i) = noisy(i) + pq.omega_noise * 2*(rand()-0.5);
        end
    end
end