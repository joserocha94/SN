% ROTZ Rotation about z axis
function [X2,Y2,Z2] = rotz(X1,Y1,Z1,gamma)
%   Rotates vector [X1,Y1,Z1] about by gamma degrees, about the z axis.

  gamma=gamma*pi/180;

  X2=X1*cos(gamma)+Y1*sin(gamma);
  Y2=-X1*sin(gamma)+Y1*cos(gamma);
  Z2=Z1;

end
