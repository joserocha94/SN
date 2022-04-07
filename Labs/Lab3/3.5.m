% ===============================================
% Exercise 5 – Satellite Azimuth and Elevation
% ===============================================

%   Consider a GPS receiver at the following WGS 84 (x,y,z) cartesian coordinates:
%
%               r1 = (4918525.18 m, -791212.21 m, 3969762.19 m)
%
% Use the results of the previous exercise to compute each satellite azimuth and elevation, as 
% seen by the receiver at r1.


  X1 = 4918525.18;
  Y1 = -791212.21;
  Z1 = 3969762.19;

  t = 536400;
  WN = 2056;

  fprintf('\nExercicio 5\n');
  azelev=zeros(size(SATECEF,1),3);
  for i=1:size(SATECEF,1)
      azelev(i,1)=data(i,1);
      azelev(i,2)=atan2(DCOS(i,1),DCOS(i,2))*180/pi;
      azelev(i,3)=atan2(DCOS(i,3),sqrt(DCOS(i,1)^2+DCOS(i,2)^2))*180/pi;
      fprintf('%d\t %.1f\t %.1f\n',azelev(i,1),azelev(i,2),azelev(i,3))
  end