function [GG_coords_GRF,stop_process] = multi_process_up_3(NOM_data_0,PSO_data_0,counter_NOM_0,counter_PSO_0,path_NOM,path_PSO)
%    GeoGravGOCE project
%    E. Mamagiannou
%    GravLab, AUTh, 26/8/2020

%    ---------------------------------------------------------------------------------------------
%    ---------- Multi Processing ( >3 files ) ----------

%    *** Input ***
%    NOM_data_0 = the EGG_NOM_2 data
%    counter_NOM_0= 0 or 1/ is needed for further actions in the GUI
%    PSO_data_0 = the PSO_2 files data
%    counter_PSO_0= 0 or 1/ is needed for further actions in the GUI

%    *** Output ***
%    "GG_coords_GRF.mat" = {18x1} cells
%    GG_coords_GRF{1}= longtitude
%    GG_coords_GRF{2}= latitude
%    GG_coords_GRF{3}= h (GOCE altitude)
%    GG_coords_GRF{4}= Vxx
%    GG_coords_GRF{5}= Vyy
%    GG_coords_GRF{6}= Vzz
%    GG_coords_GRF{7}= Vxy
%    GG_coords_GRF{8}= Vxz
%    GG_coords_GRF{9}= Vzy
%    GG_coords_GRF{10}= percentage_lost_data_nom --(empty)
%    GG_coords_GRF{11}= time_utc_nom_fractional_new
%    GG_coords_GRF{12}= name_current_NOM_day
%    GG_coords_GRF{13}=q1
%    GG_coords_GRF{14}=q2   -//-
%    GG_coords_GRF{15}=q3   -//-
%    GG_coords_GRF{16}=q4   -//-
%    GG_coords_GRF{17}= Time GPS - NOM data
%
%    stop_process = counter/ is needed for further actions in the GUI
%    ---------------------------------------------------------------------------------------------

%% create a folder to save all the outputs
p = 1 ;
foldername = sprintf('SGG Pre-Processing%02',p);
mkdir(foldername);
currentFolder = pwd; % Identify current folder
% add path
currentFolder=[currentFolder, '\SGG Pre-Processing'];


%% (1) Check NOM and corresponding PSO files
[result] = checking_NOM_PSO(NOM_data_0,PSO_data_0); % check the user's data before parallel computing

if (result==0)
    % (2) Check if a pool already exists
    poolobj = gcp('nocreate');
    if isempty(poolobj)
        poolobj = parpool('local'); % Create a local pool with processes
        poolcreationresult = 'A new pool was created.';
    else
        poolcreationresult = 'Using existing pool.';
    end
    fprintf("%s\n",strcat(poolcreationresult,' NumOfWorkers is:',string(poolobj.NumWorkers)))
    
    % (3) starts Parallel Computing
    % initialize variables for speed
    result_GG=cell(length(NOM_data_0),1);
    
    parfor i=1:length(NOM_data_0)
        % multi processing/ more than 3 files
        [GG_coords_GRF1] = browse_data_2(NOM_data_0{i},counter_NOM_0,PSO_data_0{i},counter_PSO_0,path_NOM,path_PSO); % processing for more than 1 files/ parallel computing
        result_GG{i,1}=GG_coords_GRF1; %save the GG_coords output
    end
    stop_process=0; % counter/ all ok
    
    
    %% ---------- (2) save the results ----------
    
    for i=1:length(result_GG)
        % (a) save FOR ME
        GG_coords_GRF{1,1}{i,1}=result_GG{i,1}{1}; %longtitude
        GG_coords_GRF{2,1}{i,1}=result_GG{i,1}{2}; %latitude
        GG_coords_GRF{3,1}{i,1}=result_GG{i,1}{3}; %h (GOCE altitude)
        GG_coords_GRF{4,1}{i,1}=result_GG{i,1}{4}; %Vxx
        GG_coords_GRF{5,1}{i,1}=result_GG{i,1}{5}; %Vyy
        GG_coords_GRF{6,1}{i,1}=result_GG{i,1}{6}; %Vzz
        GG_coords_GRF{7,1}{i,1}=result_GG{i,1}{7}; %Vxy
        GG_coords_GRF{8,1}{i,1}=result_GG{i,1}{8}; %Vxz
        GG_coords_GRF{9,1}{i,1}=result_GG{i,1}{9}; %Vyz
        GG_coords_GRF{10,1}{i,1}=[]; %percentage_lost_data_nom------(empty)
        GG_coords_GRF{11,1}{i,1}=result_GG{i,1}{11}{1}; % time_utc_nom_fractional_new
        GG_coords_GRF{12,1}{i,1}=result_GG{i,1}{12}{1}; % name_current_NOM_day
        GG_coords_GRF{13,1}{i,1}=result_GG{i,1}{13}; %q1
        GG_coords_GRF{14,1}{i,1}=result_GG{i,1}{14}; %q2
        GG_coords_GRF{15,1}{i,1}=result_GG{i,1}{15}; %q3
        GG_coords_GRF{16,1}{i,1}=result_GG{i,1}{16}; %q4
        GG_coords_GRF{17,1}{i,1}=result_GG{i,1}{17}; %= Time GPS - NOM data
    end
    
    % (b1) save FOR the user
    SGG_GRF{1,1}=GG_coords_GRF{2}; % lat
    SGG_GRF{2,1}=GG_coords_GRF{1}; % lon
    SGG_GRF{3,1}=GG_coords_GRF{3}; % h
    SGG_GRF{4,1}=GG_coords_GRF{17}; % UTC time (NOM data)
    SGG_GRF{5,1}=GG_coords_GRF{4}; % Vxx
    SGG_GRF{6,1}=GG_coords_GRF{5}; % Vyy
    SGG_GRF{7,1}=GG_coords_GRF{6}; % Vzz
    SGG_GRF{8,1}=GG_coords_GRF{7}; % Vxy
    SGG_GRF{9,1}=GG_coords_GRF{8}; % Vxz
    SGG_GRF{10,1}=GG_coords_GRF{9}; % Vyz
    SGG_GRF{11,1}=GG_coords_GRF{13}; % q1
    SGG_GRF{12,1}=GG_coords_GRF{14}; % q2
    SGG_GRF{13,1}=GG_coords_GRF{15}; % q3
    SGG_GRF{14,1}=GG_coords_GRF{16}; % q4
    SGG_GRF{15,1}=GG_coords_GRF{12}; % The name of the current NOM
    
    % (b2) save the output in the SGG Pre-processing (our) folder
    currentFolder1=[currentFolder, '\SGG_GRF.mat'];
    save(currentFolder1,'SGG_GRF');
    
    % (b3) SGG_GRF Report
    SGG_GRF_report=' ';
    SGG_GRF_report =[SGG_GRF_report, newline 'The format of the output "SGG_GRF.mat": '];
    SGG_GRF_report =[SGG_GRF_report, newline '{15x1} cells:'];
    SGG_GRF_report =[SGG_GRF_report, newline 'SGG_GRF{1} = latitude (degrees) (GRS80)'];
    SGG_GRF_report =[SGG_GRF_report, newline 'SGG_GRF{2} = longtitude (degrees) (GRS80)'];
    SGG_GRF_report =[SGG_GRF_report, newline 'SGG_GRF{3} = h (meter)(GOCE altitude)'];
    SGG_GRF_report =[SGG_GRF_report, newline 'SGG_GRF{4} = UTC time from EGG_NOM_2 data'];
    SGG_GRF_report =[SGG_GRF_report, newline 'SGG_GRF{5} = Vxx in GRF (Eötvös)'];
    SGG_GRF_report =[SGG_GRF_report, newline 'SGG_GRF{6} = Vyy in GRF (Eötvös)'];
    SGG_GRF_report =[SGG_GRF_report, newline 'SGG_GRF{7} = Vzz in GRF (Eötvös)'];
    SGG_GRF_report =[SGG_GRF_report, newline 'SGG_GRF{8} = Vxy in GRF (Eötvös)'];
    SGG_GRF_report =[SGG_GRF_report, newline 'SGG_GRF{9} = Vxz in GRF (Eötvös)'];
    SGG_GRF_report =[SGG_GRF_report, newline 'SGG_GRF{10} = Vzy in GRF (Eötvös)'];
    SGG_GRF_report =[SGG_GRF_report, newline 'SGG_GRF{11} = q1, quaternion GRF'];
    SGG_GRF_report =[SGG_GRF_report, newline 'SGG_GRF{12} = q2, quaternion GRF'];
    SGG_GRF_report =[SGG_GRF_report, newline 'SGG_GRF{13} = q3, quaternion GRF'];
    SGG_GRF_report =[SGG_GRF_report, newline 'SGG_GRF{14} = q4, quaternion GRF'];
    SGG_GRF_report =[SGG_GRF_report, newline 'SGG_GRF{15} = The NOM file names that were processed'];
    
    % (b4) save the output in the SGG Pre-processing (our) folder
    currentFolder2=[currentFolder, '\SGG_GRF_Report.txt'];
    dlmwrite (currentFolder2,SGG_GRF_report,'delimiter','');
else
    stop_process=1; %counter /terminate
    GG_coords_GRF={};
end
end

