classdef Rotations
   properties
   end
   methods
%         function plot_plane_at(pose, col, lw)
%             global ax;
%             plane_x = [0, -0.2, -0.2, 0.2, -0.2, -0.2, -0.2, -0.2, 0.2, -0.2, -0.2, -0.2, -0.2];
%             plane_y = [0, 0, 0.2, 0, -0.2, 0, 0.2, 0, 0, 0, -0.2, 0, 0];
%             plane_z = [0,0,0,0,0, -0.2, 0, -0.2, 0, 0, 0, 0, -0.2];
%             plane = [plane_x; plane_y; plane_z];
%             plane_translated = w2b_t_r(plane, pose);
%             plot3(plane_translated(1, :), plane_translated(2, :), plane_translated(3, :), ['-' col], 'LineWidth', lw);
% 
%             set(ax, 'Zdir', 'reverse');
%             xlabel('X'); ylabel('Y'); zlabel('Z')
%             axis_min = -3; axis_max = -axis_min;
%             xlim([axis_min axis_max]); ylim([axis_min axis_max]); zlim([axis_min axis_max])
%             grid on;
%         end

        function v = w2b_t_r(obj,vector, state)
            % apply rotation
            v = rotate(obj,vector, state(:, 3));
            % apply translation
            v = translate(obj,v, state(:, 1));
        end

        function v = w2b(obj, vector, NED_euler)
            % apply rotations
            v = vector;
            v = yaw_matrix(obj, NED_euler(3) ) * v;
            v = pitch_matrix(obj, NED_euler(2) ) * v;
            v = roll_matrix(obj, NED_euler(1) ) * v;
        end

        function v = omega2deuler(obj,omegas, euler)
            % translate angular velocity of the body frame in angular
            % derivatives of pitch yaw roll
            % omegas: 3x1, angular velocity of body frame
            % euler: 3x1, euler angle of the frame [roll; pitch; yaw] [phi; theta; psi]
            phi = euler(1); theta = euler(2);
            R = [ 1  sin(phi) * tan(theta)    cos(phi) * tan(theta);
                  0       cos(phi)                 -sin(phi);
                  0  sec(theta) * sin(phi)   sec(theta) * cos(phi)];

            v = R * omegas;
        end

        function v = b2w(obj,vector, NED_euler)
            % vector: 3x1 in world frame; 
            % NED_euler: 3x1 euler representation of the frame
            % NED_euler: [roll; pitch; yaw]
            % apply rotations
            v = vector;
            v = roll_matrix(obj, -NED_euler(1) ) * v;
            v = pitch_matrix(obj, -NED_euler(2) ) * v;
            v = yaw_matrix(obj, -NED_euler(3) ) * v;
        end

        function v = translate(obj,vector, translation_vector)
            % translate vector V
            v = vector + translation_vector;
        end

        function v = rotate(obj,vector, NED_rotations)
            % rotate vector with NED euler angles
            % NED rotations are in the form [roll; pitch; yaw]
            v = vector;
            v = yaw_matrix(obj, NED_rotations(3) ) * v;
            v = pitch_matrix(obj, NED_rotations(2) ) * v;
            v = roll_matrix(obj, NED_rotations(1) ) * v;
        end

        function R_yaw = yaw_matrix(obj,psi)
            R_yaw = [ cos(psi) -sin(psi) 0;
                      sin(psi)  cos(psi) 0;
                      0        0         1 ];
        end

        function R_pitch = pitch_matrix(obj,theta)
            R_pitch = [  cos(theta)     0     -sin(theta);
                        0               1         0;
                        sin(theta)      0      cos(theta)];
        end

        function R_roll = roll_matrix(obj,phi)
            R_roll = [ 1       0            0;
                        0       cos(phi)  -sin(phi);
                        0       sin(phi)   cos(phi)];
        end



        function plot_point(obj,coord, ltype, col)
            l_lin = linspace(0,1,2);
            plot3(coord(1) * l_lin, coord(2) * l_lin, coord(3) * l_lin, [ltype, col], 'LineWidth', 2); hold on
            plot3(coord(1), coord(2), coord(3), ['o', col], 'LineWidth', 2); hold on
        end
   end
end







% clear all;
% figure;
% global ax;
% ax = axes;
% 
% 
% 
% 
% % plane_x = [0, -0.2, -0.2, 0.2, -0.2, -0.2, -0.2, -0.2, 0.2, -0.2, -0.2, -0.2, -0.2];
% % plane_y = [0, 0, 0.2, 0, -0.2, 0, 0.2, 0, 0, 0, -0.2, 0, 0];
% % plane_z = [0,0,0,0,0, -0.2, 0, -0.2, 0, 0, 0, 0, -0.2];
% % plane = [plane_x; plane_y; plane_z];
% % 
% pose = [1;1;1;pi/4;pi/10; 0];
% 
% 
% 
% 
% for i=1:20
%     if rem(i, 5) == 0
%         plot_plane_at(pose * i / 20, 'k', 3);
%     else
%         plot_plane_at(pose * i / 20, 'r', 1);
%     end
%     pause(0.01);
%     hold on
% end
% 
% % plane_translated = w2b_t_r(plane, pose)
% 
% % plot3(plane_translated(1, :), plane_translated(2, :), plane_translated(3, :), '-k', 'LineWidth', 1)
% 
% 
% % plot_point(y', '--', 'b')
% % plot_point(z', '--', 'g')
% 
% 
% set(ax, 'Zdir', 'reverse')
% xlabel('X'); ylabel('Y'); zlabel('Z')
% axis_min = -3; axis_max = -axis_min;
% xlim([axis_min axis_max]); ylim([axis_min axis_max]); zlim([axis_min axis_max])
% grid on
% 
% 
% 
% 
% 
% % pose = [ x; y; z; psi; pitch; roll];
% 