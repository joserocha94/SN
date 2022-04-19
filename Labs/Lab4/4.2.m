% =======================================================================
%   Exercise 2 – Noiseless Pseudoranges
% =======================================================================

%   Consider a GPS receiver at the following WGS 84 (x,y,z) cartesian coordinates:
%
%           r1 = (4918525.18 m, -791212.21 m, 3969762.19 m)
%
% For the same receiver position of the previous exercise, and for the same ephemerides,
% consider now a clock offset of 500 µs, at TOW 536400 s, and a clock drift of 0.4 µs/s. In
% these conditions, and for an elevation mask of 10º, compute the pseudoranges, measured at
% r1, on Week Number (WN) 2056, for every second between Time Of Week (TOW)
% 536400 s and (536400 s +3600 s). Plot the true ranges and the computed pseudoranges, for
% the time interval in consideration.

  clc
  clear
  fprintf('Exercicio 4.2\n');
  
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
        
        [E,N,U]=ecef2enu(X1,Y1,Z1,lat,lon,X2,Y2,Z2);
        [az,el]=azelev(E,N,U);
        
        if el < minelev
            continue
        else
            R(i,s) = distance(0,0,0,E,N,U);
        end 
     
     endfor
  endfor
  
  pseudoR=R';
  for i=1:size(pseudoR,1)
      for j=1:size(pseudoR,2)
          pseudoR(i,j) = pseudoR(i,j) + c * (500e-6 + 0.4e-6 * (i-1));
      end
  end

    for i=1:size(data,1)
     for s=1:3 %size(time,1)
       fprintf('\nSVN:%d \t Timestep:%d \t %.3f', data(i,1), s, pseudoR(i,s));
     endfor
     fprintf('\n');
  endfor
  
  
  