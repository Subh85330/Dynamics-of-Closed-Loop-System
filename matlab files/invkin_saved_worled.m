close all

for j= 1:90
    
    %     Subsustem_2
    theta_sub2_i = 0; theta_sub2_f = 360;
    theta3 = theta_sub2_i + (theta_sub2_f - theta_sub2_i)*(j/90)
    % theta3 =  90;
    theta=[theta3 - 90];
    
    [Oi0_2] = for_kin_subsystem(1, theta, 0, 0, 10, [0;3;0]);
    
    
    
    %        Subsystem_1
    base_len = 10;
    crank_len = 3;
    l3 = 3;
    l1 = base_len - crank_len;
    
    fi = atan2d(l3*sind(theta3), (base_len + l3*cosd(theta3)))
    theta1 = (90 + fi);
    
    if theta3 == 0 | theta3 == 360 & fi == 0
        b2 = 2*crank_len;
    elseif theta3 == 180 & fi == 0
        b2 = 0;
    else
        b2 = ((l3*sind(theta3))/sind(fi) - l1);
    end
    
    
    [Oi0_1] = for_kin_subsystem(2, [theta1; 0], [0; 90], [0; (l1 + b2)], [0; 0], [0;0;0]);
    
   
    
    
    plot(Oi0_2(1,:), Oi0_2(2,:),"r", Oi0_1(1,:), Oi0_1(2,:),"g",'LineWidth',2)
    axis([-5 15 -5 15])
    pause(0.1)
    
    
end