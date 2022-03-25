
% MOLODENSKY Molodensky Transformation
% function [lat2, lon2, alt2] = molodensky(lat1, lon1, alt1, a1, b1, e1, delta_a, delta_f, delta_x, delta_y, delta_z)

  % Consider the following Molodensky parameters for the conversion from the European 1950 datum to the WGS 
  % 84 datum: ?a = - 251 m, ?f = - 0.14192702×10-4, ?x = -84 m, ?y = -107 m, ?z = -120 m.
  % Using a Molodensky transformation, compute the p1 and p2 geodetic coordinates in the 
  % European 1950 Datum. For those conversions, compare the values of ??, ?? and ?h. From 
  % those geodetic coordinates, compute the cartesian coordinates of p1 (European 1950 datum)
  % and compare them with the cartesian coordinates obtained from a translation of (-?x, -?y , -?z) 
  % applied to the WGS 84 cartesian coordinates of p1.

  % p1 = (38º 46´ 49.61´´ N, 9º 29´ 56.19´´ W, 103 m)
   
    disp("===============================");
    disp("Running problem [2.5]\n");
    
    lat1 = 38.780477;
    lon1 = 9.498942;
    alt1 = 103.0;

    a1 = 6378137;
    b1 = 6356752.3;
    e1 = sqrt(1-(b1^2)/(a1^2));
    
    delta_a = 251;
    delta_f = 0.14192702*10^-4;
    delta_x = 84;
    delta_y = 107;
    delta_z = 120;    
     
    lat1=lat1*pi/180;
    lon1=lon1*pi/180;

    R_N = (a1 / (sqrt(1-(e1^2) * sin(lat1)^2)));          % target = RN = 6386529.194 m
    R_M = (a1*(1-e1^2))/sqrt((1-(e1^2)*sin(lat1)^2)^3);   % target = RM = 6360480.286 m

    fprintf('RN = %f\nRM = %f\n', R_N, R_M);

    delta_lat = (-delta_x*sin(lat1)*cos(lon1)-delta_y*sin(lat1)*sin(lon1)+delta_z*cos(lat1)+(delta_a*R_N*(e1^2)/a1+delta_f*(R_M*a1/b1+R_N*b1/a1))*sin(lat1)*cos(lat1)) / (R_M+alt1);
    delta_lon = (-delta_x*sin(lon1)+delta_y*cos(lon1))/((R_N+alt1)*cos(lat1));
    delta_alt = delta_x*cos(lat1)*cos(lon1)+delta_y*cos(lat1)*sin(lon1)+delta_z*sin(lat1)-delta_a*a1/R_N+delta_f*b1*R_N*(sin(lat1)^2)/a1;

    delta_lat = delta_lat*180/pi;
    delta_lon = delta_lon*180/pi;

    lat1 = lat1*180/pi;
    lon1 = lon1*180/pi;

    lat2 = lat1+delta_lat;
    lon2 = lon1+delta_lon;
    alt2 = alt1+delta_alt;
    
    fprintf('\ndelta_lat: %f"\ndelta_lon: %f"\ndelta_alt: %fm\n',delta_lat*3600,delta_lon*3600,delta_alt);
    fprintf('\nlat = %f\nlon = %f\nalt = %f\n\n',lat2,lon2,alt2);

