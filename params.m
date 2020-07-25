global pq;
global time;
global state_now;
global state_last;
global r;
global IMU;

IMU = imuSensor('accel-gyro', 'SampleRate', 1000);


r = Rotations();
time = 0.0;
state_now = init_at_zero();
state_last = init_at_zero();

f1 = 'dt'; v1 = 0.001; %s
f2 = 'm'; v2 = 0.6; %kg
f3 = 'g'; v3 = 9.81; %m/s2
f4 = 'L'; v4 = 0.15; %m
f5 = 'Kf'; v5 = 6e-7; %
f6 = 'Km'; v6 = 1e-8; %
f7 = 'max_omega'; v7 = 2.7e3; %rad/s
f8 = 'I'; v8 = [3.9e-3   0        0;
             0     4.4e-3     0; 
             0       0      4.9e-3]; 




f11 = 'omega_noise'; v11 = 0.1e3; % rad/s
f12 = 'speed_noise'; v12 = 0.1; % m/s average camrbidge wind speed Boston is 5.5
f13 = 'ang_speed_noise'; v13 = 4; % rad/s



f9 = 'floor'; v9 = 0.0; % floor is at 0.0 z axis;
f10='hit'; v10 = 0;

% numbers grabbed from page 58 
% https://repository.upenn.edu/cgi/viewcontent.cgi?article=1705&context=edissertations

pq = struct(f1,v1, f2,v2, f3,v3, f4,v4, f5,v5, f6,v6, f7,v7, f8,v8, f9,v9, f10,v10, f11,v11, f12,v12, f13,v13);
