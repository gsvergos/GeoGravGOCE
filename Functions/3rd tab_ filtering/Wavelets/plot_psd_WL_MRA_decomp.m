function [ w ] = plot_psd_WL_MRA_decomp(wave_decomposed)
%   GeoGravGOCE project
%   E. Pitenis (f_normalized_psd function by D. Piretzidis)
%   GravLab, AUTh, 20/8/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function for plotting the psds of the coefficients of the decomposed signal
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
name_current_day=wave_decomposed{10,:}{1}(1:length(d1));
%% Computation of psds
% Creation of folder
p = 1;
foldername = sprintf('Wavelets/WL MRA Decomposition/PSDs of coefficients%02',p);
mkdir(foldername);

T_s=1; %sampling period (for GOCE the sampling period is 1 sec)
counter_fig_close=1;

f = figure('visible','off');
subplot(2,2,1)
[freq, spectrum]=f_normalized_psd(d1, T_s);
hold all
% MBW limits
x1=[0.005 0.005];
x2=[0.1 0.1];
y1=[10^(-8) 10^(6)];
plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold on
plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold off;

% Arrow with two head at both end and text between
y = [0.615 0.615];
x = [0.37 0.40];     % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
annotation('textarrow',x,y,'String','MBW  ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
x = [0.34 0.31];
annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
%hold off;
set(gca,'YScale','log','XScale','log');
grid on;
%axis labels
xlabel('Frequency (Hz) ','fontsize',14)
ylabel('Power','fontsize',14)
axis([10^(-5),10^(0),10^(-8),10^(2)]);
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
name=name_current_day(1,1);
DateString = datestr( name );
title({['\bf\fontsize{16}PSD of d1 1st orbit ',num2str(DateString)]})
legend('PSD d1');

subplot(2,2,2)
[freq, spectrum]=f_normalized_psd(d2, T_s);
hold all
% MBW limits
x1=[0.005 0.005];
x2=[0.1 0.1];
y1=[10^(-8) 10^(6)];
plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold on
plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold off;


% Arrow with two head at both end and text between
y = [0.615 0.615];
x = [0.81 0.84];    % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
annotation('textarrow',x,y,'String','MBW  ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
x = [0.78 0.75];
annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
hold off;
set(gca,'YScale','log','XScale','log');
grid on;
%axis labels
xlabel('Frequency (Hz) ','fontsize',14)
ylabel('Power','fontsize',14)
axis([10^(-5),10^(0),10^(-8),10^(2)]);
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
name=name_current_day(1,1);
DateString = datestr( name );
title({['\bf\fontsize{16}PSD of d2 1st orbit ',num2str(DateString)] })
legend('PSD d2 ');


subplot(2,2,3)
[freq, spectrum]=f_normalized_psd(d3, T_s);
hold all
% MBW limits
x1=[0.005 0.005];
x2=[0.1 0.1];
y1=[10^(-8) 10^(6)];
plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold on
plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold off;


% Arrow with two head at both end and text between
y = [0.141 0.141];
x = [0.37 0.40];       % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
annotation('textarrow',x,y,'String','MBW  ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
x = [0.34 0.31];
annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
hold off;
set(gca,'YScale','log','XScale','log');
grid on;
%axis labels
xlabel('Frequency (Hz) ','fontsize',14)
ylabel('Power','fontsize',14)
axis([10^(-5),10^(0),10^(-8),10^(2)]);
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
name=name_current_day(1,1);
DateString = datestr( name );
title({['\bf\fontsize{16}PSD of d3 1st orbit ',num2str(DateString)]})
legend('PSD d3 ');

subplot(2,2,4)
[freq, spectrum]=f_normalized_psd(d4, T_s);
hold all
% MBW limits
x1=[0.005 0.005];
x2=[0.1 0.1];
y1=[10^(-8) 10^(6)];
plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold on
plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold off;


% Arrow with two head at both end and text between
y = [0.141 0.141];
x = [0.81 0.84];     % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
annotation('textarrow',x,y,'String','MBW  ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
x = [0.78 0.75];
annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
hold off;
set(gca,'YScale','log','XScale','log');
grid on;
%axis labels
xlabel('Frequency (Hz) ','fontsize',14)
ylabel('Power','fontsize',14)
axis([10^(-5),10^(0),10^(-8),10^(2)]);
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
name=name_current_day(1,1);
DateString = datestr( name );
title({['\bf\fontsize{16}PSD of d4 1st orbit ',num2str(DateString)]})
legend('PSD d4 ');

%g=i;
% save figures
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
filename_save = sprintf('PSDs_of_Vzz_d1_d4_1st_orbit_%s.jpeg',num2str(DateString));
% print(filename_save,'-djpeg','-r300')
txtname = fullfile(foldername,filename_save);
print(f, txtname,'-djpeg','-r300');

% save .fig
set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');
filename_save = sprintf('PSDs_of_Vzz_d1_d4_1st_orbit_%s.fig',num2str(DateString));
txtname = fullfile(foldername,filename_save);
savefig(txtname);
counter_fig_close=counter_fig_close+1;


if counter_fig_close>5
    counter_fig_close=1;
    close all
end

f = figure('visible','off');
subplot(2,2,1)
[freq, spectrum]=f_normalized_psd(d5, T_s);
hold all
% MBW limits
x1=[0.005 0.005];
x2=[0.1 0.1];
y1=[10^(-8) 10^(6)];
plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold on
plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold off;

% Arrow with two head at both end and text between
y = [0.615 0.615];
x = [0.37 0.40];     % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
annotation('textarrow',x,y,'String','MBW  ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
x = [0.34 0.31];
annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
%hold off;
set(gca,'YScale','log','XScale','log');
grid on;
%axis labels
xlabel('Frequency (Hz) ','fontsize',14)
ylabel('Power','fontsize',14)
axis([10^(-5),10^(0),10^(-8),10^(2)]);
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
name=name_current_day(1,1);
DateString = datestr( name );
title({['\bf\fontsize{16}PSD of d5 1st orbit ',num2str(DateString)]})
legend('PSD d5');

subplot(2,2,2)
[freq, spectrum]=f_normalized_psd(d6, T_s);
hold all
% MBW limits
x1=[0.005 0.005];
x2=[0.1 0.1];
y1=[10^(-8) 10^(6)];
plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold on
plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold off;


% Arrow with two head at both end and text between
y = [0.615 0.615];
x = [0.81 0.84];    % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
annotation('textarrow',x,y,'String','MBW  ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
x = [0.78 0.75];
annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
hold off;
set(gca,'YScale','log','XScale','log');
grid on;
%axis labels
xlabel('Frequency (Hz) ','fontsize',14)
ylabel('Power','fontsize',14)
axis([10^(-5),10^(0),10^(-8),10^(2)]);
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
name=name_current_day(1,1);
DateString = datestr( name );
title({['\bf\fontsize{16}PSD of d6 1st orbit ',num2str(DateString)] })
legend('PSD d6 ');


subplot(2,2,3)
[freq, spectrum]=f_normalized_psd(d7, T_s);
hold all
% MBW limits
x1=[0.005 0.005];
x2=[0.1 0.1];
y1=[10^(-8) 10^(6)];
plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold on
plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold off;


% Arrow with two head at both end and text between
y = [0.141 0.141];
x = [0.37 0.40];       % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
annotation('textarrow',x,y,'String','MBW  ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
x = [0.34 0.31];
annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
hold off;
set(gca,'YScale','log','XScale','log');
grid on;
%axis labels
xlabel('Frequency (Hz) ','fontsize',14)
ylabel('Power','fontsize',14)
axis([10^(-5),10^(0),10^(-8),10^(2)]);
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
name=name_current_day(1,1);
DateString = datestr( name );
title({['\bf\fontsize{16}PSD of d7 1st orbit ',num2str(DateString)]})
legend('PSD d7 ');

subplot(2,2,4)
[freq, spectrum]=f_normalized_psd(d8, T_s);
hold all
% MBW limits
x1=[0.005 0.005];
x2=[0.1 0.1];
y1=[10^(-8) 10^(6)];
plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold on
plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold off;


% Arrow with two head at both end and text between
y = [0.141 0.141];
x = [0.81 0.84];     % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
annotation('textarrow',x,y,'String','MBW  ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
x = [0.78 0.75];
annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
hold off;
set(gca,'YScale','log','XScale','log');
grid on;
%axis labels
xlabel('Frequency (Hz) ','fontsize',14)
ylabel('Power','fontsize',14)
axis([10^(-5),10^(0),10^(-8),10^(2)]);
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
name=name_current_day(1,1);
DateString = datestr( name );
title({['\bf\fontsize{16}PSD of d8 1st orbit ',num2str(DateString)]})
legend('PSD d8 ');

%g=i;
% save figures
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
filename_save = sprintf('PSDs_of_Vzz_d5_d8_1st_orbit_%s.jpeg',num2str(DateString));
% print(filename_save,'-djpeg','-r300')
txtname = fullfile(foldername,filename_save);
print(f, txtname,'-djpeg','-r300');

% save .fig
set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');
filename_save = sprintf('PSDs_of_Vzz_d5_d8_1st_orbit_%s.fig',num2str(DateString));
txtname = fullfile(foldername,filename_save);
savefig(txtname);
counter_fig_close=counter_fig_close+1;


if counter_fig_close>5
    counter_fig_close=1;
    close all
end

f = figure('visible','off');
subplot(2,2,1)
[freq, spectrum]=f_normalized_psd(d9, T_s);
hold all
% MBW limits
x1=[0.005 0.005];
x2=[0.1 0.1];
y1=[10^(-8) 10^(6)];
plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold on
plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold off;

% Arrow with two head at both end and text between
y = [0.615 0.615];
x = [0.37 0.40];     % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
annotation('textarrow',x,y,'String','MBW  ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
x = [0.34 0.31];
annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
%hold off;
set(gca,'YScale','log','XScale','log');
grid on;
%axis labels
xlabel('Frequency (Hz) ','fontsize',14)
ylabel('Power','fontsize',14)
axis([10^(-5),10^(0),10^(-8),10^(2)]);
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
name=name_current_day(1,1);
DateString = datestr( name );
title({['\bf\fontsize{16}PSD of d9 1st orbit ',num2str(DateString)]})
legend('PSD d9');

subplot(2,2,2)
[freq, spectrum]=f_normalized_psd(d10, T_s);
hold all
% MBW limits
x1=[0.005 0.005];
x2=[0.1 0.1];
y1=[10^(-8) 10^(6)];
plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold on
plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold off;


% Arrow with two head at both end and text between
y = [0.615 0.615];
x = [0.81 0.84];    % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
annotation('textarrow',x,y,'String','MBW  ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
x = [0.78 0.75];
annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
hold off;
set(gca,'YScale','log','XScale','log');
grid on;
%axis labels
xlabel('Frequency (Hz) ','fontsize',14)
ylabel('Power','fontsize',14)
axis([10^(-5),10^(0),10^(-8),10^(2)]);
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
name=name_current_day(1,1);
DateString = datestr( name );
title({['\bf\fontsize{16}PSD of d10 1st orbit ',num2str(DateString)] })
legend('PSD d10 ');


subplot(2,2,3)
[freq, spectrum]=f_normalized_psd(d11, T_s);
hold all
% MBW limits
x1=[0.005 0.005];
x2=[0.1 0.1];
y1=[10^(-8) 10^(6)];
plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold on
plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold off;


% Arrow with two head at both end and text between
y = [0.141 0.141];
x = [0.37 0.40];       % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
annotation('textarrow',x,y,'String','MBW  ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
x = [0.34 0.31];
annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
hold off;
set(gca,'YScale','log','XScale','log');
grid on;
%axis labels
xlabel('Frequency (Hz) ','fontsize',14)
ylabel('Power','fontsize',14)
axis([10^(-5),10^(0),10^(-8),10^(2)]);
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
name=name_current_day(1,1);
DateString = datestr( name );
title({['\bf\fontsize{16}PSD of d11 1st orbit ',num2str(DateString)]})
legend('PSD d11 ');

subplot(2,2,4)
[freq, spectrum]=f_normalized_psd(d12, T_s);
hold all
% MBW limits
x1=[0.005 0.005];
x2=[0.1 0.1];
y1=[10^(-8) 10^(6)];
plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold on
plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
hold off;


% Arrow with two head at both end and text between
y = [0.141 0.141];
x = [0.81 0.84];     % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
annotation('textarrow',x,y,'String','MBW  ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
x = [0.78 0.75];
annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
hold off;
set(gca,'YScale','log','XScale','log');
grid on;
%axis labels
xlabel('Frequency (Hz) ','fontsize',14)
ylabel('Power','fontsize',14)
axis([10^(-5),10^(0),10^(-8),10^(2)]);
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
name=name_current_day(1,1);
DateString = datestr( name );
title({['\bf\fontsize{16}PSD of d12 1st orbit ',num2str(DateString)]})
legend('PSD d12 ');

%g=i;
% save figures
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
filename_save = sprintf('PSDs_of_Vzz_d9_d12_1st_orbit_%s.jpeg',num2str(DateString));
% print(filename_save,'-djpeg','-r300')
txtname = fullfile(foldername,filename_save);
print(f, txtname,'-djpeg','-r300');

% save .fig
set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');
filename_save = sprintf('PSDs_of_Vzz_d9_d12_1st_orbit_%s.fig',num2str(DateString));
txtname = fullfile(foldername,filename_save);
savefig(txtname);
counter_fig_close=counter_fig_close+1;


if counter_fig_close>5
    counter_fig_close=1;
    close all
end

f = figure('visible','off');
[freq, spectrum]=f_normalized_psd(a12, T_s);
hold all
% MBW limits
x1=[0.005 0.005];
x2=[0.1 0.1];
y1=[10^(-8) 10^(6)];
plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0]);
hold on
plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0]);
hold off;
% Arrow with two head at both end and text between
y = [0.141 0.141];
x = [0.66 0.75];     % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
annotation('textarrow',x,y,'String','     MBW','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
x = [0.64 0.55];
annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
hold off;
set(gca,'YScale','log','XScale','log');
grid on;
%axis labels
xlabel('Frequency (Hz) ','fontsize',14)
ylabel('Power','fontsize',14)
axis([10^(-5),10^(0),10^(-8),10^(2)]);
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
name=name_current_day(1,1);
DateString = datestr( name );
title({['\bf\fontsize{16}PSD of a12 1st orbit ',num2str(DateString)]});
legend('PSD a12 ');

%g=i;
% save figures
set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
filename_save = sprintf('PSDs_of_Vzz_a12_1st_orbit_%s.jpeg',num2str(DateString));
% print(filename_save,'-djpeg','-r300')
txtname = fullfile(foldername,filename_save);
print(f, txtname,'-djpeg','-r300');

% save .fig
set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');
filename_save = sprintf('PSDs_of_Vzz_a12_1st_orbit_%s.fig',num2str(DateString));
txtname = fullfile(foldername,filename_save);
savefig(txtname);
counter_fig_close=counter_fig_close+1;


if counter_fig_close>5
    counter_fig_close=1;
    close all
end

w=1;
% message for the user/ all ok/ check the folder "PSDs after WL MRA"
% for the results.
Opt.Interpreter = 'tex';
Opt.WindowStyle = 'normal';
msgbox({'Figures (.jpeg) and (.fig) of the detail coefficients and their PSDs for the 1st orbit of the 1st day were saved in the new folder "WL MRA Decomposition " .';'';' Check them!'}, 'Info', 'help', Opt);

end
