function [ w ] = plot_EGG_WL_MRA( GG_WL)
%   GeoGravGOCE project
%   E. Pitenis
%   GravLab, AUTh, 15/8/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function for plotting the gravity gradinets after WL MRA
%   ----------------------------------------------------------------------------------------
%% Load data
% classification
synthesis_vxx_det = GG_WL{6,1};
synthesis_vyy_det = GG_WL{7,1};
synthesis_vzz_det = GG_WL{8,1};
synthesis_vxy_det = GG_WL{9,1};
synthesis_vxz_det = GG_WL{10,1};
synthesis_vyz_det = GG_WL{11,1};
time_utc_nom_fractional_new=GG_WL{4,1};
name_current_day=GG_WL{5,1};

%% Plot of syntheses
% Creation of folder
p = 1;
foldername = sprintf('Wavelets/WL MRA Reconstruction/Gravity Gradients after WL MRA%02',p);
mkdir(foldername)


NumTicks = 3; % It keeps three labels of time on the X-axis of figures.
counter_fig_close=1;

for i=1:length(synthesis_vxx_det)
    
    f = figure('visible','off');
    
    subplot(2,3,1)
    plot(time_utc_nom_fractional_new{i},synthesis_vxx_det{i}, 'color','b');
    xlabel('UTC Time','fontsize',14) %'format', 'HH:mm:ss')
    ylabel('Vxx  (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vxx  Gradient , ',num2str(DateString)],'fontsize',16,'FontWeight','bold')
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    subplot(2,3,2)
    plot(time_utc_nom_fractional_new{i},synthesis_vyy_det{i}, 'color', 'b');
    xlabel('UTC Time','fontsize',14)
    ylabel('Vyy  (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vyy  Gradient , ',num2str(DateString)],'fontsize',16,'FontWeight','bold')
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    subplot(2,3,3)
    plot(time_utc_nom_fractional_new{i},synthesis_vzz_det{i}, 'color', 'b');
    xlabel('UTC Time','fontsize',14)
    ylabel('Vzz  (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vzz  Gradient , ',num2str(DateString)],'fontsize',16,'FontWeight','bold')
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    subplot(2,3,4)
    plot(time_utc_nom_fractional_new{i},synthesis_vxy_det{i}, 'color', 'b');
    xlabel('UTC Time','fontsize',14)
    ylabel('Vxy  (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vxy  Gradient , ',num2str(DateString)],'fontsize',16,'FontWeight','bold')
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    subplot(2,3,5)
    plot(time_utc_nom_fractional_new{i},synthesis_vxz_det{i}, 'color', 'b');
    xlabel('UTC Time','fontsize',14)
    ylabel('Vxz  (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vxz  Gradient , ',num2str(DateString)],'fontsize',16,'FontWeight','bold')
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    subplot(2,3,6)
    plot(time_utc_nom_fractional_new{i},synthesis_vyz_det{i}, 'color', 'b');
    xlabel('UTC Time','fontsize',14)
    ylabel('Vyz  (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vyz  Gradient , ',num2str(DateString)],'fontsize',16,'FontWeight','bold')
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    
    % save figures
    set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
    filename_save = sprintf('GG_Synthesis_%s.jpeg',num2str(DateString));
    txtname = fullfile(foldername,filename_save);
    print(f, txtname,'-djpeg','-r300')
    
    % save .fig
    set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');
    filename_save = sprintf('GG_Synthesis_%s.fig',num2str(DateString));
    txtname = fullfile(foldername,filename_save);
    savefig(txtname);
    
    counter_fig_close=counter_fig_close+1;
    
    % close figures..save memory!
    if counter_fig_close>5
        counter_fig_close=1;
        close all
    end
    
end

w=1;
% message for the user/ all ok/ check the folder "Gravity Gradients after WL MRA"
% for the results.
Opt.Interpreter = 'tex';
Opt.WindowStyle = 'normal';
msgbox({'Your figures (.jpeg) and (.fig) were saved in the new folder "WL MRA Reconstruction/Gravity Gradients after WL MRA " .';'';' Check them!'}, 'Info', 'help', Opt);

end