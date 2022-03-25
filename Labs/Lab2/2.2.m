% TIP:
% dms -> d -> llh


% N +
% S -
% W -
% E +

% DMS2D Convert degrees, minutes and seconds to degrees with decimal places
function [degrees] = dms2d(d,m,s)
  
    % Having as arguments the degrees, minutes and (optional, defaults to zero)
    % seconds of an angular measurement, outputs the value in degrees with
    % decimal places.

  if nargin == 2    % Set the default value for seconds
      s=0;
  end

  minutes = s/60;       % Usual conversions

  if m<0
      minutes = m - minutes;
  else
      minutes = minutes + m;
  end
  degrees = minutes/60;

  if d < 0  % Signal of the output based on input.
      degrees = d-degrees;
  elseif (d >= 0)
      degrees = d + degrees;
  end
  
end

% LLH2XYZ ECEF coordinates from geodetic coordinates
function [X, Y, Z] = llh2xyz(lat, lon, h)
  
    %   This function retrieves the ECEF coordinates from the geodetic
    %   coordinates. Input arguments are the latitude and longitude of the
    %   point to be calculated (in degrees with any number of decimal places)
    %   and altitude (in meters) and the output is given in meters, using the
    %   usual layout of X, Y and Z. The default ellipsoid used is WGS-84.

    a = 6378137;          % Semimajor axis of the ellipsoid
    f = 1/298.257223563;  % Ellipsoidal flattening

    lat = lat * pi/180;   % Convert the angular arguments from degrees to radians
    lon = lon * pi/180;

    R = a / sqrt(1-f*(2-f) * sin(lat)^2); % Radius of ellipsoid at given latitude
    
    % p1 = (38º 46´ 49.61´´ N, 9º 29´ 56.19´´ W, 103 m)

    X = (R+h) * cos(lat) * cos(lon);
    Y = (R+h) * cos(lat) * sin(lon);
    Z = (R*(1-f)^2+h) * sin(lat);

end