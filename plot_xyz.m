function plot_xyz(state_last, state_now, time_last, time_now, color)
    % plot x,y,z, and roll, pitch, yaw on figure 1
    subplot(3,2,1); hold on; plot([time_last time_now], [state_last(1,1) state_now(1,1)], color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('x, m');
    subplot(3,2,3); hold on; plot([time_last time_now], [state_last(2,1) state_now(2,1)], color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('y, m');
    subplot(3,2,5); hold on; plot([time_last time_now], [state_last(3,1) state_now(3,1)], color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('z, m');
    
    subplot(3,2,2); hold on; plot([time_last time_now], [state_last(1,2) state_now(1,2)], color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('x speed, m/s');
    subplot(3,2,4); hold on; plot([time_last time_now], [state_last(2,2) state_now(2,2)], color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('y speed, m/s');
    subplot(3,2,6); hold on; plot([time_last time_now], [state_last(3,2) state_now(3,2)], color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('z speed, m/s');
end