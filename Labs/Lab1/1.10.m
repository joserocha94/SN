% ========================================
% Exercise 10 – Satellites in View
% ========================================

% Identify the satellite with the highest elevation angle.

#filename = 'ISTShuttle.nmea';
filename = 'teste.m';
fid = fopen(filename);
if fid == -1
    error('Error opening file: %s\n',filename); 
end

disp('====== Running ======');
message = fgetl(fid);

max_sat_angle = 0;

while ischar(message) 
  
    % get checksum value  
    str = uint8(strtok(message,'$*'));
    chk = 0;
    for i=1:size(str,2)
       chk = bitxor(chk, str(i));
    endfor
    chk = dec2hex(chk,2);

    % GPGSV messages for satellites in view
    if strcmp(message(1:6),'$GPGSV')  
        x = strsplit(message, '*', collapsedelimiters = false) (1,2) {1,:};
        
        % checksum confere, pode analisar
        if (x == chk)
            msg = strsplit(message, ',', collapsedelimiters = false);
            msg_size = length(msg);
            n_sat = (msg_size - 4) / 4;
            
            disp(message);
            
            for c = 1:n_sat
                temp_angle = (strsplit(message, ',', collapsedelimiters = false) (1,c*4 + 2) {1,:});
                if (temp_angle > max_sat_angle)
                    max_sat_angle = temp_angle;
                endif
            endfor
          
        endif
    endif 
    
    message = fgetl(fid);   
endwhile


disp('max_sat_angle:');
disp(max_sat_angle);
