function [ w ] = plot_EGG_WL_MRA_decomp( wave_decomposed)
%   GeoGravGOCE project
%   E. Pitenis
%   GravLab, AUTh, 19/9/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function for plotting the coefficients of the decomposed signal
%   ----------------------------------------------------------------------------------------
%% Load data
d1=wave_decomposed{3,1}{1,1}{1,1};
d2=wave_decomposed{3,1}{1,1}{2,1};
d3=wave_decomposed{3,1}{1,1}{3,1};
d4=wave_decomposed{3,1}{1,1}{4,1};
d5=wave_decomposed{3,1}{1,1}{5,1};
d6=wave_decomposed{3,1}{1,1}{6,1};
d7=wave_decomposed{3,1}{1,1}{7,1};
d8=wave_decomposed{3,1}{1,1}{8,1};
d9=wave_decomposed{3,1}{1,1}{9,1};
d10=wave_decomposed{3,1}{1,1}{10,1};
d11=wave_decomposed{3,1}{1,1}{11,1};
d12=wave_decomposed{3,1}{1,1}{12,1};
a12=wave_decomposed{3,1}{1,1}{13,1};
time_utc_nom_fractional_new=wave_decomposed{9,:}{1}(1:length(d1));
name_current_day=wave_decomposed{10,:}{1}(1:length(d1));

%% Plot detail and approximation coefficients
p = 1;
foldername = sprintf('Wavelets/WL MRA Decomposition/Coefficients%02',p);
mkdir(foldername);

% Plot of the detail coefficients of all levels
f = figure('visible','off');

subplot(2,2,1);
plot(time_utc_nom_fractional_new,d1,'DisplayName','d1 vs. Time','XDataSource','time_utc_nom_fractional_new','YDataSource','d1');
xlabel('UTC Time','fontsize',10);
y=ylabel('Eötvös','fontsize',10);
set(y,'Units','Normalized','Position',[-0.08, 0.5, 0] );
a=name_current_day(1,1); % needs for title
DateString = datestr(a); % needs for title
title(['d1 (8 - 16 km) 1st orbit ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters

subplot(2,2,2);
plot(time_utc_nom_fractional_new,d2,'DisplayName','d2 vs. Time','XDataSource','time_utc_nom_fractional_new','YDataSource','d2');
xlabel('UTC Time','fontsize',10);
y=ylabel('Eötvös','fontsize',10);
set(y,'Units','Normalized','Position',[-0.08, 0.5, 0] );
a=name_current_day(1,1); % needs for title
DateString = datestr(a); % needs for title
title(['d2 (16 - 32 km) 1st orbit ',num2str(DateString)],'fontsize',18,'FontWeight','bold')
datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters

subplot(2,2,3);
plot(time_utc_nom_fractional_new,d3,'DisplayName','d3 vs. Time','XDataSource','time_utc_nom_fractional_new','YDataSource','d3');
xlabel('UTC Time','fontsize',10);
y=ylabel('Eötvös','fontsize',10);
set(y,'Units','Normalized','Position',[-0.08, 0.5, 0] );
a=name_current_day(1,1); % needs for title
DateString = datestr(a); % needs for title
title(['d3 (32 - 64 km) 1st orbit ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters

subplot(2,2,4);
plot(time_utc_nom_fractional_new,d4,'DisplayName','d4 vs. Time','XDataSource','time_utc_nom_fractional_new','YDataSource','d4');
xlabel('UTC Time','fontsize',10);
y=ylabel('Eötvös','fontsize',10);
set(y,'Units','Normalized','Position',[-0.08, 0.5, 0] );
a=name_current_day(1,1); % needs for title
DateString = datestr(a); % needs for title
title(['d4 (64 - 128 km) 1st orbit ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
% save figures
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
filename_save = sprintf('Vzz_detail_coefficients_d1-d4_1st_orbit_%s.jpeg',num2str(DateString));
txtname = fullfile(foldername,filename_save);
print(f, txtname,'-djpeg','-r300');
% save .fig
set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');
filename_save = sprintf('Vzz_detail_coefficients_d1-d4_1st_orbit_%s.fig',num2str(DateString));
txtname = fullfile(foldername,filename_save);
savefig(txtname);

f = figure('visible','off');
subplot(2,2,1);
plot(time_utc_nom_fractional_new,d5,'DisplayName','d5 vs. Time','XDataSource','time_utc_nom_fractional_new','YDataSource','d5');
xlabel('UTC Time','fontsize',10);
y=ylabel('Eötvös','fontsize',10);
set(y,'Units','Normalized','Position',[-0.08, 0.5, 0] );
a=name_current_day(1,1); % needs for title
DateString = datestr(a); % needs for title
title(['d5 (128 - 256 km) 1st orbit ',num2str(DateString)],'fontsize',18,'FontWeight','bold')
datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters

subplot(2,2,2);
plot(time_utc_nom_fractional_new,d6,'DisplayName','d6 vs. Time','XDataSource','time_utc_nom_fractional_new','YDataSource','d6');
xlabel('UTC Time','fontsize',10);
y=ylabel('Eötvös','fontsize',10);
set(y,'Units','Normalized','Position',[-0.08, 0.5, 0] );
a=name_current_day(1,1); % needs for title
DateString = datestr(a); % needs for title
title(['d6 (256 - 512 km) 1st orbit ',num2str(DateString)],'fontsize',18,'FontWeight','bold')
datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters

subplot(2,2,3);
plot(time_utc_nom_fractional_new,d7,'DisplayName','d7 vs. Time','XDataSource','time_utc_nom_fractional_new','YDataSource','d7');
xlabel('UTC Time','fontsize',10);
y=ylabel('Eötvös','fontsize',10);
set(y,'Units','Normalized','Position',[-0.08, 0.5, 0] );
a=name_current_day(1,1); % needs for title
DateString = datestr(a); % needs for title
title(['d7 (512 - 1024 km) 1st orbit ',num2str(DateString)],'fontsize',18,'FontWeight','bold')
datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters

subplot(2,2,4);
plot(time_utc_nom_fractional_new,d8,'DisplayName','d8 vs. Time','XDataSource','time_utc_nom_fractional_new','YDataSource','d8');
xlabel('UTC Time','fontsize',10);
y=ylabel('Eötvös','fontsize',10);
set(y,'Units','Normalized','Position',[-0.08, 0.5, 0] );
a=name_current_day(1,1); % needs for title
DateString = datestr(a); % needs for title
title(['d8 (1024 - 2048 km) 1st orbit ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
% save figures
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
filename_save = sprintf('Vzz_detail_coefficients_d4-d8_1st_orbit_%s.jpeg',num2str(DateString));
txtname = fullfile(foldername,filename_save);
print(f, txtname,'-djpeg','-r300');

% save .fig
set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');
filename_save = sprintf('Vzz_detail_coefficients_d4-d8_1st_orbit_%s.fig',num2str(DateString));
txtname = fullfile(foldername,filename_save);
savefig(txtname);

f = figure('visible','off');
subplot(2,2,1);
plot(time_utc_nom_fractional_new,d9,'DisplayName','d9 vs. Time','XDataSource','time_utc_nom_fractional_new','YDataSource','d9');
xlabel('UTC Time','fontsize',10);
y=ylabel('Eötvös','fontsize',10);
set(y,'Units','Normalized','Position',[-0.08, 0.5, 0] );
a=name_current_day(1,1); % needs for title
DateString = datestr(a); % needs for title
title(['d9 (2048 - 4096 km) 1st orbit ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters

subplot(2,2,2);
plot(time_utc_nom_fractional_new,d10,'DisplayName','d10 vs. Time','XDataSource','time_utc_nom_fractional_new','YDataSource','d10');
xlabel('UTC Time','fontsize',10);
y=ylabel('Eötvös','fontsize',10);
set(y,'Units','Normalized','Position',[-0.08, 0.5, 0] );
a=name_current_day(1,1); % needs for title
DateString = datestr(a); % needs for title
title(['d10 (4096 - 8192 km) 1st orbit ',num2str(DateString)],'fontsize',18,'FontWeight','bold')
datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters

subplot(2,2,3);
plot(time_utc_nom_fractional_new,d11,'DisplayName','d11 vs. Time','XDataSource','time_utc_nom_fractional_new','YDataSource','d11');
xlabel('UTC Time','fontsize',10);
y=ylabel('Eötvös','fontsize',10);
set(y,'Units','Normalized','Position',[-0.08, 0.5, 0] );
a=name_current_day(1,1); % needs for title
DateString = datestr(a); % needs for title
title(['d11 (8192 - 16384 km) 1st orbit ',num2str(DateString)],'fontsize',18,'FontWeight','bold')
datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters

subplot(2,2,4);
plot(time_utc_nom_fractional_new,d12,'DisplayName','d12 vs. Time','XDataSource','time_utc_nom_fractional_new','YDataSource','d12');
xlabel('UTC Time','fontsize',10);
y=ylabel('Eötvös','fontsize',10);
set(y,'Units','Normalized','Position',[-0.08, 0.5, 0] );
a=name_current_day(1,1); % needs for title
DateString = datestr(a); % needs for title
title(['d12 (16384 - 32768 km) 1st orbit ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
set(gcf, 'paperunits', 'centimeters', 'paperposition', [0 0 40 20]);
% Set the general title of the whole plot
ax=axes;
set(ax,'Visible','off');
% save figures
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
filename_save = sprintf('Vzz_detail_coefficients_d8-d12_1st_orbit_%s.jpeg',num2str(DateString));
txtname = fullfile(foldername,filename_save);
print(f, txtname,'-djpeg','-r300');

% Plot of the approximation coefficient
f = figure('visible','off');
plot(time_utc_nom_fractional_new,a12,'DisplayName','a12 vs. Time','XDataSource','time_utc_nom_fractional_new','YDataSource','a12');
xlabel('UTC Time','fontsize',10);
y=ylabel('Eötvös','fontsize',10);
set(y,'Units','Normalized','Position',[-0.08, 0.5, 0] );
a=name_current_day(1,1); % needs for title
DateString = datestr(a); % needs for title
title(['Approximation coefficient at level 12 (a12) (16384 - 32768 km) 1st orbit ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters

% save figures
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
filename_save = sprintf('Vzz_appproximation_coefficient_1st_orbit_%s.jpeg',num2str(DateString));
txtname = fullfile(foldername,filename_save);
print(f, txtname,'-djpeg','-r300');

% save .fig
set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');
filename_save = sprintf('Vzz_appproximation_coefficient_1st_orbit_%s.fig',num2str(DateString));
txtname = fullfile(foldername,filename_save);
savefig(txtname);

w=1;
end