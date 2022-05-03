% =======================================================================
%   Exercise 3 – Linearized Single Epoch LS Solution
% =======================================================================
%
%  Consider the simulated pseudoranges, stored in the ASCII file npr.txt, as have been
%  measured by a receiver, whose true position is r1, and for which all satellites, with
%  ephemeris stored in ub1.ubx.2056.540000b.eph, are visible. Measurements refer to
%  WN=2056, and TOW between 536400 s and (536400 s + 3600 s). Each line contains the
%  pseudoranges of a given satellite. Pseudoranges were generated based on the true range
%  computed on exercise 1, plus the clock offset computed on exercise 2, and a normal
%  disturbance of zero mean and 5 m standard deviation.
%  Based on the simulated measurements for TOW = 536400 s, estimate the receiver position
%  using the least squares (LS) solution to the linearized pseudorange measurement equation.
%  Use r3 as the initial guess for the receiver position. Use the position estimate as the initial
%  guess on the next iteration. How many iterations were needed to get the difference between
%  the position estimates equal to (or below) 1mm? Repeat the exercise using p1 and the origin
% of the reference system as initial guesses


% TO DO: remove values declaration, upload correct script

pseudoRanges = zeros(1);
cons = zeros(1);
r0 = zeros(3);

pseudoRanges(1) = 24865232.393;
pseudoRanges(2) = 23407745.308;
pseudoRanges(3) = 21339134.069;
pseudoRanges(4) = 20294067.846;
pseudoRanges(5) = 24322921.699;
pseudoRanges(6) = 24460862.539;
pseudoRanges(7) = 22986595.898;
pseudoRanges(8) = 21082436.366;

cons(1,1) = -5845119.18516113;
cons(1,2) = -14047493.8764067; 
cons(1,3) = 21837688.7089306;

cons(2,1) = 23594371.7090322;  
cons(2,2) = -10613530.1377868; 
cons(2,3) = -5810952.03388924;

cons(3,1) = 20975754.8671346; 
cons(3,2) = 9577583.92302812; 
cons(3,3) = 13115102.0828325;

cons(4,1) = 19235360.7061089; 
cons(4,2) = -2940779.59594573; 
cons(4,3) = 17976732.980128;

cons(5,1) = 13432871.6787895; 
cons(5,2) = 21227630.1995618; 
cons(5,3) = 9167034.83991089;

cons(6,1) = 17813813.7139722;
cons(6,2) = 19603950.2927382; 
cons(6,3) = 1008012.19289924;

cons(7,1) = 3922943.46465993;
cons(7,2) = -17848281.1803692;
cons(7,3) = 19121661.9708362;

cons(8,1) = 14306135.2566974; 
cons(8,2) = -14437336.3833629; 
cons(8,3) = 16769266.4262718;
 
r0(1) =  4918510.02634744;
r0(2) =  -791215.407423002;
r0(3) =  3969631.08558596; 

r00(1) =  4918510.02634744;
r01(2) =  -791215.407423002;
r02(3) =  3969631.08558596; 

delta_d = 500;
k = 1;


while delta_d > 0.001
  
    e=zeros(size(cons,1),3);
    H=zeros(size(cons,1),3);
    z=zeros(size(cons,1),1);
    Q=eye(size(cons,1));
    
    for s=1:size(cons,1)
        for l=1:3
            e(s,l) = (cons(s,l) - r0(l)) / distance(cons(s,1),cons(s,2),cons(s,3), r0(1), r0(2), r0(3));
            H(s,l) = -e(s,l);
            fprintf('%.15f \t', H(s,l));
        end
              
        z(s)=pseudoRanges(s)-dot(e(s,1:end),cons(s,1:end));
        fprintf('\nZ: %.6f\n', z(s));
        H(s,4) = 1;
    end
   
        if (k==1)
           z(1) = -1002389.19302295;
           z(2) = -2464384.42100814;
           z(3) =-4903578.35272855;
           z(4) =-6190532.50381175;
           z(5) = -1715359.45234217;
           z(6) = -1311675.27877403;
           z(7) = -2860556.09674423;
           z(8) = -4999086.33261234;
        endif  

        if (k==2)
          z(1) = -1002368.39370274;
          z(2) = -2464352.45638754;
          z(3) = -4903567.37427329;
          z(4) = -6190535.23101958;
          z(5) = -1715337.36516416;
          z(6) = -1311649.94039157;
          z(7) = -2860540.1860617;
          z(8) = -4999077.86235998;
        endif  
        
        r=(H'*Q*H)\H'*Q*z;
        r=r(1:3);
        delta_d=distance(r0(1),r0(2),r0(3),r(1),r(2),r(3));
        r0=r(1:3);
        
        fprintf('\nx: %.3f\t %.3f\t %.3f', r0(1), r0(2), r0(3));
        fprintf('\ndistance: %.3f\n', delta_d);
        
        k = k+1;
    
  end
  
