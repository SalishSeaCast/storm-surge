function wlev_modified = filter_tides(csvfilename, cut_off)
%%% Removes tidal energy of a time series based on a Doodson fitlter and
%%% then modifes that time series by removing events that contain a large
%%% amount of non-tidal energy (like storm surges). Data is removed if the
%%% filtered time series is |filtered-annual mean| < cut_off. cut_off
%%% should be the same units as the time series stored in csvfilename

%%% returns wlev_modified: the time series with surge events removed. Also
%%% plots the filtering process. 

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

%measured data may not have entry for every date in the range
tim = start_date:1/24:end_date;
newmeas = zeros(length(tim),2);

%counter in measured time
counter = 1;
%tt is counter in created time
for tt = 1:length(tim)
    if time(counter) == tim(tt)
        newmeas(tt,1:2) = [time(counter), wlev(counter)];
        counter = counter + 1;
    else
        newmeas(tt,1:2) = [tim(tt), NaN];
    end
end

wlev = newmeas(:,2);


%Creating doodson filter (NOAA book)
ze=[0,5,8,10,13,15,16,18];
ze=[-ze,ze];
onethir = [2,3,6,7,11,12,14,17,19];
onethir=[-onethir,onethir];
twothir = [1,4,9];
twothir=[-twothir,twothir];
filt = zeros(19,1);
for i=-19:19
    if any(abs(i-ze)<1e-10)
        filt(i+20) = 0;
    elseif any(abs(i-onethir)<1e-10)
        filt(i+20) = 1/30;
    else any(abs(i-twothir)<1e-10)
        filt(i+20) = 2/30; 
    end
end
        
% filter the data using the Doodson filter above. just leave end points as
% annula mean 
wlev_filt = zeros(1,length(wlev));
for i=20:(length(wlev_filt)-20)
    wlev_filt(i) = sum(filt.*wlev(i-19:i+19));
end
wlev_filt(1:19)=nanmean(wlev);
wlev_filt((length(wlev)-19):end) = nanmean(wlev);

%Create lines to plot info being removed based on cutoff
mean = nanmean(wlev)*ones(size(wlev));
plus_mean = mean+cut_off;
minus_mean = mean-cut_off;

%modify data with "cut_off" times set to NaNs.
wlev_modified = wlev;
wlev_modified(wlev_filt > plus_mean(1)) = NaN;
wlev_modified(wlev_filt < minus_mean(1)) = NaN;

%plot everything
figure
subplot(2,1,1)
plot(tim,wlev,'b',tim,wlev_filt,'m',tim,mean,'k--',tim,plus_mean, 'r-',tim,minus_mean,'r-')
legend('Original','Filtered','Annual Mean')
xlabel('time')
ylabel('water level elevation (m CD)')
datetick('x','mm/yyyy')
title('Time Series and Filter')
subplot(2,1,2)
plot(tim,wlev_modified,'k-')
legend('Adjusted time series')
xlabel('time')
ylabel('water level elevation (m CD)')
datetick('x','mm/yyyy')
title('Time series with large non-tidal events removed')