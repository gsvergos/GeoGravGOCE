function [ w ] = plot_EGG_GGM_GRF( GGM_LNOF_2_GRF)
%   GeoGravGOCE project
%   E. Pitenis
%   GravLab, AUTh, 20/2/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function for plotting the  GGM's GGs in GRF
%   ----------------------------------------------------------------------------------------
%% Plotting process
Vxx_GRF=GGM_LNOF_2_GRF{6,1};
Vyy_GRF=GGM_LNOF_2_GRF{7,1};
Vzz_GRF=GGM_LNOF_2_GRF{8,1};
Vxy_GRF=GGM_LNOF_2_GRF{9,1};
Vxz_GRF=GGM_LNOF_2_GRF{10,1};
Vyz_GRF=GGM_LNOF_2_GRF{11,1};
time_utc_nom_fractional_new =GGM_LNOF_2_GRF{4,1};
name_current_day=GGM_LNOF_2_GRF{5,1};

% Creation of folder
p = 1;
foldername = sprintf('GGM Transformations/Gravity Gradients GGM GRF%02',p);
mkdir(foldername);


NumTicks = 3; % It keeps three labels of time on the X-axis of figures.
counter_fig_close=1;

for i=1:length(Vxx_GRF)
    
    f = figure('visible','off');
    
    subplot(2,3,1)
    plot(time_utc_nom_fractional_new{i},Vxx_GRF{i}, 'color','b');
    xlabel('UTC Time','fontsize',14) %'format', 'HH:mm:ss')
    ylabel('Vxx (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vxx Gradient - GRF, ',num2str(DateString)],'fontsize',16,'FontWeight','bold')
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    subplot(2,3,2)
    plot(time_utc_nom_fractional_new{i},Vyy_GRF{i}, 'color', 'b');
    xlabel('UTC Time','fontsize',14)
    ylabel('Vyy (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vyy Gradient - GRF, ',num2str(DateString)],'fontsize',16,'FontWeight','bold')
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    
    subplot(2,3,3)
    plot(time_utc_nom_fractional_new{i},Vzz_GRF{i}, 'color', 'b');
    xlabel('UTC Time','fontsize',14)
    ylabel('Vzz (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vzz Gradient - GRF, ',num2str(DateString)],'fontsize',16,'FontWeight','bold')
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    subplot(2,3,4)
    plot(time_utc_nom_fractional_new{i},Vxy_GRF{i}, 'color', 'b');
    xlabel('UTC Time','fontsize',14)
    ylabel('Vxy (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vxy Gradient - GRF, ',num2str(DateString)],'fontsize',16,'FontWeight','bold')
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    subplot(2,3,5)
    plot(time_utc_nom_fractional_new{i},Vxz_GRF{i}, 'color', 'b');
    xlabel('UTC Time','fontsize',14)
    ylabel('Vxz (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vxz Gradient - GRF, ',num2str(DateString)],'fontsize',16,'FontWeight','bold')
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    subplot(2,3,6)
    plot(time_utc_nom_fractional_new{i},Vyz_GRF{i}, 'color', 'b');
    xlabel('UTC Time','fontsize',14)
    ylabel('Vyz (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vyz Gradient - GRF, ',num2str(DateString)],'fontsize',16,'FontWeight','bold')
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    
    %save
    set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
    filename_save = sprintf('GG_GGM_GRF_%s.jpeg',num2str(DateString));
    txtname = fullfile(foldername,filename_save);
    print(f, txtname,'-djpeg','-r300')
    
    % save .fig
    set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');
    filename_save = sprintf('GG_GGM_GRF_%s.fig',num2str(DateString));
    txtname = fullfile(foldername,filename_save);
    savefig(txtname);
    if i==1
        fprintf(2, '\nGeoGravGOCE Info:\n')
    end
    disp('A figure was saved in "Gravity Gradients GGM GRF" folder.')
    
    w=1;
    
end
% message for the user/ all ok/ check the folder "Gravity Gradients GGM GRF"
% for the results.
Opt.Interpreter = 'tex';
Opt.WindowStyle = 'normal';
msgbox({'Your figures (.jpeg) and (.fig) were saved in the new folder "GGM Transformations/Gravity Gradients GGM GRF" .';'';' Check them!'}, 'Info', 'help', Opt);
end

