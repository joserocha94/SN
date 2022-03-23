



function [degrees, minutes] = dms2dm(d, m, s)
  
  minutes = s/60;   

  if m < 0
      minutes = m-minutes;
  else
      minutes = minutes+m;
  end

  degrees = d;
  
endfunction

