% ===============================================
% Exercise 2 – GPS Satellite Ephemeris
% ===============================================

%   Consider a GPS receiver at the following WGS 84 (x,y,z) cartesian coordinates:
%
%               r1 = (4918525.18 m, -791212.21 m, 3969762.19 m)
%
%   Consider also that, the ephemerides collected by this receiver are stored in file 
%   ub1.ubx.2056.540000a.eph, in ASCII format, one line per satellite, with the 
%   following tab separated fields:
%
%   Use these ephemerides to calculate each satellite position, in WGS 84 cartesian coordinates, 
%   at Time Of Week (TOW) 536400 of Week Number (WN) 2056.

  X1 = 4918525.18;
  Y1 = -791212.21;
  Z1 = 3969762.19;

  t = 536400;
  WN = 2056;

  c = 299792458;
  omega = 7.2921151467*10^-5;
  
  fprintf('\nExercicio 3\n');
  
  data=load('ub1.ubx.2056.540000aOctave.eph');
  SATECEF=zeros(size(data,1),4);
  for i=1:size(data,1)
     SATECEF(i,1)=data(i,1);
     [SATECEF(i,2),SATECEF(i,3),SATECEF(i,4)]=satpos(data(i,1:end), t, WN);
  end

  dists=zeros(size(SATECEF,1),1);
  for i=1:1   %size(dists,1)
    fprintf('\n');
    
    d_linha = 0;
    k = 1;
    
    while (1)
    
      d = d_linha;
      tx = t - d/c;
      delta_omega = omega * d / c;
      
      [sx, sy, sz] = satpos(data(i,1:end), tx, WN);
      
      X2 = sx*cos(-delta_omega) - sy*sin(-delta_omega);
      Y2 = sx*sin(-delta_omega) + sy*cos(-delta_omega);
      Z2 = sz;
      
      d_linha = sqrt( (X2-X1)^2 + (Y2-Y1)^2 + (Z2-Z1)^2);
      
      fprintf('\n ==== ITERATION ==== %d\n', k);
      fprintf('\nT: %.9f s', tx);
      fprintf('\nSAT: [%.3f \t %.3f \t %.3f]', sx, sy, sz)
      fprintf('\nDELTA_OMEGA: %.6f rad', delta_omega);
      fprintf('\nSAT: [%.3f\t %.3f \t %.3f]', X2, Y2, Z2)
      fprintf('\nD´: %.6f', d_linha);
      fprintf('\n|D´-D| = %.6f', abs(d-d_linha));
      fprintf('\n\n');
      
      if (abs(d-d_linha) < 0.0001)
        break;
      endif
    
      k = k+1;
      
    endwhile
    
    fprintf('\nIt took %d interations', k);
     
  end