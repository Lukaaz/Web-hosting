IMU = imuSensor('accel-gyro');
IMU.Gyroscope.NoiseDensity = 1.25e-2; % (rad/s)/sqrt(Hz)
IMU.Gyroscope.BiasInstability = 2.0e-2; % rad/s
IMU.Gyroscope.RandomWalk = 9.1e-2; % (rad/s)*sqrt(Hz)
IMU.Accelerometer.NoiseDensity = 1.25e-2; % (rad/s)/sqrt(Hz)
IMU.Accelerometer.BiasInstability = 2.0e-2; % rad/s
IMU.Accelerometer.RandomWalk = 9.1e-2; % (rad/s)*sqrt(Hz)

[a, g] = IMU([0 0 9.81 ], [0 0 0] );
a
g




