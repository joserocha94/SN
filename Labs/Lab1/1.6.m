% =========================================
% Exercise 6 – Highest and Lowest Points
% =========================================

% Identify the time/date and the coordinates of the highest and lowest points (altitude) on the track.
% TIP: Use only GGA sentences with the GPS Quality Indicator field different from 0, 6, 7, and 8 and a valid checksum 
% (in this case all the sentences in the file have a valid checksum).

filename = 'ISTShuttle.nmea';
fid = fopen(filename);
if fid == -1
    error('Error opening file: %s\n',filename); 
end

disp('====== Running ======');
message = fgetl(fid);

max_altitude = -100.00;
min_altitude = 100.00;

max_lat = 0;
max_lon = 0;
max_lat_dir = '';
max_dir = '';

min_lat = 0;
min_lon = 0;
min_lat_dir = '';
min_dir = '';

max_time = min_time = 0;

% TODO: GPZDA get date ?
while ischar(message) 
  
    %get checksum value  
    str = uint8(strtok(message,'$*'));
    chk = 0;
    for i=1:size(str,2)
       chk = bitxor(chk, str(i));
    endfor
    chk = dec2hex(chk,2);
    
    % GGA
    if strcmp(message(1:6),'$GPGGA')   
        x = strsplit(message, ',', collapsedelimiters = false) (1,15) {1,:};
        x = strsplit(x, '*', collapsedelimiters = false) (1,2) {1,:};      
        qa = strsplit(message, ',', collapsedelimiters = false) (1,7) {1,:};
        
        if (x == chk && qa != '0' && qa != '6' && qa != '7' && qa != '8')
        
            temp_altitude_cell = strsplit(message, ',', collapsedelimiters = false) (1,10) {1,:};
            temp_altitude = str2double(temp_altitude_cell);
            
            # max values
            if (temp_altitude > max_altitude)
            
                # altitude
                max_altitude = temp_altitude;
                
                # latitude
                max_lat_cell = strsplit(message, ',', collapsedelimiters = false) (1,3) {1,:};     
                max_lat = str2double(max_lat_cell(1:2)) + str2double(max_lat_cell(3:end)) / 60.0;
                max_lat_dir = strsplit(message, ',', collapsedelimiters = false) (1,4) {1,:};
                
                #longitude
                max_lon_cell = strsplit(message, ',', collapsedelimiters = false) (1,5) {1,:};  
                max_lon = str2double(max_lon_cell(1:3)) + str2double(max_lon_cell(4:end)) / 60.0;
                max_lon_dir = strsplit(message, ',', collapsedelimiters = false) (1,6) {1,:};
                
                #time
                max_time = strsplit(message, ',', collapsedelimiters = false) (1,2) {1,:};            
            endif   
          
            # min values
            if (temp_altitude < min_altitude)
              
                # altitude
                min_altitude = temp_altitude;
                
                # latitude
                min_lat_cell = strsplit(message, ',', collapsedelimiters = false) (1,3) {1,:};     
                min_lat = str2double(min_lat_cell(1:2)) + str2double(min_lat_cell(3:end)) / 60.0;
                min_lat_dir = strsplit(message, ',', collapsedelimiters = false) (1,4) {1,:};
                
                # longitude
                min_lon_cell = strsplit(message, ',', collapsedelimiters = false) (1,5) {1,:};  
                min_lon = str2double(min_lon_cell(1:3)) + str2double(min_lon_cell(4:end)) / 60.0;
                min_lon_dir = strsplit(message, ',', collapsedelimiters = false) (1,6) {1,:};
                
                # time
                min_time = strsplit(message, ',', collapsedelimiters = false) (1,2) {1,:};   
                
            endif               
        endif  
    endif    
    
    message = fgetl(fid);   
endwhile

disp('=========');
disp('max altitude:');
disp(max_altitude);
disp('position:');
disp(max_lat_cell);
disp(max_lat_dir);
disp(max_lon_cell);
disp(max_lon_dir);
disp('time:');
disp(max_time);

disp('=========');
disp('min altitude:');
disp(min_altitude);
disp('position:');
disp(min_lat_cell);
disp(min_lat_dir);
disp(min_lon_cell);
disp(min_lon_dir);
disp('time:');
disp(min_time);

fclose(fid);
