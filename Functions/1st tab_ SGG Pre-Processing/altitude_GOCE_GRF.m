function [ k ] = altitude_GOCE_GRF( GG_coords_GRF,currentFolder)
%   GeoGravGOCE project
%   E. Mamagiannou, D. Natsiopoulos
%   GravLab, AUTh, 15/3/2020

%   ---------------------------------------------------------------------------------------------
%   INFO
%   *** function for plotting the GOCE Altitude in (Km) ***

%   *** Input ***:
%   GG_coords_GRF = the output of GUI's 1st tab
%   currentFolder =  the current working folder (you can identify it with "pwd")

%   *** output ***:
%   The 2 figures below are saved in the folder [currentFolder\SGG Pre-Processing\GOCE Altitude]
%   Altitude_GOCE_GRF_date.jpeg
%   Altitude_GOCE_GRF_date.fig
%   k = counter/ is needed for checks in the GUI
%   ------------------------------------------------------------------------------------------------

%% data classification
h = GG_coords_GRF{3,1};
time_utc_nom_fractional_new = GG_coords_GRF{11,1};
name_current_day = GG_coords_GRF{12,1}; % needed for plots

% create a folder to save all the figures (.jpeg/ .fig) "Vij_GRF_date"
p = 1;
foldername = sprintf('GOCE Altitude%02',p);
currentFolder1=[currentFolder, '\SGG Pre-Processing'];
mkdir(currentFolder1, foldername);
currentFolder2=[currentFolder, '\SGG Pre-Processing\GOCE Altitude'];

NumTicks=5; % needed for labels in figures

for i=1:length(h)
    f = figure('visible','off');
    plot(time_utc_nom_fractional_new{i},h{i}./1000, 'color',[0.6350 0.0780 0.1840],'LineWidth',2);
    xlabel('UTC Time','fontsize',14) %'format', 'HH:mm:ss')
    ylabel('Altitude (km)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title(['Altitude, ',num2str(DateString)],'fontsize',16,'FontWeight','bold')
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    % save .jpeg
    set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
    filename_save = sprintf('Altitude_GOCE_GRF_%s.jpeg',num2str(DateString));
    txtname = fullfile(currentFolder2,filename_save);
    print(f, txtname,'-djpeg','-r300')
    
    % save .fig
    set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');  % needed it/ reopen the fig
    filename_save = sprintf('Altitude_GOCE_GRF_%s.fig',num2str(DateString));
    txtname = fullfile(currentFolder2,filename_save);
    savefig(txtname);
    if i==1
        fprintf(2, '\nGeoGravGOCE Info:\n')
    end
    disp('A figure was saved in "GOCE Altitude" folder')
end

% message for the user/ all ok/ check the folder "GOCE Altitude"
Opt.Interpreter = 'tex';
Opt.WindowStyle = 'normal';
msgbox({'Your figures (.jpeg & .fig) were saved in the new folder';' "GOCE Altitude" .';'';' Check them!'}, 'Info', 'help', Opt);
k=1; % counter /all ok
end