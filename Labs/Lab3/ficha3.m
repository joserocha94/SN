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


X1 = 4918526.668;
Y1 = -791212.115;
Z1 = 3969767.14;

t = 536400;
WN = 2056;

  data=load('ub1.ubx.2056.540000aOctave.eph');
  SATECEF=zeros(size(data,1),4);

  fprintf('\nExercicio 2\n');
  for i=1:size(data,1)
     SATECEF(i,1)=data(i,1);
     [SATECEF(i,2),SATECEF(i,3),SATECEF(i,4)]=satpos(data(i,1:end), t, WN);
     fprintf('%d\t %.3f \t %.3f \t %.3f\n',SATECEF(i,1),SATECEF(i,2),SATECEF(i,3),SATECEF(i,4))
  end

  fprintf('\nExercicio 4\n');
  dists=zeros(size(SATECEF,1),1);
  for i=1:size(dists,1)
      dists(i,1)=distance(X1,Y1,Z1,SATECEF(i,2),SATECEF(i,3),SATECEF(i,4));
  end
 
  ENU=zeros(size(SATECEF,1),3);
  DCOS=zeros(size(SATECEF,1),3);
  [lat1,lon1,~]=xyz2llh(X1,Y1,Z1);
  for i=1:size(SATECEF,1)
      [ENU(i,1),ENU(i,2),ENU(i,3)]=ecef2enu(X1,Y1,Z1,lat1,lon1,SATECEF(i,2),SATECEF(i,3),SATECEF(i,4));
      for j=1:3
          DCOS(i,j)=ENU(i,j)/dists(i);
      end
      fprintf('%d\t %.3f\t %.3f\t %.3f\n',SATECEF(i,1),DCOS(i,1),DCOS(i,2),DCOS(i,3))
  end

  fprintf('\nExercicio 5\n');
  azelev=zeros(size(SATECEF,1),3);
  for i=1:size(SATECEF,1)
      azelev(i,1)=SATECEF(i,1);
      azelev(i,2)=atan2(DCOS(i,1),DCOS(i,2))*180/pi;
      azelev(i,3)=atan2(DCOS(i,3),sqrt(DCOS(i,1)^2+DCOS(i,2)^2))*180/pi;
      fprintf('%d\t %.1f\t %.1f\n',azelev(i,1),azelev(i,2),azelev(i,3))
  end