function [Oi0] = subsystem1(theta3)
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


[Oi0] = for_kin_subsystem(2, [theta1; 0], [0; 90], [0; (l1 + b2)], [0; 0], [0;0;0]);

% plot(Oi0(1,:), Oi0(2,:))
% axis([-15 15 -15 15])
% pause(0.1)
end