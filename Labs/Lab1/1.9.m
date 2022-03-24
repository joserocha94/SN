% ========================================
% Exercise 9 – Satellites in View
% ========================================

% Identify the maximum number of satellites in view during the logging session.
% TODO : checksum on GSV messages!

filename = 'ISTShuttle.nmea';
fid = fopen(filename);
if fid == -1
    error('Error opening file: %s\n',filename); 
end

disp('====== Running ======');
message = fgetl(fid);

max_sat_use = max_sat_view = 0;

while ischar(message) 
  
    % get checksum value  
    str = uint8(strtok(message,'$*'));
    chk = 0;
    for i=1:size(str,2)
       chk = bitxor(chk, str(i));
    endfor
    chk = dec2hex(chk,2);

    % GPGGA messages for satellites in use
    if strcmp(message(1:6),'$GPGGA')  
        x = strsplit(message, ',', collapsedelimiters = false) (1,15) {1,:};
        x = strsplit(x, '*', collapsedelimiters = false) (1,2) {1,:};      
        qa = strsplit(message, ',', collapsedelimiters = false) (1,7) {1,:};
        
        if (x == chk && qa != '0' && qa != '6' && qa != '7' && qa != '8')
            temp_sats = str2double(strsplit(message, ',', collapsedelimiters = false) (1,8) {1,:});
            if (temp_sats > max_sat_use)
                max_sat_use = temp_sats;
            endif      
        endif      
    endif  
  
    % GPGSV messages for satellites in view, TO DO (!)
    if strcmp(message(1:6),'$GPGSV')  
        temp_sats = str2double(strsplit(message, ',', collapsedelimiters = false) (1,4) {1,:});
        if (temp_sats > max_sat_view)
            max_sat_view = temp_sats;
        endif         
    endif    
    
    message = fgetl(fid);   
endwhile

disp('=========');
disp('max satellites in use:');
disp(max_sat_use);
disp('max satellites in view:');
disp(max_sat_view);