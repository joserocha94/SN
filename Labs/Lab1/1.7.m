% ========================================
% Exercise 7 – Cumulative Elevation Gain
% ========================================

% Compute the cumulative elevation (altitude) gain on the track.
% TIP: In the computation of the cumulative elevation gain, only GGA sentences with the GPS Quality 
% Indicator field different from 0, 6, 7, and 8 and a valid checksum (in this case all the sentences in the file have 
% a valid checksum) were considered.

filename = 'ISTShuttle.nmea';
fid = fopen(filename);
if fid == -1
    error('Error opening file: %s\n',filename); 
end

disp('====== Running ======');
message = fgetl(fid);

previous = 99.5;
acc = curr = 0;
iter = 0;

while ischar(message) 
    
    % get checksum value  
    str = uint8(strtok(message,'$*'));
    chk = 0;
    for i=1:size(str,2)
       chk = bitxor(chk, str(i));
    endfor
    chk = dec2hex(chk,2);

    % GGA messages
    if strcmp(message(1:6),'$GPGGA')   
        x = strsplit(message, ',', collapsedelimiters = false) (1,15) {1,:};
        x = strsplit(x, '*', collapsedelimiters = false) (1,2) {1,:};      
        qa = strsplit(message, ',', collapsedelimiters = false) (1,7) {1,:};

        if (x == chk && qa != '0' && qa != '6' && qa != '7' && qa != '8')
            temp_altitude_cell = strsplit(message, ',', collapsedelimiters = false) (1,10) {1,:};
            curr = str2double(temp_altitude_cell);
          
            if (curr > previous)
                acc = acc + (curr - previous);
            endif            
            previous = curr;            
        endif        
    endif    
    
    message = fgetl(fid);   
    iter = iter+1;
endwhile

disp('=========');
disp('acumulado:');
disp(acc);
