function [ w ] = plot_GG_GRF( VGRF_gradients)
%   GeoGravGOCE project
%   E. Pitenis
%   GravLab, AUTh, 28/9/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function for plotting gravity gradients in GRF
%   ----------------------------------------------------------------------------------------
%% Plotting of gravity gradients in GRF
% data clasification
time_utc_nom_fractional_new=VGRF_gradients{4,1};
name_current_day=VGRF_gradients{5,1};
VxxGRF=VGRF_gradients{6,1};
VyyGRF=VGRF_gradients{7,1};
VzzGRF=VGRF_gradients{8,1};
VxyGRF=VGRF_gradients{9,1};
VxzGRF=VGRF_gradients{10,1};
VyzGRF=VGRF_gradients{11,1};

% Creation of folder
p = 1;
foldername = sprintf('RSs Transformations - to GRF/Gravity Gradients in GRF%02',p);
mkdir(foldername);

counter_fig_close=1;
NumTicks = 3;

for i=1:length(VxxGRF)
    
    %plots of V gradients in GRF
    %Vxx
    
    f = figure('visible','off');
    subplot(2,3,1)
    plot(time_utc_nom_fractional_new{i},VxxGRF{i},'DisplayName','Vxx vs. Time','XDataSource','Time','YDataSource','Vxx');
    xlabel('UTC Time','fontsize',14);
    ylabel('Vxx (Eötvös)','fontsize',14);
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vxx GRF , ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks));
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    
    %Vyy
    subplot(2,3,2)
    plot(time_utc_nom_fractional_new{i},VyyGRF{i},'DisplayName','Vyy vs. Time','XDataSource','Time','YDataSource','Vyy');
    xlabel('UTC Time','fontsize',14);
    ylabel('Vyy (Eötvös)','fontsize',14);
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vyy GRF , ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks));
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    %Vzz
    subplot(2,3,3)
    plot(time_utc_nom_fractional_new{i},VzzGRF{i},'DisplayName','Vzz vs. Time','XDataSource','Time','YDataSource','Vzz');
    xlabel('UTC Time','fontsize',14);
    ylabel('Vzz (Eötvös)','fontsize',14);
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vzz GRF , ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks));
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    %Vxy
    subplot(2,3,4)
    plot(time_utc_nom_fractional_new{i},VxyGRF{i},'DisplayName','Vxy vs. Time','XDataSource','Time','YDataSource','Vxy');
    xlabel('UTC Time','fontsize',14);
    ylabel('Vxy (Eötvös)','fontsize',14);
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vxy GRF , ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks));
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    %Vxz
    subplot(2,3,5)
    plot(time_utc_nom_fractional_new{i},VxzGRF{i},'DisplayName','Vxz vs. Time','XDataSource','Time','YDataSource','Vxz');
    xlabel('UTC Time','fontsize',14);
    ylabel('Vxz (Eötvös)','fontsize',14);
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vxz GRF , ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks));
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    %Vyz
    subplot(2,3,6)
    plot(time_utc_nom_fractional_new{i},VyzGRF{i},'DisplayName','Vyz vs. Time','XDataSource','Time','YDataSource','Vyz');
    xlabel('UTC Time','fontsize',14);
    ylabel('Vyz (Eötvös)','fontsize',14);
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vyz GRF , ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks));
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    %save
    set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
    filename_save = sprintf('GG_GRF_%s.jpeg',num2str(DateString));
    txtname = fullfile(foldername,filename_save);
    print(f, txtname,'-djpeg','-r300')
    
    % save .fig
    set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');
    filename_save = sprintf('GG_GRF_%s.fig',num2str(DateString));
    txtname = fullfile(foldername,filename_save);
    savefig(txtname);
    if i==1
        fprintf(2, '\nGeoGravGOCE Info:\n')
    end
    disp('a figure was saved in "Gravity Gradients in GRF" folder')

    w=1;
end

% message for the user/ all ok/ check the folder "Gravity Gradients GGM GRF"
% for the results.
Opt.Interpreter = 'tex';
Opt.WindowStyle = 'normal';
msgbox({'Your figures (.jpeg) and (.fig) were saved in the new folder "RSs Transformations - to GRF/Gravity Gradients in GRF" .';'';' Check them!'}, 'Info', 'help', Opt);

end