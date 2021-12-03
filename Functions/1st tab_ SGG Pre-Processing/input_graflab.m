function [ DateString ] = input_graflab( GG_coords_GRF1,currentFolder)
%    GeoGravGOCE project
%    E. Mamagiannou, E. Pitenis
%    GravLab, AUTh, 1/7/2020

%    ---------------------------------------------------------------------------------------------
%    INFO:
%    the function creates the appropriate input format for the "GrafLab" software

%    *** input ***
%    GG_coords_GRF1 = the output of GUI's 1st tab
%    from the output we need the (lat, lon, h)
%    currentFolder = the current working folder (you can identify it with "pwd")

%    *** output ***
%    data-date.txt (automatically saved)
%    ---------------------------------------------------------------------------------------------

%% classification of data
lon = GG_coords_GRF1{1,1};
lat = GG_coords_GRF1{2,1};
h = GG_coords_GRF1{3,1};
name_current_day = GG_coords_GRF1{12,1};

% create a folder to save the output "Input_for_GrafLab"
p = 1;
foldername = sprintf('Input_for_GrafLab%02',p);
currentFolder1=[currentFolder, '\SGG Pre-Processing'];
mkdir(currentFolder1, foldername);
currentFolder2=[currentFolder, '\SGG Pre-Processing\Input_for_GrafLab'];

for j=1:length(lon)
    % the required format
    lon_1=lon{j,1};
    lat_1=lat{j,1};
    h_1=h{j,1};
    A=[lat_1 lon_1 h_1];
    a=name_current_day{j,1}(j);
    DateString = datestr( a );
    filename_save = sprintf('data-%s.txt',num2str(DateString));
    txtname = fullfile(currentFolder2,filename_save);
    dlmwrite(txtname,A,'delimiter',' ','precision','%.9f');
end

% message for the user/ all ok/ check the folder "Input_for_GrafLab"
% for the rusluts.
Opt.Interpreter = 'tex';
Opt.WindowStyle = 'normal';
msgbox({'Your results were saved in the new folder';' "Input for GrafLab".';'';' Check them!'}, 'Info', 'help', Opt);
end


