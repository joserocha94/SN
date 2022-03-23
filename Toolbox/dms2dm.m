#receives 3 args: degrees, minutes and seconds
//returns the equivalent value in degrees and minutes

function [degrees, minutes] = dms2dm(d, m, s)
  
  minutes = s/60;   
  if m < 0
      minutes = m-minutes;
  else
      minutes = minutes+m;
  end
  degrees = d;
  
endfunction

