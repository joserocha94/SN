
function [E] = solveEA(M,e,t)
  
  if nargin == 2
      t = 10^-12;
  end

  E = M;
  contador = 1;

  while (1)
      Ep=E;
      E=M+e*sin(E);
      if abs(E-Ep)<t
          break
      else
          continue
      end
      contador = contador + 1;
  end
  
end