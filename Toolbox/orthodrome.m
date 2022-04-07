
% ORTHODROME Orthodrome parameter function
function [theta, psi1, psi2,d] = orthodrome(lat1,lon1,lat2,lon2)

%   Calculates the distance between P1 e P2 (values of lat and long in degrees)
%   Theta is the orthodrome angle. Psi1 and Psi2 are the depart and approach heading.
%   A spherical earth with a radius of 6378 km is assumed.

    R = 6378000;

    lat1 = lat1*pi/180;
    lon1 = lon1*pi/180;
    lat2 = lat2*pi/180;
    lon2 = lon2*pi/180;

    
    theta = acos(cos(lat2)*cos(lon1-lon2)*cos(lat1)+sin(lat2)*sin(lat1));
    psi1  = atan2(-cos(lat2)*sin(lon1-lon2),-cos(lat2)*cos(lon1-lon2)*sin(lat1)+sin(lat2)*cos(lat1))*180/pi;
    psi2  = atan2(-sin(lon1-lon2)*cos(lat1),sin(lat2)*cos(lon1-lon2)*cos(lat1)-cos(lat2)*sin(lat1))*180/pi;

    distance = theta*R;
    theta = theta*180/pi;

    fprintf('\nTheta = %.1fº \nDeparture = %.1fº \nApproaching = %.1fº \nOrthodrome Distance = %.0f m \n\n', theta, psi1, psi2, distance);
end

% 579 1189m
% 579 1223m