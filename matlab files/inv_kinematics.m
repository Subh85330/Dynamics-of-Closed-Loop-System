function [Oi0_1, Oi0_2, b2, fi, d_fi, dd_fi] = inv_kinematics(theta_3, d_theta_3, dd_theta_3, h)
% for j= 1:90
    
    %     Subsustem_2
%     theta_sub2_i = 0; theta_sub2_f = 360;
%     theta3 = theta_sub2_i + (theta_sub2_f - theta_sub2_i)*(j/90)
%     % theta3 =  90;
    theta=[theta_3 - 90];
    
    [Oi0_2] = for_kin_subsystem(1, theta, 0, 0, 10, [0;3;0]);
    
    d2r = pi/180;
    
    %        Subsystem_1
    base_len = 10; %or
    x=10;
    crank_len = 3;
    l3 = 3;
    l1 = base_len - crank_len;
    
    fi = atan2d(l3*sind(theta_3), (base_len + l3*cosd(theta_3)));
    d_fi = (base_len*crank_len*cosd(theta_3)*d_theta_3*d2r + (crank_len*d_theta_3)^2)/(base_len^2 + l3^2 + 2*base_len*crank_len*cosd(theta_3));
    dd_fi = ((base_len^2 + l3^2 + 2*base_len*crank_len*cosd(theta_3))*(base_len*crank_len*(dd_theta_3*d2r*cosd(theta_3) - sind(theta_3)*d_theta_3^2*d2r) + 2*l3^2*d_theta_3*d2r*dd_theta_3*d2r) + 2*sind(theta_3)*d_theta_3*d2r*(base_len*l3*cosd(theta_3)*d_theta_3*d2r + l3^2*d_theta_3^2))/(x^2 + l3^2 +2*x*l3*cosd(theta_3));
    
    
    
    theta1 = (90 + fi);
    
    if theta_3 == 0 | theta_3 == 360 & fi == 0
        b2 = 2*crank_len;
    elseif theta_3 == 180 & fi == 0
        b2 = 0;
    else
        b2 = ((l3*sind(theta_3))/sind(fi) - l1);
    end
    
    
    [Oi0_1] = for_kin_subsystem(2, [theta1; 0], [0; 90], [0; (l1 + b2)], [0; 0], [0;0;0]);
    
   
    
    
    plot(Oi0_2(1,:), Oi0_2(2,:),"r", Oi0_1(1,:), Oi0_1(2,:),"g",'LineWidth',2)
    xlabel("X-axis")
    ylabel("Y-axis")
    title("Dynamics of Closed Loop System")
    axis([-5 15 -5 15])
    pause(0.1)
    
    
end