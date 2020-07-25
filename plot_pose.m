function plot_pose(state_last, state_now, time_last, time_now, color)
    % plot x,y,z, and roll, pitch, yaw on figure 1
    figure(1);
    subplot(3,2,1); hold on; plot([time_last time_now], [state_last(1,1) state_now(1,1)], color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('x, m');
    subplot(3,2,3); hold on; plot([time_last time_now], [state_last(2,1) state_now(2,1)], color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('y, m');
    subplot(3,2,5); hold on; plot([time_last time_now], [state_last(3,1) state_now(3,1)], color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('z, m');

    subplot(3,2,2); hold on; plot([time_last time_now], [state_last(1,3) state_now(1,3)]*180/pi, color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('roll, deg');
    subplot(3,2,4); hold on; plot([time_last time_now], [state_last(2,3) state_now(2,3)]*180/pi, color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('pitch, deg');
    subplot(3,2,6); hold on; plot([time_last time_now], [state_last(3,3) state_now(3,3)]*180/pi, color, 'LineWidth', 1); xlabel('time, seconds'); ylabel('yaw, deg');
end

%         subplot(3,2,1); hold on; plot([time-dt_plot time], [state_last_plot(1,1) state_now(1,1)], 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('x, m');
%         subplot(3,2,3); hold on; plot([time-dt_plot time], [state_last_plot(2,1) state_now(2,1)], 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('y, m');
%         subplot(3,2,5); hold on; plot([time-dt_plot time], [state_last_plot(3,1) state_now(3,1)], 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('z, m');
%         
%         subplot(3,2,2); hold on; plot([time-dt_plot time], [state_last_plot(1,3) state_now(1,3)]*180/pi, 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('roll, deg');
%         subplot(3,2,4); hold on; plot([time-dt_plot time], [state_last_plot(2,3) state_now(2,3)]*180/pi, 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('pitch, deg');
%         subplot(3,2,6); hold on; plot([time-dt_plot time], [state_last_plot(3,3) state_now(3,3)]*180/pi, 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('yaw, deg');
        
%         subplot(3,4,1); hold on; plot([time-dt_plot time], [state_last_plot(1,1) state_now(1,1)], 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('x, m');
%         subplot(3,1,2); hold on; plot([time-dt_plot time], [state_last_plot(2,1) state_now(2,1)], 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('y, m');
%         subplot(3,1,3); hold on; plot([time-dt_plot time], [state_last_plot(3,1) state_now(3,1)], 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('z, m');
%         
%         subplot(3,1,1); hold on; plot([time-dt_plot time], [state_last_plot(1,2) state_now(1,2)], 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('x speed, m/s');
%         subplot(3,1,2); hold on; plot([time-dt_plot time], [state_last_plot(2,2) state_now(2,2)], 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('y speed, m/s');
%         subplot(3,1,3); hold on; plot([time-dt_plot time], [state_last_plot(3,2) state_now(3,2)], 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('z speed, m/s');
%         
%         subplot(3,1,1); hold on; plot([time-dt_plot time], [state_last_plot(1,3) state_now(1,3)], 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('roll, deg');
%         subplot(3,1,2); hold on; plot([time-dt_plot time], [state_last_plot(2,3) state_now(2,3)], 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('pitch, deg');
%         subplot(3,1,3); hold on; plot([time-dt_plot time], [state_last_plot(3,3) state_now(3,3)], 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('yaw, deg');
%         
%         subplot(3,1,1); hold on; plot([time-dt_plot time], [state_last_plot(1,4) state_now(1,4)], 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('roll speed, deg/s');
%         subplot(3,1,2); hold on; plot([time-dt_plot time], [state_last_plot(2,4) state_now(2,4)], 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('pitch speed, deg/s');
%         subplot(3,1,3); hold on; plot([time-dt_plot time], [state_last_plot(3,4) state_now(3,4)], 'r', 'LineWidth', 1); xlabel('time, seconds'); ylabel('yaw speed, deg/s');
