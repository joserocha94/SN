% =========================================================
% Exercise 3 – WGS 84 Cartesian to Geodetic Coordinates
% =========================================================

% Consider the following WGS 84 cartesian coordinates (x, y, z): 
%        p2 = (4910384.3 m, -821478.6 m, 3973549.6 m)
% Convert p2 to WGS 84 geographic coordinates (latitude, longitude, altitude). Write the 
% result with the latitude and longitude in the following formats: a) DD.dddº; b) DDº 
% MM.mmm´; c) DDº MM´ SS.ss´´


    disp('======================');
    disp('Running:');

    X = 4910384.3;
    Y = 821478.6;
    Z = 3973549.6;
    
    a = 6378137;            % Semimajor axis of the ellipsoid
    f = 1/298.257223563;    % Ellipsoidal flattening

    b = a*(1-f);            % Semiminor axis of the ellipsoid

    r = sqrt(X^2+Y^2);
    es = 1-(b^2)/(a^2);
    eps = (a^2)/(b^2)-1;
    theta = atan((a*Z)/(b*r));

    lat = 180*atan((Z+eps*b*sin(theta)^3)/(r-es*a*cos(theta)^3))/pi;
    lon = 180*atan2(Y,X)/pi;

    R = a/sqrt(1-f*(2-f)*sind(lat)^2);
    h = r/cosd(lat)-R;
      
    disp('latitude:');
    disp(lat);
    disp('longitude:');
    disp(lon);
    disp('altitude');
    disp(h);