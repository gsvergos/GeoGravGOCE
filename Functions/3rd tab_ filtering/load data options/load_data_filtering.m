function [data_for_filtering,k] = load_data_filtering()
%    GeoGravGOCE project
%    E. Mamagiannou
%    GravLab, AUTh, 1/9/2020

%    ---------------------------------------------------------------------------------------------
%    INFO
%    the function reads the user's data
%    ---------------------------------------------------------------------------------------------

%% load the data for filtering
% (1)--- input format
clc
fprintf(2, '\nINFO: Required Input Format for filtering:\n')
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
X = ['7th cell = longtitude (needed for figures)'];
disp(X)
X = ['8th cell = latitude (needed  for figures)'];
disp(X)
X = ['9th cell = altitude (needed  for figures)'];
disp(X)
X = ['10th cell = GPS time (needed  for figures)'];
disp(X)
X = ['11th cell = the names of the processed files (needed for figures)'];
disp(X)
X = [' '];
disp(X)
X = ['(The needed information exists in the SGG_GRF.mat)'];
disp(X)

% (2)--- load user's data (reduced or not)
[baseFileNames,path] = uigetfile( ...
    {'*.mat','mat files (*.mat)';
    '*.*',  'All Files (*.*)'}, ...
    'Load the data (.mat)',...
    'MultiSelect', 'off');

if isequal(baseFileNames, 0) % check if the user click the cancel button
    k=0; % counter /cancel button checked
    disp('The cancel button was selected.')
    data_for_filtering={}; %just to avoid output errors
else
    k=1; % counter/ all ok
    addpath(path);
    command = sprintf('load(''%s'')', baseFileNames);
    evalin('base', command);
    T=evalin('base', command);
    
    % gets field names of structure
    user_name=fieldnames(T);
    if iscell(user_name)
        user_name=cell2mat(user_name);
    end
    
    % (3)--- Checking the input
    % length check
    command = sprintf('length(%s)', user_name);
    length_user=evalin('base', command);
    %cell check
    command = sprintf('iscell(%s)==1', user_name);
    cell_true=evalin('base', command);
    
    if ((length_user==11) && (cell_true==1))
        % (3)required classification
        data_for_filtering={};
        % Vxx
        command = sprintf('%s{1}', user_name);
        [data_for_filtering{1,1}]=evalin('base', command);
        
        % Vyy
        command = sprintf('%s{2}', user_name);
        [data_for_filtering{2,1}]=evalin('base', command);
        
        % Vzz
        command = sprintf('%s{3}', user_name);
        [data_for_filtering{3,1}]=evalin('base', command);
        
        % Vxy
        command = sprintf('%s{4}', user_name);
        [data_for_filtering{4,1}]=evalin('base', command);
        
        % Vxz
        command = sprintf('%s{5}', user_name);
        [data_for_filtering{5,1}]=evalin('base', command);
        
        % Vyz
        command = sprintf('%s{6}', user_name);
        [data_for_filtering{6,1}]=evalin('base', command);
        
        % longtitute
        command = sprintf('%s{7}', user_name);
        [data_for_filtering{7,1}]=evalin('base', command);
        
        % latitude
        command = sprintf('%s{8}', user_name);
        [data_for_filtering{8,1}]=evalin('base', command);
        
        % altitude
        command = sprintf('%s{9}', user_name);
        [data_for_filtering{9,1}]=evalin('base', command);
        
        % time
        command = sprintf('%s{10}', user_name);
        [data_for_filtering_1{10,1}]=evalin('base', command);
        % convert gps time to UTC
        for i=1:length(data_for_filtering_1{10,1})
            time{i,1}= datetime(gps2utc(data_for_filtering_1{10,1}{i}/86400+723186),'ConvertFrom','datenum','Format', 'yyyy-MM-dd HH:mm:ss'); %(/86400+723186)= the reference of the start of GPS time % keeps fraction sec inside
        end
        % save it
        data_for_filtering{10,1}=time;
        
        % names of files
        command = sprintf('%s{11}', user_name);
        [data_for_filtering{11,1}]=evalin('base', command);
        
        clc
        fprintf(2, '\nINFO GeoGravGOCE:\n')
        X = ['You have successfully loaded your reduced data.'];
        disp(X)
    else
        k=0; %counter/ not ok
        data_for_filtering={}; %just to avoid output errors
        
        % message for user/ error
        Opt.Interpreter = 'tex';
        Opt.WindowStyle = 'normal';
        msgbox({'Please check the required input format and reload your data.'}, 'Error', 'error', Opt);
        
        % input format
        clc
        fprintf(2, '\nINFO: Required Input Format for filtering:\n')
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
        X = ['7th cell = longtitude (needed for figures)'];
        disp(X)
        X = ['8th cell = latitude (needed  for figures)'];
        disp(X)
        X = ['9th cell = altitude (needed  for figures)'];
        disp(X)
        X = ['10th cell = GPS time (needed  for figures)'];
        disp(X)
        X = ['11th cell = the names of the processed files (needs for figures)'];
        disp(X)
        X = [' '];
        disp(X)
        X = ['(The needed information exists in the SGG_GRF.mat)'];
        disp(X)
    end
end
end

