function plot_plane(state, ax_lim, col, lw)
    global r;
    figure(2); hold on;
    plane_x = [0, -0.15, -0.0, 0.25, -0.0, -0.15, -0.0, -0.15, 0.25, -0.15, -0.0, -0.15, -0.15];
    plane_y = [0,   0,   0.15, 0,   -0.15,   0,   0.15,   0,   0,   0,   -0.15,   0,    0];
    plane_z = [0,0,0,0,0, 0.1, 0, 0.1, 0, 0, 0, 0, 0.1];
    plane = [plane_x; plane_y; plane_z];
    plane_translated = w2b_t_r(r, plane, state);
    plot3(plane_translated(1, :), plane_translated(2, :), plane_translated(3, :), ['-' col], 'LineWidth', lw);
    
    xlabel('X'); ylabel('Y'); zlabel('Z')
    xlim([-ax_lim ax_lim]); ylim([-ax_lim ax_lim]); zlim([0 ax_lim]);
    grid on;
end