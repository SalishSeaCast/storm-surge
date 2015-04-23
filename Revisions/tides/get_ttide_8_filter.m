function [pred_all,pred_8,tim] = get_ttide_8_filter(csvfilename,location, starts, ends)
%returns the tidal predictions if only 8 constituents were used.
%the 8 constituents are: M2,K1,O1,P1,Q1,N2,S2,K2
%csvfilename contains DFO produced water level observations.
%pred_all is the t_tide prediction with all constituents
%pred_8 is the t_tide prediction with only 8 constituents
%saves a spreadsheet with tim, pred_all, pred_8
%starts is that start date for predictions (eg. 01-Jan-2006)
%ends is the end date for the predictions (eg. 31-Dec-2006)

% NKS May 2014

%% Initial harmonics and prediction caclulations
% Calculate harmonics
[tidestruc,lat,msl]=calculate_harmonics_filter(csvfilename,location);

%Remove long period constituents. Do not use these in the predictions
names_long = ['SA  '; 'SSA '; 'MSM '; 'MM  ';'MSF ';'MF  '];
for i=1:length(names_long)
n=names_long(i,:);
ind = strmatch(n,tidestruc.name,'exact');
tidestruc.name(ind,:) = [];
tidestruc.freq(ind) = [];
tidestruc.tidecon(ind,:) = [];
end


%Time
start_date=datenum(starts);
end_date=datenum(ends);
tim = start_date:1/24:end_date;
    
%Get predicted tide for same period
pred_all = t_predic(tim,tidestruc,'latitude',lat,'synthesis',2);


%% predictions with 8 constituents
%Create a new struct object with only 8 consts.
names_8=['M2'; 'K1'; 'O1';'P1';'Q1';'N2';'S2';'K2'];
freqs_8 = zeros(8,1);
pha_8 = zeros(8,1);
pha_err8 = zeros(8,1);
amp_8 = zeros(8,1);
amp_err8 = zeros(8,1);
 for i=1:8
n=names_8(i,:);
ind = strmatch(n,tidestruc.name,'exact');
freqs_8(i) = tidestruc.freq(ind);
amp_8(i) = tidestruc.tidecon(ind,1);
amp_err8(i) = tidestruc.tidecon(ind,2);
pha_8(i) = tidestruc.tidecon(ind,3);
pha_err8(i) = tidestruc.tidecon(ind,4);
 end
 
tidecon_8=[amp_8'; amp_err8'; pha_8'; pha_err8']';

tidestruc_8.name=names_8;
tidestruc_8.tidecon=tidecon_8;
tidestruc_8.freq=freqs_8;

pred_8 = t_predic(tim,tidestruc_8,'latitude',lat, 'synthesis', 2);

%% Predictions without nonlinear constituents
%Remove long period constituents. Do not use these in the predictions
names_nonlinear = ['M4  '; 'M6  '; 'M8  '; 'S6  '; 'MO3 '; 'MK3 '; '2MS2'; 'MS4 '; 'S4  '; 'MN4 '; 'NO1 '; 'OQ2 '; 'MKS2'; 'SO3 '; ];
for i=1:length(names_nonlinear)
n=names_nonlinear(i,:);
ind = strmatch(n,tidestruc.name,'exact');
tidestruc.name(ind,:) = [];
tidestruc.freq(ind) = [];
tidestruc.tidecon(ind,:) = [];
end


%Time
start_date=datenum(starts);
end_date=datenum(ends);
tim = start_date:1/24:end_date;
    
%Get predicted tide for same period
pred_no_nonlinear = t_predic(tim,tidestruc,'latitude',lat,'synthesis',2);

%% Plot 
figure
subplot(2,1,1)
plot(tim,pred_8,'b',tim,pred_all,'m',tim,pred_all-pred_8,'r')
legend('predictions 8 const.', 'predictions all','difference','Location','EastOutside')
xlabel('time')
ylabel('water level elevation (m CD)')
datetick('x','mm/yyyy')

subplot(2,1,2)
plot(tim,pred_8,'b',tim,pred_no_nonlinear,'m',tim,pred_no_nonlinear-pred_8,'r')
legend('predictions 8 const.', 'predictions all','difference','Location','EastOutside')
xlabel('time')
ylabel('water level elevation (m CD)')
datetick('x','mm/yyyy')

%% Save predictions
M = datestr(tim);
n = length(tim);
filename = [location  '_t_tide_compare8_' datestr(start_date) '_' datestr(end_date) '_snr2_filter.csv'];
fid = fopen(filename, 'w');
%add some headers
fprintf(fid, 'Harmonics from: ,');
fprintf(fid, '%s,\n',csvfilename);
fprintf(fid, 'Mean ,');
fprintf(fid, '%f,\n',msl);
fprintf(fid, 'Latitude ,');
fprintf(fid, '%f,\n',lat);
fprintf(fid, 'Time_Local , pred_8 , pred_all ,\n');
for row=1:n
    fprintf(fid, '%s ,', M(row,:));
    fprintf(fid,' %f,', pred_8(row));
    fprintf(fid,' %f,\n', pred_all(row));
end
fclose(fid);
