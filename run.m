%% Matlab Technicalities
clear all;
try
    clf(1);
    clf(2);
end
params;


%% Initial States
state_now = init_at_z(5);
state_now(1,3) = 0.2;
state_now(2,3) = 0.3;
state_now(3,3) = 0.1;
state_last = state_now;
state_last_sensor = state_now;
state_last_plot = state_now;
time_last_plot = 0.0;
time_last_sensor = 0.0;

state_measured = state_now;
state_measured_last = state_now;
specific_a_last = [1e-16;1e-16;1e-16];
a_w_last = [1e-16;1e-16;1e-16];


%% Time Settings
tend = 5.0;
tend_ms = tend * 1000;
time = 0;
time_last = -1;
time_ms = 0;
time_last_ms = -1e-3;


controller_period = 30; %ms
noise_to_inputs_period = 10; %ms
plant_period = 1; %ms

sensor_period = 10; %ms
plot_period = 50; %ms
while_loop_period = 1; % ms


%% Plot Settings
figure(1);
subplot(3,2,1); grid on; hold on; xlim([0 tend]); 
subplot(3,2,3); grid on; hold on; xlim([0 tend]);
subplot(3,2,5); grid on; hold on; xlim([0 tend]);

subplot(3,2,2); grid on; hold on; xlim([0 tend]);
subplot(3,2,4); grid on; hold on; xlim([0 tend]);
subplot(3,2,6); grid on; hold on; xlim([0 tend]);
ax_lim = 4;

figure(2);
subplot(3,2,1); grid on; hold on; xlim([0 tend]); 
subplot(3,2,3); grid on; hold on; xlim([0 tend]);
subplot(3,2,5); grid on; hold on; xlim([0 tend]);

subplot(3,2,2); grid on; hold on; xlim([0 tend]);
subplot(3,2,4); grid on; hold on; xlim([0 tend]);
subplot(3,2,6); grid on; hold on; xlim([0 tend]);
ax_lim = 4;



%% Controller Settings
inputs = [1566; 1566; 1566; 1566];
des_inputs = [1566; 1566; 1566; 1566];
inputs = [0; 0; 0; 0];
% des_inputs = [1566; 1566; 1566; 1566];
% inputs = [1660; 1660; 1660; 1660]

last_inputs = inputs;
noisy_inputs = inputs;
TPRY = [0;0;0;0];

%% Run Loop
while time_ms < tend_ms && pq.hit == 0
    
    %% While loop propogation
    %---------------------------------
    %  Propogate the while loop
    %---------------------------------
    time_last_ms = time_ms;
    time_ms = time_ms + while_loop_period;
    time_last = time;
    time = time + pq.dt;
    state_last = state_now;
    
    %% Iputs from the remote controller
    
    % pwm inputs from the controller are:
    % [thrust;  yaw; pitch; roll], each from 1k to 2k
    des_from_remote = remote2mark2([1000;1500;1500;1500]);
    
    %% Attitude Controller PD on everything
    if rem(time_ms, controller_period) <= 0.1
        % apply the mark 2 controller
        des_inputs = AttitudeControllerMark2(state_measured, des_from_remote);
    end
    
    %% PWM 2 Speeds
    des_inputs = pwm2ang_speeds(des_inputs);
    
    %% Noise
    %---------------------------------
    %  Apply hardware noise to the inputs
    %--------------------------------- 
    if rem(time_ms, noise_to_inputs_period) <= 0.1
        inputs = last_inputs + sign(des_inputs - last_inputs) .* min(abs(des_inputs-last_inputs), 150);
        inputs = max(inputs, 0);
        inputs = min(inputs, pq.max_omega);
        last_inputs = inputs;
%        noisy_inputs = apply_noise_to_inputs(inputs);
%        noisy_inputs = inputs;
    end
    
    %% Enforce physical system
    
    %---------------------------------
    %  Apply environmental disturbances to the state
    %---------------------------------
%     state_now = apply_environmental_disturbance(state_now);
    

    %% Propogate the plant
    %---------------------------------
    %  Propogate the plant
    %---------------------------------
    if rem(time_ms, plant_period) <= 0.1
       state_now = step_plant(state_now, inputs');
    end
    
    
    %% Acquire Sensor Readings
    %---------------------------------
    %  Acquire sensor readings
    %---------------------------------
    tau = 0.05; % complimentary filter time constant ( a*t + g*(1-t) )
%     tau = 0.0; % complimentary filter time constant ( a*t + g*(1-t) )
    K_gain = 1.0; % kalman filter gain  ( new*k + old*(1-k) )
    
    if rem(time_ms, sensor_period) <= 0.1
        state_measured_last = state_measured;
        % state_measured(1) = [x;y;z]                   world frame
        % state_measured(2) = [dx; dy; dz]              world frame
        % state_measured(3) = [phi; theta; psi]         ~body/world? frame       (roll; pitch; yaw)
        % state_measured(4) = [dphi; dtheta; dpsi]      ~body/world? frame
        % state_measured(5) = [omega_x; omega_y; omega_z]  
        % state_measured_angle = [roll; pitch; yaw]     body frame
        
        %more realistic way
        
        [specific_a_b, angVel_b] = get_imu(state_last, state_now, plant_period/1000);
        
%         [specific_a_b, angVel_b] = get_imu(state_last_sensor, state_now, sensor_period);
        if time_ms <= 1
            specific_a_last = specific_a_b;
        end
        specific_a_b = (K_gain) * specific_a_b + (1-K_gain) * (specific_a_last);
        specific_a_last = specific_a_b;
        angVel_b = (K_gain) * angVel_b + (1-K_gain) * (state_measured(:,4));
        
        
        % --------------------------------------------------------------
        % --------------------------------------------------------------
        specific_a_w = b2w(r, specific_a_b, state_measured_last(:, 3));
        actual_a_w = specific_a_w - [0; 0; pq.g];
        if time_ms <= 1
            a_w_last = actual_a_w;
        end
        state_measured_angle = state_measured(:,3);
        % propogate world position data based on acceleration measurements
        state_measured(:,2) = state_measured(:,2) + (actual_a_w + a_w_last)/2 * (sensor_period/1000);
        state_measured(:,1) = state_measured(:,1) + state_measured(:,2) * (sensor_period/1000) + actual_a_w * (sensor_period/1000)^2 / 2;
        a_w_last = actual_a_w;
        % --------------------------------------------------------------
        % WORKING IN BODY FRAME
        % be careful about the way you do rotations dumb fuck
        
        % find pitch, roll, and yaw by fusing data
        ax = specific_a_b(1);  ay = specific_a_b(2);  az = specific_a_b(3); 
        
        angVel_w = omega2deuler(r, angVel_b, state_measured(:,3));
        
        a_roll = atan2(-ay, az);
        g_roll = state_measured_angle(1) + angVel_w(1) * (sensor_period/1000);


        % pitch:
        temp_v = -ay / (pq.g * sin(a_roll));
%         a_pitch = (     asin( sign(-ax/pq.g) * min(abs(-ax/pq.g), 1)  )    +     acos( sign(temp_v) * min(abs(temp_v), 1) )     )/2;
        
        a_pitch = asin( -ax/pq.g );
        g_pitch = state_measured_angle(2) + angVel_w(2) * (sensor_period/1000);
        
        % yaw:
        g_yaw = state_measured_angle(3) + angVel_w(3) * (sensor_period/1000);
        
        a_mag = sqrt(ax^2 + ay^2 + az^2);
        g_sum = sum(abs(angVel_w)); 
        
        % apply the complimentary filter
        if ( abs(a_mag-pq.g) < 1 )
            new_roll = (1-tau) * g_roll + (tau) * a_roll;
            new_pitch = (1-tau) * g_pitch + (tau) * a_pitch;
            new_yaw = g_yaw;
        else
            new_roll = g_roll;
            new_pitch = g_pitch;
            new_yaw = g_yaw;
        end
        
        
        
        % apply simple alpha Kalman filter
%         state_measured_angle = (K_gain) * [new_roll; new_pitch; new_yaw] + (1-K_gain) * (state_measured_angle);
        state_measured_angle = [new_roll; new_pitch; new_yaw];

        state_measured(:, 3) = state_measured_angle;
        state_measured(:, 4) = angVel_w; 
        state_measured(:, 5) = angVel_b;
        
        
        
        state_last_sensor = state_now; % update the last state in which sensor data was acquired

    end
     
    
    %% Plotting
    %---------------------------------
    %  Do the plotting
    %---------------------------------
    if rem(time_ms, plot_period) <= 0.1
        figure(1);
        plot_eulers(state_last_plot, state_now, time_last_plot/1000.0, time_ms/1000.0, 'r');
        plot_eulers(state_measured_last, state_measured, time_last_plot/1000.0, time_ms/1000.0, 'b');
        
        figure(2);
        plot_xyz(state_last_plot, state_now, time_last_plot/1000.0, time_ms/1000.0, 'r');
        plot_xyz(state_measured_last, state_measured, time_last_plot/1000.0, time_ms/1000.0, 'b');
        
%         figure(3); hold on;
%         plot_drone(state_now, 5);
        
        state_last_plot = state_now;
        time_last_plot = time_ms;

    end    
 
end








%     if rem(time * 1000, dt_plot*1000) <= 0.1
%         plot_pose(state_last_plot, state_now, time_last_plot, time);
% %         plot_plane(state_now, ax_lim, 'b', 1);
%         plot_drone(state_now, ax_lim);
%         
%         state_last_plot = state_now;
%         time_last_plot = time;
%     end   
%         accel_f = b2w(r, accel', state_now(:, 3)) - [0;0;pq.g];
%         subplot(3,1,1); hold on; scatter([time_now], [ (state_now(1,2)-state_last_plot(1,2))/pq.dt], 'r', 'LineWidth', 2); xlabel('time, seconds'); ylabel('x, m');
%         subplot(3,1,1); hold on; scatter([time_now], [ a_proper_world(1) ], 'b', 'LineWidth', 1); xlabel('time, seconds'); ylabel('x, m');
%         subplot(3,1,2); hold on; scatter([time_now], [ (state_now(2,2)-state_last(2,2))/pq.dt], 'r', 'LineWidth', 2); xlabel('time, seconds'); ylabel('x, m');
%         subplot(3,1,2); hold on; scatter([time_now], [ a_proper_world(2) ], 'b', 'LineWidth', 1); xlabel('time, seconds'); ylabel('x, m');
%         subplot(3,1,3); hold on; scatter([time_now], [ (state_now(3,2)-state_last(3,2))/pq.dt], 'r', 'LineWidth', 2); xlabel('time, seconds'); ylabel('x, m');
%         subplot(3,1,3); hold on; scatter([time_now], [ a_proper_world(3)-pq.g ], 'b', 'LineWidth', 1); xlabel('time, seconds'); ylabel('x, m');


    
    