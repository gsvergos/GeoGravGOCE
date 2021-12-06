function [data_for_filtering,k,q] = load_3rd_option_for_filtering()
%    GeoGravGOCE project
%    E. Mamagiannou
%    GravLab, AUTh, 14/9/2020

%    ---------------------------------------------------------------------------------------------
%    INFO
%    the function reads the user's data

%    *** output ***
%    data_for_filtering = {17x1} cell,
%    contains the reduced data ready for filtering
%    k, q = counters/ needed for further checks and actions in the GUI
%    ---------------------------------------------------------------------------------------------

%% load the data for filtering
% (1)--- info for the input format
clc
fprintf(2, '\nINFO: Required Input Format for filtering:\n')
X = ['Format of GGM gravitational tensor componets:'];
disp(X)
X = [' '];
disp(X)
X = ['your_data.mat = cell {6x1}'];
disp(X)
X = ['1st cell = Vxx'];
disp(X)
X = ['2nd cell = Vyy'];
disp(X)
X = ['3th cell = Vzz'];
disp(X)
X = ['4th cell = Vxy'];
disp(X)
X = ['5th cell = Vxz'];
disp(X)
X = ['6th cell = Vyz'];
disp(X)


%% --- (1) SGG_GRF (1st tab's output of GUI)---
k=0;  % k = controller for SGG_GRF data, to avoid the crush
q=0;  % q = controller for "GGM_graflab" data, to avoid the crush
data_for_filtering={};

% load data
[baseFileNames_SGG,path] = uigetfile( ... %[baseFileNames,path]
    {'*SGG_GRF.mat','mat files (*.mat)';
    '*.*',  'All Files (*.*)'}, ...
    'Load the  "SGG_GRF.mat"  data',...
    'MultiSelect', 'off');

if isequal(baseFileNames_SGG, 0) % check if the user click the cancel button
    k=0; % cancel button checked
    disp('The cancel button was selected. You have not loaded the SGG_GRF.mat file.')
else
    addpath(path);
    %ww= load(path+"\"+baseFileNames); % load data
    command = sprintf('load(''%s'')', baseFileNames_SGG); % load the file
    evalin('base', command);
    T=evalin('base', command);
    
    % gets field names of structure
    user_name_SGG=fieldnames(T);
    if iscell(user_name_SGG)
        user_name_SGG=cell2mat(user_name_SGG);
    end
    
    % length check
    command = sprintf('length(%s)', user_name_SGG);
    length_SGG=evalin('base', command);
    
    if (length_SGG==15)
        k=1; % all ok
        % required classification for filtering
        data_for_filtering_SGG={};
        % Vxx
        command = sprintf('%s{5}', user_name_SGG);
        [data_for_filtering_SGG{1,1}]=evalin('base', command);
        
        % Vyy
        command = sprintf('%s{6}', user_name_SGG);
        [data_for_filtering_SGG{2,1}]=evalin('base', command);
        
        % Vzz
        command = sprintf('%s{7}', user_name_SGG);
        [data_for_filtering_SGG{3,1}]=evalin('base', command);
        
        % Vxy
        command = sprintf('%s{8}', user_name_SGG);
        [data_for_filtering_SGG{4,1}]=evalin('base', command);
        
        % Vxz
        command = sprintf('%s{9}', user_name_SGG);
        [data_for_filtering_SGG{5,1}]=evalin('base', command);
        
        % Vyz
        command = sprintf('%s{10}', user_name_SGG);
        [data_for_filtering_SGG{6,1}]=evalin('base', command);
        
        % longtitute
        command = sprintf('%s{2}', user_name_SGG);
        [data_for_filtering_SGG{7,1}]=evalin('base', command);
        
        % latitude
        command = sprintf('%s{1}', user_name_SGG);
        [data_for_filtering_SGG{8,1}]=evalin('base', command);
        
        % altitude
        command = sprintf('%s{3}', user_name_SGG);
        [data_for_filtering_SGG{9,1}]=evalin('base', command);
        
        % GPS time/ NOM
        command = sprintf('%s{4}', user_name_SGG);
        [data_for_filtering_SGG{10,1}]=evalin('base', command);
        % convert gps time to UTC
        for i=1:length(data_for_filtering_SGG{10,1})
            time{i,1}= datetime(gps2utc(data_for_filtering_SGG{10}{i}/86400+723186),'ConvertFrom','datenum','Format', 'yyyy-MM-dd HH:mm:ss'); %(/86400+723186)= the reference of the start of GPS time % keeps fraction sec inside
        end
        
        % names of files
        command = sprintf('%s{15}', user_name_SGG);
        [data_for_filtering_SGG{11,1}]=evalin('base', command);
    else
        % message for user/ error
        Opt.Interpreter = 'tex';
        Opt.WindowStyle = 'normal';
        msgbox({'You have loaded the wrong file..'}, 'Error', 'error', Opt);
        k=0; % counter/ not ok
    end
end


%%  --- (2) GGM_gravitational_tensor_components (from grafab) ---

if (k==1)
    % load GGM_LNOF_2_GRF
    [baseFileNames_GGM_tensor,path] = uigetfile( ... %[baseFileNames,path]
        {'*.mat','mat files (*.mat)';
        '*.*',  'All Files (*.*)'}, ...
        'Load the  "GGM gravitational tensor componenets in GRF.mat"  data',...
        'MultiSelect', 'off');
    
    if isequal(baseFileNames_GGM_tensor, 0) % check if the user click the cancel button
        q=0; % cancel
        disp('The cancel button was selected. ')
        return;
    else
        addpath(path);
        command = sprintf('load(''%s'')', baseFileNames_GGM_tensor);
        evalin('base', command);
        T=evalin('base', command);
        
        % gets field names of structure
        user_name_GGM=fieldnames(T);
        if iscell(user_name_GGM)
            user_name_GGM=cell2mat(user_name_GGM);
        end
        
        % length check
        command = sprintf('length(%s)', user_name_GGM);
        length_GGM=evalin('base', command);
        
        if (length_GGM==6)
            q=1; % all ok
            % required classification for filtering
            data_for_filtering_GGM={};
            % GGM Vxx
            command = sprintf('%s{1}', user_name_GGM);
            [data_for_filtering_GGM{1,1}]=evalin('base', command);
            
            % GGM Vyy
            command = sprintf('%s{2}', user_name_GGM);
            [data_for_filtering_GGM{2,1}]=evalin('base', command);
            
            % GGM Vzz
            command = sprintf('%s{3}', user_name_GGM);
            [data_for_filtering_GGM{3,1}]=evalin('base', command);
            
            % GGM Vxy
            command = sprintf('%s{4}', user_name_GGM);
            [data_for_filtering_GGM{4,1}]=evalin('base', command);
            
            % GGM Vxz
            command = sprintf('%s{5}', user_name_GGM);
            [data_for_filtering_GGM{5,1}]=evalin('base', command);
            
            % GGM Vyz
            command = sprintf('%s{6}', user_name_GGM);
            [data_for_filtering_GGM{6,1}]=evalin('base', command);
        else
            % message for user/ error
            Opt.Interpreter = 'tex';
            Opt.WindowStyle = 'normal';
            msgbox({'Please check the required input format and reload your data.'}, 'Error', 'error', Opt);
            
            clc
            fprintf(2, '\nINFO: Required Input Format for filtering:\n')
            X = ['Format of GGM gravitational tensor componets:'];
            disp(X)
            X = [' '];
            disp(X)
            X = ['your_data.mat = cell {6x1}'];
            disp(X)
            X = ['1st cell = Vxx'];
            disp(X)
            X = ['2nd cell = Vyy'];
            disp(X)
            X = ['3th cell = Vzz'];
            disp(X)
            X = ['4th cell = Vxy'];
            disp(X)
            X = ['5th cell = Vxz'];
            disp(X)
            X = ['6th cell = Vyz'];
            disp(X)
            
            q=0; % counter/ terminate
        end
    end
end

%% --- (3) SGG reduction ---
if ((k==1) && (q==1))
    % check lengths
    if length(data_for_filtering_SGG{1})>length(data_for_filtering_GGM{1})
        cc=length(data_for_filtering_GGM{1}); % =length of data
    else
        cc=length(data_for_filtering_SGG{1}); % =length of data
    end
    
    % reduction
    for i=1:cc
        if (q==1)
            %check
            if ((length(data_for_filtering_SGG{1,1}{i}))==(length(data_for_filtering_GGM{1,1}{i}))) % extra check.
                % SGG
                data_for_filtering{1,1}{i,1}=data_for_filtering_SGG{1}{i}-data_for_filtering_GGM{1}{i}; % Vxx
                data_for_filtering{2,1}{i,1}=data_for_filtering_SGG{2}{i}-data_for_filtering_GGM{2}{i}; % Vyy
                data_for_filtering{3,1}{i,1}=data_for_filtering_SGG{3}{i}-data_for_filtering_GGM{3}{i}; % Vzz
                data_for_filtering{4,1}{i,1}=data_for_filtering_SGG{4}{i}-data_for_filtering_GGM{4}{i}; % Vxy
                data_for_filtering{5,1}{i,1}=data_for_filtering_SGG{5}{i}-data_for_filtering_GGM{5}{i}; % Vxz
                data_for_filtering{6,1}{i,1}=data_for_filtering_SGG{6}{i}-data_for_filtering_GGM{6}{i} -(mean(data_for_filtering_SGG{6}{i}-data_for_filtering_GGM{6}{i})); % Vyz
                data_for_filtering{12,1}{i,1}=data_for_filtering_SGG{6}{i}-data_for_filtering_GGM{6}{i}; % Vyz for wavelets
                % needed information
                data_for_filtering{7,1}{i,1}=data_for_filtering_SGG{7}{i}; % lon
                data_for_filtering{8,1}{i,1}=data_for_filtering_SGG{8}{i}; % lat
                data_for_filtering{9,1}{i,1}=data_for_filtering_SGG{9}{i}; % h
                data_for_filtering{10,1}{i,1}=time{i}; % GPS time
                data_for_filtering{11,1}{i,1}=data_for_filtering_SGG{11}{i}; % names of files
            else
                % message for user/ error
                Opt.Interpreter = 'tex';
                Opt.WindowStyle = 'normal';
                msgbox({'The two files do not match in dimensions. Maybe your files correspond in different processed days.'}, 'Error', 'error', Opt);
                q=0; % counter/ terminate/ not ok
                k=0; % counter/ terminate/  not ok
            end
        end
    end
    
    clc
    fprintf(2, '\nINFO GeoGravGOCE:\n')
    X = ['SGG data was successfully loaded and reduced.'];
    disp(X)
end
end


