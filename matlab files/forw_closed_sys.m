close all
clear all
clc
base_len = 10;
%inputs
syms   d_theta1 d_b2 d_theta3 
tou = [0; 0; 300];

crank_len = 10;
theta3 = 30;

m2 = 3;  m1=2; l1=0.5; g=9.81; m3 = 3; Izz1= 0.2; Iyy2=0.2; Izz3=0.3;

d_theta1 =0.2;
d_b2 = 0.3;
d_theta3 = 0.5;



theta1 = atan2(base_len + crank_len*sin(theta3), crank_len*sin(theta3));
b2     = (base_len + crank_len*sin(theta3))/sin(theta3);




I = [(m1*l1^2 + Izz1 + m2*(b2/2)^2 + Iyy2)      0                       0;
     0                                      m2                      0;
     0                                      0                  (m3*crank_len^2 + Izz3)/4];
 


zero = zeros(3,3);
J = [ (b2/2)*cos(theta1)    sin(theta1)     crank_len*sin(theta3);
      (b2/2)*sin(theta1)    -cos(theta1)     crank_len*cos(theta3);
      0                         0               0           ];
  
  
d_J = [ (d_b2/2)*cos(theta1) + (b2/2)*sin(theta1)*d_theta1      sin(theta1)*d_theta1     crank_len*sin(theta3)*d_theta3;
      (d_b2/2)*sin(theta1) + (b2/2)*sin(theta1)*d_theta1     -cos(theta1)*d_theta1     crank_len*cos(theta3)*d_theta3;
      0                                                        0                        0                 ];
    
  

C = [m2*(b2/2)*(d_b2)         m2*(b2/2)*d_theta1   0;
     -m2*(b2/2)*d_theta1      0              0;
     0                    0              0];
d_q = [d_theta1; d_b2; d_theta3];



h =  [(m1*l1 + m2*(b2/2))*sin(theta1);   -m2*g*cos(theta1);    -(m3*crank_len*g*cos(theta3))/2];






% Output = inv([ I  J'; J  zero])*[ tou - C*d_q + h;     d_J*d_q]
Output = ([ I  J'; J  zero])\[ tou - C*d_q - h;   d_J*d_q]



% Nkl = simplify(Output)
