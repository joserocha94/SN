
% DMS2D 
function [degrees] = dms2d(d,m,s)

%   Convert degrees, minutes and seconds to degrees with decimal places
%   Having as arguments the degrees, minutes and (optional, defaults to zero)
%   seconds of an angular measurement, outputs the value in degrees with
%   decimal places.

if nargin==2    
    s=0; % default value
end

minutes=s/60;      

if m<0
    minutes=m-minutes;
else
    minutes=minutes+m;
end
degrees=minutes/60;

if d<0  
    degrees=d-degrees;
elseif d>=0
    degrees=d+degrees;
end
end
