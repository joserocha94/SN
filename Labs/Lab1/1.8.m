% ========================================
% Exercise 8 – Speed over Ground
% ========================================

% Identify the highest speed over ground on the track
% Use only VTG sentences with the Mode Indicator field equal to ‘A’ or ‘D’, and a valid checksum 
% (in this case all the sentences in the file have a valid checksum).

filename = 'ISTShuttle.nmea';
fid = fopen(filename);
if fid == -1
    error('Error opening file: %s\n',filename); 
end

disp('====== Running ======');

message = fgetl(fid);
max_speed = 000.00;

while ischar(message) 
  
    % get checksum value  
    str = uint8(strtok(message,'$*'));
    chk = 0;
    for i=1:size(str,2)
       chk = bitxor(chk, str(i));
    endfor
    chk = dec2hex(chk,2);

    % VTG
    if strcmp(message(1:6),'$GPVTG')     
        x = strsplit(message, ',', collapsedelimiters = false) (1,10) {1,:};
        x = strsplit(x, '*', collapsedelimiters = false) (1,2) {1,:};      
        qa = strsplit(message, ',', collapsedelimiters = false) (1,10) {1,:};
        qa = strsplit(qa, '*', collapsedelimiters = false) (1,1) {1,:}; 
        
        if (x == chk && (qa == 'A' || qa == 'D'))
            temp_speed = str2double(strsplit(message, ',', collapsedelimiters = false) (1,8) {1,:});
            if (temp_speed > max_speed)
                max_speed = temp_speed;
            endif      
        endif             
    endif    
    
    message = fgetl(fid);   
endwhile

disp('=========');
disp('max speed:');
disp(max_speed);
