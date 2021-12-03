function [ w ] = plot_EGG_NOM_2( GG_coords_GRF,currentFolder)
%    GeoGravGOCE project
%    E. Mamagiannou, D. Natsiopoulos
%    GravLab, AUTh, 5/2/2020

%    ---------------------------------------------------------------------------------------------
%    INFO
%    function for plotting the SGGs in GRF.

%    *** Input ***:
%    GG_coords_GRF = the output of GUI's 1st tab
%    currentFolder =  the current working folder (you can identify it with "pwd")

%    *** output ***:
%    Vij_GRF__date.jpeg
%    Vij_GRF__date.fig
%    w = counter/ is needed for checks in the GUI
%    ---------------------------------------------------------------------------------------------

%% classification
% Gravity Gradients, time, name
Vxx = GG_coords_GRF{4,1};
Vyy = GG_coords_GRF{5,1};
Vzz = GG_coords_GRF{6,1};
Vxy = GG_coords_GRF{7,1};
Vxz = GG_coords_GRF{8,1};
Vyz = GG_coords_GRF{9,1};
time_utc_nom_fractional_new = GG_coords_GRF{11,1};
name_current_day = GG_coords_GRF{12,1}; %needed for plots

% create a folder to save all the figures (.jpeg) "Vij_GRF_date"
p = 1;
foldername = sprintf('Gravity Gradients GRF%02',p);
currentFolder1=[currentFolder, '\SGG Pre-Processing'];
mkdir(currentFolder1, foldername);
currentFolder2=[currentFolder, '\SGG Pre-Processing\Gravity Gradients GRF'];

NumTicks = 3; % It keeps three labels of time on the X-axis of figures.

for i=1:length(Vxx)
    f = figure('visible','off');
    subplot(2,3,1)
    plot(time_utc_nom_fractional_new{i},Vxx{i}, 'color','b');
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
    plot(time_utc_nom_fractional_new{i},Vyy{i}, 'color', 'b');
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
    plot(time_utc_nom_fractional_new{i},Vzz{i}, 'color', 'b');
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
    plot(time_utc_nom_fractional_new{i},Vxy{i}, 'color', 'b');
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
    plot(time_utc_nom_fractional_new{i},Vxz{i}, 'color', 'b');
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
    plot(time_utc_nom_fractional_new{i},Vyz{i}, 'color', 'b');
    xlabel('UTC Time','fontsize',14)
    ylabel('Vyz (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Vyz Gradient - GRF, ',num2str(DateString)],'fontsize',16,'FontWeight','bold')
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    %save .jpeg
    set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
    filename_save = sprintf('Vij_GRF__%s.jpeg',num2str(DateString));
    txtname = fullfile(currentFolder2,filename_save);
    print(f, txtname,'-djpeg','-r300')
    
    %save .fig
    set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');  % needed it/ reopen the fig
    filename_save = sprintf('Vij_GRF__%s.fig',num2str(DateString));
    txtname = fullfile(currentFolder2,filename_save);
    savefig(txtname);
    if i==1
        fprintf(2, '\nGeoGravGOCE Info:\n')
    end
    disp('A figure was saved in "Gravity Gradients GRF" folder.')
    w=1; % output
end

% message for the user/ all ok/ check the folder "Gravity Gradients GRF"
Opt.Interpreter = 'tex';
Opt.WindowStyle = 'normal';
msgbox({'Your figures (.jpeg & .fig) were saved in the new folder';' "Gravity Gradients GRF" .';'';' Check them!'}, 'Info', 'help', Opt);

end
