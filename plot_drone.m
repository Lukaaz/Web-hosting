function plot_drone(state, ax_lim)
    global r;
    global pq;
%     figure(2); hold on;
    plane_x = [0, pq.L, 0, pq.L, 0, -pq.L, 0, -pq.L, 0];
    plane_y = [0, pq.L, 0,-pq.L, 0, -pq.L, 0,  pq.L, 0];
    plane_z = [0,  0,   0, 0,    0,   0,   0,   0,   0];
    plane = [plane_x; plane_y; plane_z];
    plane_translated = w2b_t_r(r, plane, state);
    plot3(plane_translated(1, :), plane_translated(2, :), plane_translated(3, :), ['-' 'k'], 'LineWidth', 1);
    
    plane_x = [pq.L, pq.L];
    plane_y = [pq.L, -pq.L];
    plane_z = [0,  0];
    plane = [plane_x; plane_y; plane_z];
    plane_translated = w2b_t_r(r, plane, state);
    plot3(plane_translated(1, :), plane_translated(2, :), plane_translated(3, :), ['o' 'g'], 'LineWidth', 2);
    
    plane_x = [-pq.L, -pq.L];
    plane_y = [-pq.L, pq.L];
    plane_z = [0,  0];
    plane = [plane_x; plane_y; plane_z];
    plane_translated = w2b_t_r(r, plane, state);
    plot3(plane_translated(1, :), plane_translated(2, :), plane_translated(3, :), ['o' 'r'], 'LineWidth', 2);
    
    xlabel('X'); ylabel('Y'); zlabel('Z')
    xlim([-ax_lim ax_lim]); ylim([-ax_lim ax_lim]); zlim([0 ax_lim]);
    grid on;
end