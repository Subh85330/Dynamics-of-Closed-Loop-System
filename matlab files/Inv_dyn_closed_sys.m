clear
close all
clc
T=3;
incr = 0.1;
i=1;


%for inputs
crank_len =3;
x=10;
% while true
fig=figure();
    for t=0:incr:T
        % Trajectory
        [theta_3, d_theta_3, dd_theta_3] = practical7_traj(0, 270, t, T);
        d2r = pi/180;
        
        %     calculation of b2, d_b2, dd_b2
        [Oi0_1, Oi0_2, b2, fi, d_fi, dd_fi] = inv_kinematics(theta_3, d_theta_3, dd_theta_3, fig);
        
        d_b2 = crank_len*((cosd(theta_3)*d_theta_3*d2r/(sind(fi)) - sind(theta_3)*cosd(fi)*fi*(d2r)/(sind(fi))^2));
        
        dd_b2 = crank_len*((sind(fi)*(cos(theta_3)*(dd_theta_3*d2r)-sind(theta_3)*(d_theta_3)^2) - cos(theta_3)*d_theta_3*d2r*cosd(fi)*d_fi*d2r)/(sind(fi))^2 - ((sind(fi)^2)*(cosd(theta_3)*d_theta_3*d2r*cosd(fi)*d_fi*d2r) + sind(theta_3)*(cos(fi)*dd_fi*d2r - sind(fi)*(d_fi*d2r)^2))/(sind(fi))^4);
        
        
        %     [theta_1, d_theta_1, dd_theta_1] = practical7_traj(30, 60, 0.1, 3);
        theta_1 = 90+fi;
        d_theta_1 = d_fi;
        dd_theta_1 = dd_fi;
        
        
        
        
        
        
        dd_q = [dd_theta_1; dd_b2; dd_theta_3];
        d_q = [d_theta_1; d_b2; d_theta_3];
        q = [theta_1; b2; theta_3];
        
        
        m1 = 1;
        m2 = 1;
        m3 = 1;
        l1 = 0.5;
        l3 = 2;
        Izz1 = 1;
        Iyy2 = 1;
        Izz3 = 1;
        g = 9.81;
        
        
        
        I = [m1*l1^2*+Izz1+m2*b2^2+Iyy2      0                  0
            0                        m2/4                  0
            0                           0             (m3*l3^2)/4 + Izz3];
        
        
        C = [(m2*b2*d_b2)/4              (m2*b2*d_theta_1)/4         0
            -(m2*b2*d_theta_1)/4              0                     0
            0                                 0                     0];
        
        h = [(m1*l1+m2*b2)*sin(theta_1)*g; -(0.5*m2*g*cos(theta_1));  -(0.5*m3*l3*cos(theta_3)*g) ];
        
        Ja = [0; 0; 1];
        J = [b2*cos(theta_1)      sin(theta_1)          -l3*sin(theta_3)
            b2*sin(theta_1)      -cos(theta_1)          -l3*cos(theta_3)
            0                    0                       0         ];
        
        
        time(i) = t;
        output = pinv([Ja J'])*(I*dd_q + C*d_q + h);
        torque(i) = output(1);
        force = -1*[output(2); output(3); output(4)];
        
        
        
      frame = getframe(fig); 
      im = frame2im(frame); 
      [imind,cm] = rgb2ind(im,256); 
      % Write to the GIF File 
      if i == 1 
          imwrite(imind,cm,"simulation.gif",'gif', 'Loopcount',inf); 
      else 
          imwrite(imind,cm,"simulation.gif",'gif','WriteMode','append'); 
      end 
      
      i=i+1;
    end
% end

plot(time, torque)
xlabel("Time(sec)")
ylabel("Input torque (tou_3)")