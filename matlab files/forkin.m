close all
clear
clc

base_len = 10;
crank_len = 3;
n = 2;


% DH parameters for subsystem 2

alpha_sub2 = [0; 0];

d_sub2_i = [0; 0];
d_sub2_f = [0; 0];
% theta      = [the0 ; theata3]
theta_sub2_i = [0; 0]
theta_sub2_f = [90; 90]




% DH parameters for subsystem 1
alpha_sub1 = [0; 70];
ai_sub1 = [0; 0];



% d_sub1_i = [0; 13];
% d_sub1_f = [0; 10.44];
% theta_sub1_i = [90; 0]
% theta_sub1_f = [150; 0]
% 


for j=1:90
    %     Input subsystem 2
    theta_sub2 = theta_sub2_i + (theta_sub2_f - theta_sub2_i)*(j/90);
    di_sub2 =[0; 0]  % d_sub2_i + (d_sub2_f - d_sub2_i)*(j/90);
    
    ai_sub2 = [10;0];% need to be change
    
    
    
    %     Input subsystem 1
    
    theta1 = atan((base_len + crank_len*cosd(theta_sub2(2)))/crank_len*sind(theta_sub2(2)));
    b2     = (crank_len*sind(theta_sub2(2)))*cosd(theta_sub2(2));
    
    di_sub1 = [0; b2];
    theta_sub1 = [theta1; 0];
%     theta_sub1 = theta_sub1_i + (theta_sub1_f - theta_sub1_i)*(j/90);
%     di_sub1 = d_sub1_i + (d_sub1_f - d_sub1_i)*(j/90);
    
    
    
    
    
    Temp_subsystem1 = eye(4,4);
    Temp_subsystem2 = eye(4,4);
    
    for i = 1:n
        
        
        
        % For subsystem 2
        T_i_i_1_subsystem2 = [  cosd(theta_sub2(i))                           -sind(theta_sub2(i))                         0                          ai_sub2(i)
            sind(theta_sub2(i))*cosd(alpha_sub2(i))             cosd(theta_sub2(i))*cosd(alpha_sub2(i))         -sind(alpha_sub2(i))        -sind(alpha_sub2(i))*di_sub2(i)
            sind(theta_sub2(i))*sind(alpha_sub2(i))             cosd(theta_sub2(i))*sind(alpha_sub2(i))          cosd(alpha_sub2(i))         cosd(alpha_sub2(i))*di_sub2(i)
            0                                           0                                    0                           1                  ];
        
        
        Ti0_subsystem2(:,:,i) = Temp_subsystem2*T_i_i_1_subsystem2;
        
        Oi0_subsystem2(1:3,i)=Ti0_subsystem2(1:3,4,i);
        
%         plot(Oi0_subsystem2(1,:), Oi0_subsystem2(2,:))
%         
%         axis([-5 15 -5 15])
%         pause(0.1)
        
        Temp_subsystem2 = Ti0_subsystem2(:,:,i);
        
        
        
        
        
        
        
        %for subsystem 1
        T_i_i_1_subsystem1= [  cosd(theta_sub1(i))                           -sind(theta_sub1(i))                           0                          ai_sub1(i)
            sind(theta_sub1(i))*cosd(alpha_sub1(i))         cosd(theta_sub1(i))*cosd(alpha_sub1(i))      -sind(alpha_sub1(i))        -sind(alpha_sub1(i))*di_sub1(i)
            sind(theta_sub1(i))*sind(alpha_sub1(i))          cosd(theta_sub1(i))*sind(alpha_sub1(i))       cosd(alpha_sub1(i))         cosd(alpha_sub1(i))*di_sub1(i)
            0                                           0                                         0                           1                  ];
        
        Ti0_subsystem1(:,:,i) = Temp_subsystem1*T_i_i_1_subsystem1;
        Oi0_subsystem1(1:3,i)=Ti0_subsystem1(1:3,4,i);
        
        
        
        
        plot3(Oi0_subsystem1(1,:), Oi0_subsystem1(2,:), Oi0_subsystem1(2,:), 'r', Oi0_subsystem2(1,:), Oi0_subsystem2(2,:), Oi0_subsystem2(2,:), 'g',"LineWidth",2)
        axis([-5 15 -5 15])
        pause(0.1)
        
        Temp_subsystem1 = Ti0_subsystem1(:,:,i);
        
    end
    
    
    
end




% 
% % syms theta1 b2
% % DH paremeters
% alpha_sub2 = [0; 0];
% 
% % di = [0; 0];
% % theta = [theta3-90; 90];
% 
% d_sub2_i = [0; 2];
% d_sub2_f = [0; 5];
% theta_sub2_i = [0; 0]
% theta_sub2_f = [90; 0]
% 
% 
% for j=1:90
%     
%     theta_sub2 = theta_sub2_i + (theta_sub2_f - theta_sub2_i)*(j/90);
%     di_sub2 = d_sub2_i + (d_sub2_f - d_sub2_i)*(j/90);
%     ai_sub2 = [10; 3];
%     
%     Temp_subsystem2 = eye(4,4);
%     
%     for i = 1:n
%         T_i_i_1_subsystem2 = [  cosd(theta_sub2(i))                           -sind(theta_sub2(i))                         0                          ai_sub2(i)
%             sind(theta_sub2(i))*cosd(alpha_sub2(i))             cosd(theta_sub2(i))*cosd(alpha_sub2(i))         -sind(alpha_sub2(i))        -sind(alpha_sub2(i))*di_sub2(i)
%             sind(theta_sub2(i))*sind(alpha_sub2(i))             cosd(theta_sub2(i))*sind(alpha_sub2(i))          cosd(alpha_sub2(i))         cosd(alpha_sub2(i))*di_sub2(i)
%             0                                           0                                    0                           1                  ];
%         
%         
%         Ti0_subsystem2(:,:,i) = Temp_subsystem2*T_i_i_1_subsystem2;
%         
%         Oi0_subsystem2(1:3,i)=Ti0_subsystem2(1:3,4,i);
%         
%         
%         plot(Oi0_subsystem2(1,:), Oi0_subsystem2(2,:))
%         
%         axis([-5 15 -5 15])
%         pause(0.1)
%         
%         Temp_subsystem2 = Ti0_subsystem2(:,:,i);
%         
%     end
%     
%     
%     
% end