function [GG_GRF_data,l] = load_GGs_GRF()
%   GeoGravGOCE project
%   E. Pitenis
%   GravLab, AUTh, 28/9/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function for computing gravity gradients in GRF
%   ----------------------------------------------------------------------------------------
%% Beginning of loading
l=0;
GG_GRF_data={};

[baseFileNames_GGs_GRF,path] = uigetfile( ...
    {'*.mat','GGs in GRF files (*.mat)';
    '*.*',  'All Files (*.*)'}, ...
    'Select GGs in GRF File ',...
    'MultiSelect', 'off');

if isequal(baseFileNames_GGs_GRF, 0) % check if the user click the cancel button
    l=0; % cancel button checked
    disp('The cancel button was selected. You have not loaded a .mat file.')
else
    addpath(path);
    command = sprintf('load(''%s'')', baseFileNames_GGs_GRF); % load the file
    evalin('base', command);
    T=evalin('base', command);
    
    % gets field names of structure
    user_name_GG_GRF=fieldnames(T);
    z1=length(user_name_GG_GRF);
    
    if isequal(z1,1)
        
        if iscell(user_name_GG_GRF)
            user_name_GG_GRF=cell2mat(user_name_GG_GRF);
        end
        
        
        % length check
        command = sprintf('length(%s)', user_name_GG_GRF);
        length_GG_GRF=evalin('base', command);
        
        if (length_GG_GRF==19)
            l=1; % all ok
            % required classification
            GG_GRF_data={};
            % lat
            command = sprintf('%s{1}', user_name_GG_GRF);
            [GG_GRF_data{1,1}]=evalin('base', command);
            
            % lon
            command = sprintf('%s{2}', user_name_GG_GRF);
            [GG_GRF_data{2,1}]=evalin('base', command);
            
            % h
            command = sprintf('%s{3}', user_name_GG_GRF);
            [GG_GRF_data{3,1}]=evalin('base', command);
            
            % UTC time
            command = sprintf('%s{4}', user_name_GG_GRF);
            [GG_GRF_data{4,1}]=evalin('base', command);
            
            % name of current day
            command = sprintf('%s{5}', user_name_GG_GRF);
            [GG_GRF_data{5,1}]=evalin('base', command);
            
            % Vxx
            command = sprintf('%s{6}', user_name_GG_GRF);
            [GG_GRF_data{6,1}]=evalin('base', command);
            
            % Vyy
            command = sprintf('%s{7}', user_name_GG_GRF);
            [GG_GRF_data{7,1}]=evalin('base', command);
            
            % Vzz
            command = sprintf('%s{8}', user_name_GG_GRF);
            [GG_GRF_data{8,1}]=evalin('base', command);
            
            % Vxy
            command = sprintf('%s{9}', user_name_GG_GRF);
            [GG_GRF_data{9,1}]=evalin('base', command);
            
            % Vxz
            command = sprintf('%s{10}', user_name_GG_GRF);
            [GG_GRF_data{10,1}]=evalin('base', command);
            
            % Vyz
            command = sprintf('%s{11}', user_name_GG_GRF);
            [GG_GRF_data{11,1}]=evalin('base', command);
            
            % q1(IRF to GRF)
            command = sprintf('%s{12}', user_name_GG_GRF);
            [GG_GRF_data{12,1}]=evalin('base', command);
            
            % q2 (IRF to GRF)
            command = sprintf('%s{13}', user_name_GG_GRF);
            [GG_GRF_data{13,1}]=evalin('base', command);
            
            % q3 (IRF to GRF)
            command = sprintf('%s{14}', user_name_GG_GRF);
            [GG_GRF_data{14,1}]=evalin('base', command);
            
            % q4(IRF to GRF)
            command = sprintf('%s{15}', user_name_GG_GRF);
            [GG_GRF_data{15,1}]=evalin('base', command);
            
            % q1 (EFRF to IRF)
            command = sprintf('%s{16}', user_name_GG_GRF);
            [GG_GRF_data{16,1}]=evalin('base', command);
            
            % q2 (EFRF to IRF)
            command = sprintf('%s{17}', user_name_GG_GRF);
            [GG_GRF_data{17,1}]=evalin('base', command);
            
            % q3 (EFRF to IRF)
            command = sprintf('%s{18}', user_name_GG_GRF);
            [GG_GRF_data{18,1}]=evalin('base', command);
            
            % q4 (EFRF to IRF)
            command = sprintf('%s{19}', user_name_GG_GRF);
            [GG_GRF_data{19,1}]=evalin('base', command);
            
        else
            % message for user/ error
            Opt.Interpreter = 'tex';
            Opt.WindowStyle = 'normal';
            msgbox({'You have loaded a wrong file..'}, 'Error', 'error', Opt);
            l=0; % counter/ not ok
        end
    else
        % message for user/ error
        Opt.Interpreter = 'tex';
        Opt.WindowStyle = 'normal';
        msgbox({'You have loaded a wrong file..'}, 'Error', 'error', Opt);
        l=0; % counter/ not ok
    end
    
end
end