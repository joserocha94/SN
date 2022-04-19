% =======================================================================
%   Exercise 1 – True Ranges
% =======================================================================

%   Consider a GPS receiver at the following WGS 84 (x,y,z) cartesian coordinates:
%
%           r1 = (4918525.18 m, -791212.21 m, 3969762.19 m)
%
%   and the satellites’ ephemerides, collected by this receiver, stored in file ub1.ubx.2056.540000b.eph.
%   Assuming a receiver clock offset of zero, and for the satellites above an elevation angle of 10º 
%   (elevation mask), compute the ranges, measured by r1, at Week Number (WN) 2056, for every second 
%   between Time Of Week (TOW) 536400 s and (536400 s + 3600 s). Plot the true ranges, for the time interval 
%   in consideration.

  clc
  clear
  fprintf('Exercicio 4.1\n');
  
  X1 = 4918525.18;
  Y1 = -791212.21;
  Z1 = 3969762.19;
  
  [lat,lon,~] = xyz2llh(X1,Y1,Z1);

  time = 0:3600;
  time = time';
  time = time + 536400;

  omega = 7.2921151467*10^-5;
  WN = 2056;
  c = 299792458;
  minelev = 10;
  
  data = load('ub1.ubx.2056.540000bOctave.eph');
  R = zeros(size(time,1),size(data,1));
  
  for i=1:size(data,1)
     for s=1:size(time,1)  
        d_linha = 0;
        k = 1;
        t = time(s);
        
        while (1)     
          d = d_linha;
          tx = t - d/c;
          delta_omega = omega * d / c;
          
          [sx, sy, sz] = satpos(data(i,1:end), tx, WN);
          
          X2 = sx*cos(-delta_omega) - sy*sin(-delta_omega);
          Y2 = sx*sin(-delta_omega) + sy*cos(-delta_omega);
          Z2 = sz;
          d_linha = sqrt((X2-X1)^2 + (Y2-Y1)^2 + (Z2-Z1)^2);
          
          if (abs(d-d_linha) < 0.0001)
            break;
          endif
        endwhile
        
        %fprintf('\nTime-Step %d, \tTIME:%d \tSAT %d: [%.3f\t %.3f \t %.3f]', s, t, i, X2, Y2, Z2)
        [E,N,U] = ecef2enu(X1,Y1,Z1,lat,lon,X2,Y2,Z2);
        [az,el] = azelev(E,N,U);
        
        if el < minelev
            continue
        else
            R(i,s) = distance(0,0,0,E,N,U);
        end 
     
     endfor
  endfor
  
  for i=1:size(data,1)
     for s=1:3 %size(time,1)
       fprintf('\nSVN:%d \t Timestep:%d \t %.3f', data(i,1), s, R(i,s));
     endfor
     fprintf('\n');
  endfor

  figure();
  plot(time, R(1, 1:end), time, R(2, 1:end), time, R(3, 1:end), time, R(4, 1:end), time, R(5, 1:end), time, R(6, 1:end), time, R(7, 1:end), time, R(8, 1:end));      
  legend(int2str(data(1,1)), int2str(data(2,1)), int2str(data(3,1)), int2str(data(4,1)), int2str(data(5,1)), int2str(data(6,1)), int2str(data(7,1)), int2str(data(8,1)))
  
  
  
  