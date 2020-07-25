function plot_eulers(state_last, state_now, time_last, time_now, color)
    % plot x,y,z, and roll, pitch, yaw on figure 1
    subplot(3,2,1); hold on; plot([time_last time_now], [state_last(1,3) state_now(1,3)]*180/pi, color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('roll, deg');
    subplot(3,2,3); hold on; plot([time_last time_now], [state_last(2,3) state_now(2,3)]*180/pi, color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('pitch, deg');
    subplot(3,2,5); hold on; plot([time_last time_now], [state_last(3,3) state_now(3,3)]*180/pi, color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('yaw, deg');
    
    subplot(3,2,2); hold on; plot([time_last time_now], [state_last(1,4) state_now(1,4)]*180/pi, color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('roll speed, deg/s');
    subplot(3,2,4); hold on; plot([time_last time_now], [state_last(2,4) state_now(2,4)]*180/pi, color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('pitch speed, deg/s');
    subplot(3,2,6); hold on; plot([time_last time_now], [state_last(3,4) state_now(3,4)]*180/pi, color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('yaw speed, deg/s');
    
%     subplot(3,2,2); hold on; plot([time_last time_now], [state_last(1,5) state_now(1,5)]*180/pi, 'g', 'LineWidth', 1); xlabel('time, seconds'); ylabel('roll speed, deg/s');
%     subplot(3,2,4); hold on; plot([time_last time_now], [state_last(2,5) state_now(2,5)]*180/pi, 'g', 'LineWidth', 1); xlabel('time, seconds'); ylabel('pitch speed, deg/s');
%     subplot(3,2,6); hold on; plot([time_last time_now], [state_last(3,5) state_now(3,5)]*180/pi, 'g', 'LineWidth', 1); xlabel('time, seconds'); ylabel('yaw speed, deg/s');
end