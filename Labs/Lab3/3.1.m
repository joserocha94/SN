
% ===================================================
%             Exercise 3
% ===================================================

%Consider a satellite with the following orbital parameters
%   > orbit semi-major axis: A = 26559755m;
%   > orbit eccentricity: e = 0.017545;
%   > argument of perigee: ? = 1.626021rad.Consider a satellite with the following orbital parameters
%   > orbit semi-major axis: A = 26559755m;
%   > orbit eccentricity: e = 0.017545;
%   > argument of perigee: ? = 1.626021rad.

  c = 3e8;
  A = 26559755;
  e = 0.017545;
  w = 1.626021;

  % al�nea a)
  t = 39929;
  miu = 3.986005*10^14;
  T = 2*pi*sqrt((A^3)/miu);
  fprintf('Orbital period:\n%f s\n%f m\n%f h\n\n', T, T/60, T/3600);

  % al�nea b)
  eta=2*pi/T;
  fprintf('Mean angular motion:\n%f rad/s\n%f �/s\n%f �/h\n\n', eta, eta*180/pi, eta*180/pi*3600);

  % al�nea c)
  M=eta*t;
  fprintf('Mean anomaly:\n%f rad/s\n%f �\n\n',M,M*180/pi);

  % al�nea d)
  t = 10^-12;
  E = M;
  while (1)
      Ep=E;
      E=M+e*sin(E);
      if abs(E-Ep)<t
          break
      else
          continue
      end
  end
  fprintf('Eccentric anomaly:\n%f rad/s\n%f �\n\n', E, E*180/pi);
  
  % al�nea e)
  phi0 = atan2(sqrt(1-e^2)*sin(E),cos(E)-e);
  r = A*(1-e*cos(E));
  fprintf('True anomaly:\n%f rad\n%f �\n', phi0, phi0*180/pi);
  fprintf('Radius:\n%f m\n\n', r);
  
  % al�nea f)
  phi=phi0+w;
  fprintf('Argument of latitude:\n%f rad\n%f �\n\n', phi, phi*180/pi);