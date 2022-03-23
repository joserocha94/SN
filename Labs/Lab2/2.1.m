
# p1 = (38� 46� 49.61�� N, 9� 29� 56.19�� W, 103 m)
# The above format of the latitude and longitude will be referred to as DD� MM� SS.ss��.
# Rewrite those coordinates in the following formats: a) DD� MM.mmm�; b) DD.ddd�

tb_dms2dm.m

p1lat = [38 46 49.61];
p1lon = [09 29 56.19];
h1 = 103;

[dlat mlat] = tb_dms2dm(p1lat(1), p1lat(2), p1lat(3));
[dlon mlon] = tb_dms2dm(p1lon(1), p1lon(2), p1lon(3));


fprintf('Latitude: %d deg %f min\n', dlat, mlat);
fprintf('Longitude: %d deg %f min\n', dlon, mlon);
