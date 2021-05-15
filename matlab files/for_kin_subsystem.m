function [Oi0] = for_kin_subsystem(n, theta, alpha, di, ai, den)

% theta_3 = 30

% alpha=[0];

% di=[0];

% theta=[theta_3 - 90];
% ai=[10];
% den = [0; 3; 0];
% n=1;
Temp = eye(4,4);
for i=1:n
    T_i_i_1= [cosd(theta(i))                    -sind(theta(i)) 0 ai(i); 
              sind(theta(i))*cosd(alpha(i))     cosd(theta(i))*cosd(alpha(i))   -sind(alpha(i))     -sind(alpha(i))*di(i);
              sind(theta(i))*sind(alpha(i))     cosd(theta(i))*sind(alpha(i))   cosd(alpha(i))      cosd(alpha(i))*di(i);
               0                                        0                           0                       1               ];
    
    Ti0(:,:,i)=Temp*T_i_i_1;
    Temp=Ti0(:,:,i);
    
    Oi0(1:3,i)=Ti0(1:3,4,i);
    zi0(1:3,i)=Ti0(1:3,3,i);
    
    
end
Pe0=Oi0(:,n) + Ti0(1:3,1:3,n)*(den);
Oi0(:,n+1)=Pe0;
Oi0= [[0;0;0], Oi0];
% plot3(Oi0(1,:), Oi0(2,:), Oi0(3,:))

end