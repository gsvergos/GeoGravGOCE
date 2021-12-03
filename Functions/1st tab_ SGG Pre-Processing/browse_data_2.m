function [GG_coords_GRF,stop_process] = browse_data_2(NOM_data_0,counter_NOM_0,PSO_data_0,counter_PSO_0,path_NOM,path_PSO)
%   GeoGravGOCE project
%   E. Mamagiannou, D. Natsiopoulos
%   GravLab, AUTh, 13/2/2020
%   update 19/8/2020

%    *** PARALLEL computing ***
%   ----------------------------------------------------------------------------------------
%   INFO
%   The function reads the NOM and PSO data
%   and compares their lengths.
%   Adjusts the PSO data according to the length of NOM data.
%   Interpolates the (X, Y, Z) coordinates  and then calculates the geodetic
%   coordinates (lon, lat, altitude) in GRS80.

%   *** Input ***
%   NOM_data_0 = the EGG_NOM_2 data
%   counter_NOM_0= 0 or 1/ is needed for further actions in the GUI
%   PSO_data_0 = the PSO_2 files data
%   counter_PSO_0= 0 or 1/ is needed for further actions in the GUI

%   *** Output ***
%   stop_process = counter /is needed for further aaction in GUI
%   GG_coords_GRF= "interior output" (see the row: 286)
%   ----------------------------------------------------------------------------------------


%% ----------- (1) LOAD DATA -----------
% --- NOM data ---
stop_process=0; % all ok
if (counter_NOM_0==1)
    baseFileNames=NOM_data_0; %
    
    if (ischar(baseFileNames)==1)
        % load data for 1 NOM file  /(always 1 in parallel computing)
        full_filename=strcat(path_NOM,baseFileNames); % concatenate the path+baseFileNames
        full_filename={full_filename}; % keep the data's name + path
        data{1,1}=full_filename(1);
        z{1,1} = string(data{1,1});
        
        % keep the data's name
        baseFileNames={baseFileNames};
        name_data_NOM{1,1}=baseFileNames(1);
        try
            daily_data_NOM{1,1}= load(z{1});
        catch ex
            % give a message if the data has not been successfully loaded.
            Opt.Interpreter = 'tex';
            Opt.WindowStyle = 'normal';
            msgbox({'Please, ensure that your input data is in ASCII format and has only rows and columns, no further text information. ';...
                ' ';'NOTE';...
                'The GOCEPARSER tool, provided by ESA, is capable of transforming the Earth Explorers File (EEF) format into other common formats (e.g: .sgg, .kin, .qat).';...
                'Optional: You can download the GOCEPARSER Parser from here:';...
                'https://earth.esa.int/eogateway/tools/goceparser'}, 'Error - NOM data ', 'Error', Opt);
            Opt.Interpreter = 'tex';
            Opt.WindowStyle = 'normal';
            msgbox({ex.identifier,',',ex.message}, 'problem NOM data ', 'help', Opt);
            stop_process=1; % counter/ terminate/ not ok
        end
        clear baseFileNames y z
    else
        % message for the user
        Opt.Interpreter = 'tex';
        Opt.WindowStyle = 'normal';
        msgbox({'Please, load the EGG NOM 2 data.'}, 'NOM data ', 'help', Opt);
        stop_process=1;% counter/ terminate/ not ok
    end
end


% --- PSO data ---
if stop_process==0 %if all ok
    if (counter_PSO_0==1)
        baseFileNames=PSO_data_0; %
        
        if (ischar(baseFileNames)==1)
            % load data for 1 PSO file  /(always 1 in parallel computing)
            full_filename=strcat(path_PSO,baseFileNames); % concatenate the path+baseFileNames
            full_filename={full_filename}; % keep the data's name + path
            data{1,1}=full_filename(1);
            z{1,1} = string(data{1,1});
            
            % keep the data's name
            baseFileNames={baseFileNames};
            name_data_PSO{1,1}=baseFileNames(1);
            try
                daily_data_PSO{1,1}= load(z{1});
            catch ex
                % give a message if the data has not been successfully loaded.
                Opt.Interpreter = 'tex';
                Opt.WindowStyle = 'normal';
                msgbox({'Please, ensure that your input data is in ASCII format and has only rows and columns, no further text information. ';...
                    ' ';'NOTE';...
                    'The GOCEPARSER tool, provided by ESA, is capable of transforming the Earth Explorers File (EEF) format into other common formats (e.g: .sgg, .kin, .qat).';...
                    'Optional: You can download the GOCEPARSER Parser from here:';...
                    'https://earth.esa.int/eogateway/tools/goceparser'}, 'Error - NOM data ', 'Error', Opt);
                Opt.Interpreter = 'tex';
                Opt.WindowStyle = 'normal';
                msgbox({ex.identifier,',',ex.message}, 'problem PSO data ', 'help', Opt);
                stop_process=1; % counter/ terminate/ not ok
            end
            clear baseFileNames y z
        else
            Opt.Interpreter = 'tex';
            Opt.WindowStyle = 'normal';
            msgbox({'Please, load the PSO 2 data.'}, 'PSO data ', 'help', Opt);
            stop_process=1;% counter/ terminate/ not ok
        end
    end
end


if stop_process==0 %if all ok
    %% ----------- (2) preallocating for speed -----------
    Vxx=cell(length(daily_data_NOM),1);
    Vyy=cell(length(daily_data_NOM),1);
    Vzz=cell(length(daily_data_NOM),1);
    Vxy=cell(length(daily_data_NOM),1);
    Vxz=cell(length(daily_data_NOM),1);
    Vyz=cell(length(daily_data_NOM),1);
    q1=cell(length(daily_data_NOM),1);
    q2=cell(length(daily_data_NOM),1);
    q3=cell(length(daily_data_NOM),1);
    q4=cell(length(daily_data_NOM),1);
    time_gps_nom=cell(length(daily_data_NOM),1);
    time_gps2utc_nom_1=cell(length(daily_data_NOM),1);
    time_gps2utc_nom=cell(length(daily_data_NOM),1);
    time_utc_nom_fractional=cell(length(daily_data_NOM),1);
    y_nom=cell(length(daily_data_NOM),1);
    m_nom=cell(length(daily_data_NOM),1);
    d_nom=cell(length(daily_data_NOM),1);
    h_nom=cell(length(daily_data_NOM),1);
    minu_nom=cell(length(daily_data_NOM),1);
    sec_nom=cell(length(daily_data_NOM),1);
    name_current_day=cell(length(daily_data_NOM),1);
    X_pso=cell(length(daily_data_PSO),1);
    Y_pso=cell(length(daily_data_PSO),1);
    Z_pso=cell(length(daily_data_PSO),1);
    time_utc1=cell(length(daily_data_PSO),1);
    time_utc2=cell(length(daily_data_PSO),1);
    time_utc3=cell(length(daily_data_PSO),1);
    time_utc4=cell(length(daily_data_PSO),1);
    time_utc5=cell(length(daily_data_PSO),1);
    time_utc6=cell(length(daily_data_PSO),1);
    t1_pso1=cell(length(daily_data_NOM),1);
    t1_pso=cell(length(daily_data_NOM),1);
    X_inter=cell(length(daily_data_NOM),1);
    Y_inter=cell(length(daily_data_NOM),1);
    Z_inter=cell(length(daily_data_NOM),1);
    time_utc_pso=cell(length(daily_data_PSO));
    time_utc_pso_fractional=cell(length(daily_data_PSO));
    time=cell(length(daily_data_NOM),1);
    i=1; % counter
    
    %% ----------- (3) Processing -----------
    % --- ***NOM*** ---
    %stop_process=0; % counter/ all ok
    
    % classification / needed columns
    % time
    time_gps_nom{i,1}=daily_data_NOM{i}(:,1);
    % Gravity_Gradients, unit="1/s^2" /Convert it to Eotvos unit *10^(-9)
    Vxx{i,1}=daily_data_NOM{i}(:,2)*(10^(9));
    Vyy{i,1}=daily_data_NOM{i}(:,3)*(10^(9));
    Vzz{i,1}=daily_data_NOM{i}(:,4)*(10^(9));
    Vxy{i,1}=daily_data_NOM{i}(:,5)*(10^(9));
    Vxz{i,1}=daily_data_NOM{i}(:,6)*(10^(9));
    Vyz{i,1}=daily_data_NOM{i}(:,7)*(10^(9));
    % Quaternions
    q1{i,1}=daily_data_NOM{i}(:,56);
    q2{i,1}=daily_data_NOM{i}(:,57);
    q3{i,1}=daily_data_NOM{i}(:,58);
    q4{i,1}=daily_data_NOM{i}(:,59);
    
    % Convert GPS time to UTC (from NOM data)
    time_gps2utc_nom_1{i,1}= datetime(gps2utc(time_gps_nom{i}/86400+723186),'ConvertFrom','datenum','Format', 'yyyy-MM-dd HH:mm:ss'); %(/86400+723186)= the reference of the start of GPS time % keeps fraction sec inside
    % extract the time to convert fractional sec to second (integer)
    t=time_gps2utc_nom_1{i,1};
    y = year(t);
    str_nom= month(t);
    d=day(t);
    h=hour(t);
    minu=minute(t);
    se=second(t);
    sec=floor(se);
    % format
    time_gps2utc_nom{i,1}= datetime(y,str_nom,d,h,minu,sec,'F','yyyy-MM-dd HH:mm:ss'); %for compare
    time_utc_nom_fractional{i,1}= datetime(y,str_nom,d,h,minu,se,'F','MMMM d yyyy HH:mm:ss.S'); % for interpolation
    
    % Needed information for figure's titles.
    t=time_gps2utc_nom{i,1};
    y_nom{i,1} = year(t);
    m_nom{i,1}= month(t);
    d_nom{i,1}=day(t);
    h_nom{i,1}=hour(t);
    minu_nom{i,1}=minute(t);
    sec_nom{i,1}=floor(second(t));
    
    % name of file
    name_current_day{i,1}= datetime(y_nom{i},m_nom{i},d_nom{i},'F','dd-MM-yyyy');
    % display NOM name/ needs for the comparison NOM(i)=PSO(i)
    str=name_data_NOM{i};
    nom1(i,1)=extractBetween(str,20,27); % keeps year/month/day
    nom(i,1)=str2double(nom1{i});
    
    
    % --- ***PSO*** ---
    % Coordinates (X,Y,Z)_EFRF
    X_pso{i,1}=daily_data_PSO{i}(:,7);
    Y_pso{i,1}=daily_data_PSO{i}(:,8);
    Z_pso{i,1}=daily_data_PSO{i}(:,9);
    % UTC time
    time_utc1{i,1}=daily_data_PSO{i}(:,1); % year
    time_utc2{i,1}=daily_data_PSO{i}(:,2); % month
    time_utc3{i,1}=daily_data_PSO{i}(:,3); % day
    time_utc4{i,1}=daily_data_PSO{i}(:,4); % hours
    time_utc5{i,1}=daily_data_PSO{i}(:,5); % minutes
    time_utc6{i,1}=daily_data_PSO{i}(:,6); % seconds
    
    % combine the 6 cells to output the date-time to UTC
    t1=time_utc1{i,1}(:,1); % year
    t2=time_utc2{i,1}(:,1); % month
    t3=time_utc3{i,1}(:,1); % day
    t4=time_utc4{i,1}(:,1); % hours
    t5=time_utc5{i,1}(:,1); % minutes
    t6=time_utc6{i,1}(:,1); % seconds
    t7=floor(t6); % it keeps the integer of the sec, without fractional sec.
    time_utc_pso{i,1}= datetime(t1,t2,t3,t4,t5,t7,'F','yyyy-MM-dd HH:mm:ss'); % for compare
    time_utc_pso_fractional{i,1}= datetime(t1,t2,t3,t4,t5,t6,'F','MMMM d yyyy HH:mm:ss.S'); % for interpolation
    
    % display PSO name/ needs for the comparison NOM(i)=PSO(i)
    str=name_data_PSO{i};
    pso1(i,1)=extractBetween(str,36,43); % keeps year/month/day
    pso(i,1)=str2double(pso1{i});
    
    
    %% ---------- (4)check the position between NOM and PSO ----------
    i=1;
    if (any(nom(1)==pso(i)))  % check the position between NOM and PSO
        
        % convert UTC time to GPS, to run properly the interpolation
        % for: *PSO time*
        t1_pso1{i,1}=utc2gps(time_utc_pso{i});
        t1_pso{i,1}=(t1_pso1{i,1}-723186)*86400;
        
        % for: *NOM time*
        t_NOM{i,1}=utc2gps(time_utc_nom_fractional{i});
        time{i,1}=(t_NOM{i,1}-723186)*86400;
        
        
        %% ---------- (5)Spline Interpolation  ----------
        X_inter{i,1} = interp1(t1_pso{i},X_pso{i},time{i},'spline'); % m
        Y_inter{i,1}= interp1(t1_pso{i},Y_pso{i},time{i},'spline'); % m
        Z_inter{i,1}= interp1(t1_pso{i},Z_pso{i},time{i},'spline'); % m
        
        
        %% ---------- (6)Transformation (X,Y,Z)_EFRF to (lat,lon,h)_GRS80 ----------
        [lat,lon,h] = XYZ_2_flh(X_inter, Y_inter, Z_inter); % lat, lon in degrees ,h in meters
        
        
        %% ---------- (7) save all in one matrix ----------
        GG_coords_GRF{1,1}=cell2mat(lon);
        GG_coords_GRF{2,1}=cell2mat(lat);
        GG_coords_GRF{3,1}=cell2mat(h);
        GG_coords_GRF{4,1}=cell2mat(Vxx);
        GG_coords_GRF{5,1}=cell2mat(Vyy);
        GG_coords_GRF{6,1}=cell2mat(Vzz);
        GG_coords_GRF{7,1}=cell2mat(Vxy);
        GG_coords_GRF{8,1}=cell2mat(Vxz);
        GG_coords_GRF{9,1}=cell2mat(Vyz);
        %GG_coords_GRF{10,1}=percentage_lost_data_nom;
        GG_coords_GRF{11,1}=time_utc_nom_fractional;
        GG_coords_GRF{12,1}=name_current_day;
        GG_coords_GRF{13,1}=cell2mat(q1);
        GG_coords_GRF{14,1}=cell2mat(q2);
        GG_coords_GRF{15,1}=cell2mat(q3);
        GG_coords_GRF{16,1}=cell2mat(q4); % from EGG_NOM_2
        %GG_coords_GRF{17,1}=cell2mat(t1_pso); % Time GPS - PSO data
        GG_coords_GRF{17,1}=cell2mat(time_gps_nom); % Time GPS - NOM data
    else
        stop_process=1; % counter / terminate
        GG_coords_GRF={}; % needed to avoid the "outptut argument not assigned during call the function"
    end
end
end

