function  [tidestruc, lat, mean_wl] = calculate_harmonics_filter(csvfilename,location)
%caclulate_harmonics(csvfilename,location, start) Calculates tidal
%harmonics at specifie location
%   Uses t_tide to write a file with tidal harmonics from a time series in
%   csvfilename.
%   location is a string of the location. 
%   note that for accurate harmonics the time series needs to be one year
%   long. Also avoid using surge-heavy years as that could over estimate
%   the harmonics.
%   returns the tidestruc from the ttide analysis, and the lat and mean sea
%   level from the data file.
%   Saves the harmoics in a file. 
%   This function is used by get_ttide_8.m

%NKS June 2014

%Read in the measured water level data the location
fid = fopen(csvfilename);
meas = textscan(fid,'%f/%f/%f %f:%f,%f,','HeaderLines',8);
lat = csvread(csvfilename,2,1,[2,1,2,1]);
fclose(fid);

%Calculate dates from columns of data
time = datenum(meas{1},meas{2},meas{3},meas{4},meas{5},0);
wlev = meas{6};

%Start date of measured water level record
start_date = time(1);
end_date = time(end);

%Truncated time series based on a tidal filter
wlev_modified = filter_tides(csvfilename,0.3);

clear time newmeas meas

%Use t_tide to determine harmonic constituents. Needs to be at least one
%year time series (366 days)
analysis_file = [location  '_analysis_filter_' datestr(start_date) '_' datestr(end_date) ];
[tidestruc,~] = t_tide(wlev_modified,'start time',start_date(1,1),'latitude',lat,'output',analysis_file);
%should I output the tidal prediction too and pass it along in get_ttide_8?

%mean water level
mean_wl = nanmean(wlev_modified);
%Save the harmonics
harmonics_file = [location  '_harmonics_' datestr(start_date) '_' datestr(end_date) '_filter.csv'];
fid = fopen(harmonics_file, 'w');
%add some headers
fprintf(fid, 'Mean \t');
fprintf(fid, '%f\n',mean_wl);
fprintf(fid, 'Latitude \t');
fprintf(fid, '%f\n',lat);

fprintf(fid, 'Constituent \t freq \t amp (m) \t amp error \t phase (deg PST) \t phase error \n');
for row=1:length(tidestruc.freq)
    fprintf(fid, '%s \t', tidestruc.name(row,:));
    fprintf(fid,' %f\t', tidestruc.freq(row));
    fprintf(fid,' %f\t', tidestruc.tidecon(row,1));
    fprintf(fid,' %f\t', tidestruc.tidecon(row,2));
    fprintf(fid,' %f\t', tidestruc.tidecon(row,3));
    fprintf(fid,' %f\t', tidestruc.tidecon(row,4));
end
fclose(fid);

end

