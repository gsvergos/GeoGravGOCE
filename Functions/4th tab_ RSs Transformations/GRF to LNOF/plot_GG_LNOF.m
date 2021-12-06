function [ w ] = plot_GG_LNOF( VLNOF_gradients)
%   GeoGravGOCE project
%   E. Pitenis
%   GravLab, AUTh, 28/9/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function for plotting gravity gradients in LNOF
%   ----------------------------------------------------------------------------------------
%% Plotting gravity gradients in LNOF
% data clasification
time_utc_nom_fractional_new=VLNOF_gradients{4,1};
name_current_day=VLNOF_gradients{5,1};
VxxLNOF=VLNOF_gradients{6,1};
VyyLNOF=VLNOF_gradients{7,1};
VzzLNOF=VLNOF_gradients{8,1};
VxyLNOF=VLNOF_gradients{9,1};
VxzLNOF=VLNOF_gradients{10,1};
VyzLNOF=VLNOF_gradients{11,1};

% Creation of folder
p = 1;
foldername = sprintf('RSs Transformations - to LNOF/Gravity Gradients in LNOF%02',p);
mkdir(foldername);

counter_fig_close=1;
NumTicks = 3;

for i=1:length(VxxLNOF)
    
    %plots of V gradients in LNOF
    %Vxx
    
    f = figure('visible','off');
    subplot(2,3,1)
    plot(time_utc_nom_fractional_new{i},VxxLNOF{i},'DisplayName','Vxx vs. Time','XDataSource','Time','YDataSource','Vxx');
    xlabel('UTC Time','fontsize',14);
    ylabel('Vxx (Eötvös)','fontsize',14);
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vxx LNOF , ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks));
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    
    %Vyy
    subplot(2,3,2)
    plot(time_utc_nom_fractional_new{i},VyyLNOF{i},'DisplayName','Vyy vs. Time','XDataSource','Time','YDataSource','Vyy');
    xlabel('UTC Time','fontsize',14);
    ylabel('Vyy (Eötvös)','fontsize',14);
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vyy LNOF , ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks));
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    %Vzz
    subplot(2,3,3)
    plot(time_utc_nom_fractional_new{i},VzzLNOF{i},'DisplayName','Vzz vs. Time','XDataSource','Time','YDataSource','Vzz');
    xlabel('UTC Time','fontsize',14);
    ylabel('Vzz (Eötvös)','fontsize',14);
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vzz LNOF , ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks));
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    %Vxy
    subplot(2,3,4)
    plot(time_utc_nom_fractional_new{i},VxyLNOF{i},'DisplayName','Vxy vs. Time','XDataSource','Time','YDataSource','Vxy');
    xlabel('UTC Time','fontsize',14);
    ylabel('Vxy (Eötvös)','fontsize',14);
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vxy LNOF , ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks));
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    %Vxz
    subplot(2,3,5)
    plot(time_utc_nom_fractional_new{i},VxzLNOF{i},'DisplayName','Vxz vs. Time','XDataSource','Time','YDataSource','Vxz');
    xlabel('UTC Time','fontsize',14);
    ylabel('Vxz (Eötvös)','fontsize',14);
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vxz LNOF , ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks));
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    %Vyz
    subplot(2,3,6)
    plot(time_utc_nom_fractional_new{i},VyzLNOF{i},'DisplayName','Vyz vs. Time','XDataSource','Time','YDataSource','Vyz');
    xlabel('UTC Time','fontsize',14);
    ylabel('Vyz (Eötvös)','fontsize',14);
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vyz LNOF , ',num2str(DateString)],'fontsize',18,'FontWeight','bold');
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks));
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    %save
    set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
    filename_save = sprintf('GG_LNOF_%s.jpeg',num2str(DateString));
    txtname = fullfile(foldername,filename_save);
    print(f, txtname,'-djpeg','-r300')
    
    % save .fig
    set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');
    filename_save = sprintf('GG_LNOF_%s.fig',num2str(DateString));
    txtname = fullfile(foldername,filename_save);
    savefig(txtname);
    if i==1
        fprintf(2, '\nGeoGravGOCE Info:\n')
    end
    disp('a figure was saved in "Gravity Gradients in LNOF" folder')
    
    w=1;
end

% message for the user/ all ok/ check the folder "Gravity Gradients GGM GRF"
% for the results.
Opt.Interpreter = 'tex';
Opt.WindowStyle = 'normal';
msgbox({'Your figures (.jpeg) and (.fig) were saved in the new folder "RSs Transformations - to LNOF/Gravity Gradients in LNOF" .';'';' Check them!'}, 'Info', 'help', Opt);

end