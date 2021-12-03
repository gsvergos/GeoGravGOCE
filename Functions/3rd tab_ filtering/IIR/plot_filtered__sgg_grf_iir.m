function [f] = plot_filtered__sgg_grf_iir(Vij_IIR,z,N2,currentFolder)
%    GeoGravGOCE project
%    E. Mamagiannou
%    GravLab, AUTh, 9/9/2020

%    ---------------------------------------------------------------------------------------------
%    INFO
%    *** function for plotting the Vij after IIR filtering ***

%    *** input ***
%    [input = the "IIR" function's output]
%    Vij_FIR = {6x1} cells = the filtered data
%    the format of Vij_FIR.mat:
%    1st cell = Vxx filtered
%    2nd cell = Vyy filtered
%    3rd cell = Vzz filtered
%    4th cell = Vxy filtered
%    5th cell = Vxy filtered
%    6th cell = Vyz filtered
%
%    z = {6x1} cells =  data before the filtering
%    the format of z.mat:
%    1st cell = Vxx unfiltered
%    2nd cell = Vyy unfiltered
%    3rd cell = Vzz unfiltered
%    4th cell = Vxy unfiltered
%    5th cell = Vxy unfiltered
%    6th cell = Vyz unfiltered
%
%    N2 = N-coefficients = the order of IIR filter / is needed in the GUI for further actions
%    currentFolder =  the current working folder (you can identify it with "pwd")

%    *** output ***:
%    f = figure (invisible)
%    Filtered_IIR_Vij_GRF_date.fig (automatically saved)
%    Filtered_IIR_Vij_GRF_date.jpeg (automatically saved)
%    ------------------------------------------------------------------------------------------------

%% classification of data
% Gravity Gradients after IIR filtering
Vxx = Vij_IIR{5};
Vyy = Vij_IIR{6};
Vzz = Vij_IIR{7};
Vxy = Vij_IIR{8};
Vxz = Vij_IIR{9};
Vyz = Vij_IIR{10};
% plot info
time =z{10,1}; % time NOM UTC
name_current_day = z{11,1}; %name of processed file

% make a folder to save all the figures (.jpeg) "IIR Filtered Vij GRF"
p = 1;
foldername = sprintf('IIR Filtered Vij GRF%02',p);
currentFolder1=[currentFolder, '\IIR'];
mkdir(currentFolder1, foldername);
currentFolder2=[currentFolder, '\IIR\IIR Filtered Vij GRF'];

% Plots
NumTicks = 3; % It keeps three labels of time on the X-axis of figures.

for i=1:length(Vxx)
    f = figure('visible','off');
    % Vxx
    subplot(2,3,1)
    plot(time{i},Vxx{i}, 'color',[0.10 0.60 0.90]);
    xlabel('UTC Time','fontsize',14) %'format', 'HH:mm:ss')
    ylabel('Filtered Vxx (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title({['\bf\fontsize{16} Filtered Vxx - GRF (IIR, N=', num2str(N2),')'] ;num2str(DateString)});
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    % Vyy
    subplot(2,3,2)
    plot(time{i},Vyy{i}, 'color', [0.10 0.60 0.90]);
    xlabel('UTC Time','fontsize',14)
    ylabel('Filtered Vyy (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title({['\bf\fontsize{16} Filtered Vyy - GRF (IIR, N=', num2str(N2),')'] ;num2str(DateString)});
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    % Vzz
    subplot(2,3,3)
    plot(time{i},Vzz{i}, 'color', [0.10 0.60 0.90]);
    xlabel('UTC Time','fontsize',14)
    ylabel('Filtered Vzz (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title({['\bf\fontsize{16} Filtered Vzz - GRF (IIR, N=', num2str(N2),')'] ;num2str(DateString)});
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    % Vxy
    subplot(2,3,4)
    plot(time{i},Vxy{i}, 'color', [0.10 0.60 0.90]);
    xlabel('UTC Time','fontsize',14)
    ylabel('Filtered Vxy (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title({['\bf\fontsize{16} Filtered Vxy - GRF (IIR, N=', num2str(N2),')'] ;num2str(DateString)});
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    % Vxz
    subplot(2,3,5)
    plot(time{i},Vxz{i}, 'color', [0.10 0.60 0.90]);
    xlabel('UTC Time','fontsize',14)
    ylabel('Filtered Vxz (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title({['\bf\fontsize{16} Filtered Vxz - GRF (IIR, N=', num2str(N2),')'] ;num2str(DateString)}) ;
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    % Vyz
    subplot(2,3,6)
    plot(time{i},Vyz{i}, 'color', [0.10 0.60 0.90]);
    xlabel('UTC Time','fontsize',14)
    ylabel('Filtered Vyz (Eötvös)','fontsize',14)
    %title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    title({['\bf\fontsize{16} Filtered Vyz - GRF (IIR, N=', num2str(N2),')'] ;num2str(DateString)});
    L = get(gca,'XLim');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    datetick('x','dd-mmm HH:MM','keeplimits', 'keepticks'); % Set parameters
    
    % save .jpeg
    set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
    filename_save = sprintf('Filtered_FIR_Vij_GRF_%s.jpeg',num2str(DateString));
    txtname = fullfile(currentFolder2,filename_save);
    print(f, txtname,'-djpeg','-r300')
    
    % save .fig
    set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');
    filename_save = sprintf('Filtered_FIR_Vij_GRF_%s.fig',num2str(DateString));
    txtname = fullfile(currentFolder2,filename_save);
    savefig(txtname);
    if i==1
        fprintf(2, '\nGeoGravGOCE Info:\n')
    end
    disp('A figure was saved in "IIR Filtered Vij GRF" folder')
end

% message for the user/ all ok/ check the folder "FIR Filtered Vij GRF GRF"
Opt.Interpreter = 'tex';
Opt.WindowStyle = 'normal';
msgbox({'Your figures (.jpeg & .fig) were saved in the new ';' "IIR Filtered Vij GRF" folder .';'';' Check them!'}, 'Info', 'help', Opt);
end

