#filename = 'teste.m';
filename = 'ISTShuttle.nmea';
fid = fopen(filename);
if fid == -1
    error('Error opening file: %s\n',filename); 
end

counter=0;
message=fgetl(fid);

max_lat = -91;
max_lat_cell = 0;
min_lat = 91;
min_lat_cell = 0;

max_lon = -91;
max_lon_cell = 0;
min_lon = 91;
min_lon_cell = 0;

max_lat_dir = '';
min_lat_dir = '';
max_long_di = '';
min_lon_dir = '';

disp('====== Running ======');

while ischar(message) 
  
    # get checksum value  
    str = uint8(strtok(message,'$*'));
    chk = 0;
    for i=1:size(str,2)
       chk = bitxor(chk, str(i));
    endfor
    chk = dec2hex(chk,2);
    
    # GGA
    if strcmp(message(1:6),'$GPGGA')   
        x = strsplit(message, ',', collapsedelimiters = false) (1,15) {1,:};
        x = strsplit(x, '*', collapsedelimiters = false) (1,2) {1,:};      
        qa = strsplit(message, ',', collapsedelimiters = false) (1,7) {1,:};
        
        if (x == chk && qa != '0' && qa != '6' && qa != '7' && qa != '8')
          lat_cell = strsplit(message, ',', collapsedelimiters = false) (1,3) {1,:};     
          lat = str2double(lat_cell(1:2)) + str2double(lat_cell(3:end)) / 60.0;
          if (lat > max_lat)
            max_lat = lat;
            max_lat_cell = lat_cell;
            max_lat_dir = strsplit(message, ',', collapsedelimiters = false) (1,4) {1,:};
          endif
          if (lat < min_lat)
            min_lat = lat;
            min_lat_cell = lat_cell;
            min_lat_dir = strsplit(message, ',', collapsedelimiters = false) (1,4) {1,:};
          endif   
        
          lon_cell = strsplit(message, ',', collapsedelimiters = false) (1,5) {1,:};  
          lon = str2double(lon_cell(1:3)) + str2double(lon_cell(4:end)) / 60.0;
          if (lon > max_lon)
              max_lon = lon;
              max_lon_cell = lon_cell;
              max_lon_dir = strsplit(message, ',', collapsedelimiters = false) (1,6) {1,:};
          endif
          if (lon < min_lon)
              min_lon = lon;
              min_lon_cell = lon_cell;
              min_lon_dir = strsplit(message, ',', collapsedelimiters = false) (1,6) {1,:};
          endif  
        endif    
    end    
  
     # GLL
    if strcmp(message(1:6),'$GPGLL')   
        x = strsplit(message, ',', collapsedelimiters = false) (1,8) {1,:};
        x = strsplit(x, '*', collapsedelimiters = false) (1,2) {1,:};      
        qa = strsplit(message, ',', collapsedelimiters = false) (1,7) {1,:};

        if (x == chk && qa == 'A')
          #latitude
          lat_cell = strsplit(message, ',', collapsedelimiters = false) (1,2) {1,:};     
          lat = str2double(lat_cell(1:2)) + str2double(lat_cell(3:end)) / 60.0;
          if (lat > max_lat)
            max_lat = lat;
            max_lat_cell = lat_cell;
            max_lat_dir = strsplit(message, ',', collapsedelimiters = false) (1,3) {1,:};
          endif
          if (lat < min_lat)
            min_lat = lat;
            min_lat_cell = lat_cell;
            min_lat_dir = strsplit(message, ',', collapsedelimiters = false) (1,3) {1,:};
          endif   

          #longitude
          lon_cell = strsplit(message, ',', collapsedelimiters = false) (1,4) {1,:};  
          lon = str2double(lon_cell(1:3)) + str2double(lon_cell(4:end)) / 60.0;
          if (lon > max_lon)
              max_lon = lon;
              max_lon_cell = lon_cell;
              max_lon_dir = strsplit(message, ',', collapsedelimiters = false) (1,5) {1,:};
          endif
          if (lon < min_lon)
              min_lon = lon;
              min_lon_cell = lon_cell;
              min_lon_dir = strsplit(message, ',', collapsedelimiters = false) (1,5) {1,:};
          endif  
        endif    
    end  
    
    # RMC
    if strcmp(message(1:6),'$GPRMC')   
        x = strsplit(message, ',', collapsedelimiters = false) (1,13) {1,:};
        x = strsplit(x, '*', collapsedelimiters = false) (1,2) {1,:};      
        qa = strsplit(message, ',', collapsedelimiters = false) (1,3) {1,:};
        
       if (x == chk && qa == 'A')
          #latitude
          lat_cell = strsplit(message, ',', collapsedelimiters = false) (1,4) {1,:};     
          lat = str2double(lat_cell(1:2)) + str2double(lat_cell(3:end)) / 60.0;
          if (lat > max_lat)
            max_lat = lat;
            max_lat_cell = lat_cell;
            max_lat_dir = strsplit(message, ',', collapsedelimiters = false) (1,5) {1,:};
          endif
          if (lat < min_lat)
            min_lat = lat;
            min_lat_cell = lat_cell;
            min_lat_dir = strsplit(message, ',', collapsedelimiters = false) (1,5) {1,:};
          endif   

          #longitude
          lon_cell = strsplit(message, ',', collapsedelimiters = false) (1,6) {1,:};  
          lon = str2double(lon_cell(1:3)) + str2double(lon_cell(4:end)) / 60.0;
          if (lon > max_lon)
              max_lon = lon;
              max_lon_cell = lon_cell;
              max_lon_dir = strsplit(message, ',', collapsedelimiters = false) (1,7) {1,:};
          endif
          if (lon < min_lon)
              min_lon = lon;
              min_lon_cell = lon_cell;
              min_lon_dir = strsplit(message, ',', collapsedelimiters = false) (1,7) {1,:};
          endif  
        endif    
 
    end  
    
    message = fgetl(fid);   
end

disp('max latitude:');
disp(max_lat_cell);
disp(max_lat_dir);
disp('min latitude:');
disp(min_lat_cell);
disp(min_lat_dir);
disp('max longitude:');
disp(max_lon_cell);
disp(max_lon_dir);
disp('min longitude:');
disp(min_lon_cell);
disp(min_lon_dir);

fclose(fid);

