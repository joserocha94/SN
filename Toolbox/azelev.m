
% AZELEV: Calculates azimuth and elevation
function [az, el] = azelev(E, N, U)

%   Outputs azimuth and elevation (in degrees) given ENU coordinates in
%   meters.
%   ATTENTION: not xyz coordinates (!!!)

  az = atan2(E, N)*180/pi;
  el = atan2(U, sqrt(N^2+E^2))*180/pi;

end


