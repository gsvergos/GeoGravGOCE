function [ k ] = GOCE_orbit_track( GG_coords_GRF,currentFolder)
%    GeoGravGOCE project
%    E. Mamagiannou, D. Natsiopoulos
%    GravLab, AUTh, 15/3/2020

%    ---------------------------------------------------------------------------------------------
%    INFO
%    function for plotting the  GOCE Orbit track.
%    the function plots the maps via the "m_map" mapping toolbox.
%    citation:
%    Pawlowicz, R., 2020. "M_Map: A mapping package for MATLAB", version 1.4m,
%    [Computer software], available online at www.eoas.ubc.ca/~rich/map.html.

%    *** Input ***:
%    GG_coords_GRF = the output of GUI's 1st tab
%    currentFolder =  the current working folder (you can identify it with "pwd")

%    *** output ***:
%    GOCE Orbit Track_date.jpeg
%    GOCE Orbit Track_date.fig
%    k = counter/ is needed for checks in the GUI
%    ------------------------------------------------------------------------------------------------

%% Info/ m_map
clc
fprintf(2, '\nM_MAP:\n','FontSize', 20)
disp('The maps are created via the "M_Map" mapping toolbox')
disp('Pawlowicz, R., 2020. "M_Map: A mapping package for MATLAB", version 1.4m')
disp('[Computer software], available online at www.eoas.ubc.ca/~rich/map.html')
X = '<a href = "www.eoas.ubc.ca/~rich/map.html">M-Map Web Site</a>';
disp(X)

% message for user
%Opt.Interpreter = 'tex';
%Opt.WindowStyle = 'normal';
%msgbox({'The maps are created via the "M - Map" mapping toolbox';...
%    'Pawlowicz, R., 2020. "M - Map: A mapping package for MATLAB", version 1.4m';...
%    ' ';...
%    '[Computer software], available online at www.eoas.ubc.ca/~rich/map.html'}, 'M - MAP  Info', 'help', Opt);


%% ----- check 1 -----
% check if th "m_map" folder is on the Matlab's search path
path_list_cell = regexp(path,pathsep,'Split');
path_to_be_searched=('m_map');

if any(ismember(path_to_be_searched,path_list_cell))
    %disp('The directory (m map) is in MATLAB''s path.');
    k=0; % all ok
else
    %disp('The directory (m map) is not in MATLAB''s path.');
    k=1; % not ok/ cancel
end

find_m_map_function = which('m_hatch.m','-all'); %Display the paths to all items on the MATLAB path with the name GrafLab.
if isempty(find_m_map_function)==0 %if the .m files exists
    Str = extractBefore(find_m_map_function{1},'\m_hatch.m');
    addpath(Str); % add m_map path
    newStr=[Str,'\private'];
    addpath(genpath(newStr)); % add the private m_map path
    q=0; %counter/ all ok
end

% ----- check 2 -----
if ((exist('m_map', 'file')==7) || k==0|| q==0) % 7 — name is a folder.
    % message for the user
    disp(' ')
    disp(' ')
    disp('Please wait, Creating maps (this might take several minutes.)')
    % please wait message
    f = waitbar(0,'Please wait...');
    pause(2)
    waitbar(.50,f,'Creating maps (this might take several minutes)');
    pause(2)
    waitbar(1,f,'Please wait...');
    pause(2)
    close(f)
    
    %% load data
    % classification
    lon = GG_coords_GRF{1,1};
    lat = GG_coords_GRF{2,1};
    name_current_day = GG_coords_GRF{12,1}; %needed for plots
    
    % make a folder to save all the figures (.jpeg)
    p = 1 ;
    foldername = sprintf('GOCE Orbit Track%02',p);
    currentFolder1=[currentFolder, '\SGG Pre-Processing'];
    mkdir(currentFolder1, foldername);
    currentFolder2=[currentFolder, '\SGG Pre-Processing\GOCE Orbit Track'];
    currentFolder0 = pwd; % Identify current folder
    % add  the "m_map" folder
    currentFolder0=[currentFolder0, '\m_map'];
    addpath(currentFolder0);
    
    
    
    % check multi or single process
    if (length(lon)==1) % creating 1 map
        % --- (A) Single process ---
        i=1;
        warning off
        f = figure('visible','off');
        m_proj('miller','lat',max(lat{i}));
        m_gshhs_l('patch',[0.6 0.6 0.6]);
        hold on
        m_line(lon{i},lat{i},'marker','o','markersize',2,'markerfacecolor','b','color','b','LineStyle','none');
        m_grid('box','on','tickdir','in');
        xlabel('Longitude','fontsize',14)
        ylabel('Latitude','fontsize',14)
        if length(name_current_day)>=3 %
            a=name_current_day{i,1}{1};
            DateString = datestr( a(1) );
        else
            a=name_current_day{i,1}(i);
            DateString = datestr( a );
        end
        title(['GOCE Orbit Track, ',num2str(DateString)],'fontsize',16,'FontWeight','bold')
        hold off
        
        % save .jpeg
        set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
        filename_save = sprintf('GOCE Orbit Track_%s.jpeg',num2str(DateString));
        txtname = fullfile(currentFolder2,filename_save);
        print(f, txtname,'-djpeg','-r100')
        
        % save fig
        set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');
        filename_save = sprintf('GOCE Orbit Track_%s.fig',num2str(DateString));
        txtname = fullfile(currentFolder2,filename_save);
        savefig(txtname);
        
        % message for the user
        fprintf(2, '\nGeoGravGOCE Info:\n')
        disp('a figure was saved in "GOCE Orbit Track" folder')
    else
        % --- (B) Multi process ---
        
        % Check if a pool already exists
        poolobj = gcp('nocreate');
        if isempty(poolobj)
            poolobj = parpool('local'); % Create a local pool with processes
            poolcreationresult = 'A new pool was created.';
        else
            poolcreationresult = 'Using existing pool.';
        end
        fprintf("%s\n",strcat(poolcreationresult,' NumOfWorkers is:',string(poolobj.NumWorkers)))
        
        % creating multiple plots with m_map
        parfor i=1:length(lon)
            warning off
            f = figure('visible','off');
            m_proj('miller','lat',max(lat{i}));
            m_gshhs_l('patch',[0.6 0.6 0.6]);
            hold on
            m_line(lon{i},lat{i},'marker','o','markersize',2,'markerfacecolor','b','color','b','LineStyle','none');
            m_grid('box','on','tickdir','in');
            xlabel('Longitude','fontsize',14)
            ylabel('Latitude','fontsize',14)
            a=name_current_day{i};
            DateString = datestr( a(1) );
            title(['GOCE Orbit Track, ',num2str(DateString)],'fontsize',16,'FontWeight','bold')
            hold off
            
            % save .jpeg
            set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
            filename_save = sprintf('GOCE Orbit Track_%s.jpeg',num2str(DateString));
            txtname = fullfile(currentFolder2,filename_save);
            print(f, txtname,'-djpeg','-r100')
            
            % save .fig
            set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');
            filename_save = sprintf('GOCE Orbit Track_%s.fig',num2str(DateString));
            txtname = fullfile(currentFolder2,filename_save);
            savefig(txtname);
            
            % message for the user
            if i==1
                clc
                fprintf(2, '\nGeoGravGOCE Info:\n')
            end
            disp('a figure was saved in "GOCE Orbit Track" folder')
        end
    end
    
    % message for the user/ all ok/ check the folder "GOCE Orbit track"
    Opt.Interpreter = 'tex';
    Opt.WindowStyle = 'normal';
    msgbox({'Your figures (.jpeg & .fig) were saved in the new folder ';' "GOCE Orbit Track" .';'';' Check them!'}, 'Info', 'help', Opt);
    k=0; % counter/ all ok
else
    k=1; % counter/ terminate
    % message for user
    Opt.Interpreter = 'tex';
    Opt.WindowStyle = 'normal';
    msgbox({'M-MAP folder does not exist in your computer,' ;...
        ' ';...
        'Please check the Command Window for a Suggested Solution.'}, 'M-MAP Info', 'help', Opt);
    
    clc
    fprintf(2, '\nM_MAP:\n')
    disp('M_MAP folder does not exist in your computer.')
    fprintf(2, '\nSuggested Solution:\n')
    disp('M_MAP is a mapping package for Matlab ')
    disp(' ')
    disp('Pawlowicz, R., 2020. "M_Map: A mapping package for MATLAB", version 1.4m, [Computer software], available online at www.eoas.ubc.ca/~rich/map.html')
    disp(' ')
    disp('You can download the M_Map toolbox from here:')
    X = '<a href = "www.eoas.ubc.ca/~rich/map.html">M-Map Web Site</a>';
    disp(X)
    disp(' ')
    disp('and then you can re-run the "GOCE Orbit Track"  button in the GeoGravGOCE app!')
end

