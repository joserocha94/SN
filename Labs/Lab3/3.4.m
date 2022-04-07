% ===============================================
% Exercise 4 – Satellite Direction Cosines
% ===============================================
%
%          r1 = (4918525.18 m, -791212.21 m, 3969762.19 m)
%
% Using the positions calculated in the previous exercise, compute the direction cosines of 
% each satellite, as seen by the receiver at r1. Take as reference both the WGS 84 reference 
% system and a local (East, North, Up) reference system.


  X1 = 4918525.18;
  Y1 = -791212.21;
  Z1 = 3969762.19;

  t = 536400;
  WN = 2056;

  data=load('ub1.ubx.2056.540000aOctave.eph');
  SATECEF=zeros(size(data,1),4);

  for i=1:size(data,1)
     SATECEF(i,1)=data(i,1);
     [SATECEF(i,2),SATECEF(i,3),SATECEF(i,4)]=satpos(data(i,1:end), t, WN);
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