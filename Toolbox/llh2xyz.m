
tb_dms2dm.m

p1lat = [38 46 49.61];
p1lon = [09 29 56.19];
h1 = 103;

[dlat mlat] = tb_dms2dm(p1lat(1), p1lat(2), p1lat(3));
[dlon mlon] = tb_dms2dm(p1lon(1), p1lon(2), p1lon(3));

fprintf('Latitude: %d deg %f min\n', dlat, mlat);
fprintf('Longitude: %d deg %f min\n', dlon, mlon);

%to do: fix this  code
