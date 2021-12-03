function [k,stop_counter] = graflab_gui_geograv()
%    GeoGravGOCE project
%    E. Mamagiannou
%    GravLab, AUTh, 27/8/2020

%    ---------------------------------------------------------------------------------------------
%    INFO:
%    The function computes the Gravitational tensor components in the LNOF
%    (Vxx,Vyy,Vzz,Vxy,Vxz,Vyz) via "GrafLab" software for multiple input files.
%
%    "GrafLab" REFERENCES:
%    Bucha, B., Janak, J., 2013. A MATLAB-based graphical user interface
%    program for computing functionals of the geopotential up to ultra-high
%    degrees and orders. Computers and Geosciences 56, 186-196,
%    http://dx.doi.org/10.1016/j.cageo.2013.03.012.

%    *** INPUT ***
%    reads only .txt files with format (lat, lon ,h):
%    this input can be the output of the "input_graflab.m" function (optional)
%    lat: Latitude in degrees (1st column in .txt)
%    lon: Longitude in degrees (2nd column in .txt)
%    h: Ellipsoidal heights in metres (3rd column in .txt)

%    *** OUTPUT ***
%    k, stop_counter = counters/ are needed for further actions in GUI
%    ---------------------------------------------------------------------------------------------

%% (1)---> check if GrafLab.m file exists in user's folder in order to run the code
k=0; % counter
stop_counter=0; % counter

find_graflab = which('GrafLab.m','-all'); %Display the paths to all items on the MATLAB path with the name GrafLab.
addpath(find_graflab{1});

%if any(size(dir( 'GrafLab.m' ),1)) %or (exist('GrafLab.m', 'file')==2) %2 — name is a file with extension .m, .mlx, or .mlapp
if isempty(find_graflab)==0 %if the .m files exists
    % (1a)---> Input the data /GGM
    [GGM_name,path_GGM,~] = uigetfile( ...
        {'*.gfc','(*.gfc)';
        '*.*',  'All Files (*.*)'}, ...
        'Select GGM',...
        'MultiSelect', 'off');
    
    % check if the user click the cancel button
    if isequal(GGM_name, 0)
        k=1; % cancel button checked/ counter
        disp('The cancel button was selected.')
    else
        k=0; % all ok/ counter
        % % pop-up message (info) for the user
        Opt.Interpreter = 'tex';
        Opt.WindowStyle = 'normal';
        msgbox({'1. Load the Global Geoptential model (.gfc)';'';'2. Enter the required Graflab parameters';'';'3. Load the coordinates (lat, lon, h) (.txt)'}, 'Info - Steps', 'help', Opt);
        
        % (1b)---> name of the GGM
        if (ischar(GGM_name)==1) % load data for 1  file
            GGM_name={GGM_name};
            model_name=GGM_name(1);
        end
        
        % (1c)---> message for the user/ input graflab's parameters
        message = {'Minimum degree of the spherical harmonic expansion (nmin):','Maximum degree of the spherical harmonic expansion (nmax):','Geocentric gravitational constant of the GGM (m^3*s^-2) (GM):','Radius of the reference sphere of the GGM (m) (R):','Reference ellipsoid (GRS80/WGS84):'};
        dlgtitle = 'Parameters for GrafLab';
        dims = [1 75];
        definput = {'0','240','3986005.000E+8','637813.0','GRS80'};
        answer = inputdlg(message,dlgtitle,dims,definput);
        
        % check
        if isempty(answer)==1
            k=1; % cancel button checked
            disp('The cancel button was selected.')
            q=1;
        else
            nmin = str2num(answer{1});
            nmax = str2num(answer{2});
            GM = str2num(answer{3});
            R = str2num(answer{4});
            ref_ell = answer{5};
            
            % (1d)---> check user's inputs
            % nmin
            while (isnumeric(nmin)==0 || isempty(nmin)==1 && stop_counter==0)
                message = {'Please, rewrite the minimum degree of the spherical harmonic expansion (nmin):'};
                dlgtitle = 'nmin';
                dims = [1 75];
                definput = {'0'};
                ans = inputdlg(message,dlgtitle,dims,definput);
                if isempty(ans)==1
                    stop_counter=1;
                    disp('The cancel button was selected.')
                else
                    nmin = str2num(ans{1});
                    clear ans
                end
            end
            
            % nmax
            while (isnumeric(nmax)==0 || isempty(nmax)==1 && stop_counter==0)
                message = {'Please, rewrite the maximum degree of the spherical harmonic expansion (nmin):'};
                dlgtitle = 'nmax';
                dims = [1 75];
                definput = {'240'};
                ans = inputdlg(message,dlgtitle,dims,definput);
                if isempty(ans)==1
                    stop_counter=1;
                    disp('The cancel button was selected.')
                else
                    nmax = str2num(ans{1});
                    clear ans
                end
            end
            
            % R
            while (isnumeric(R)==0 || isempty(R)==1 && stop_counter==0)
                message = {'Please, rewrite the radius of the reference sphere of the GGM (m) (R):'};
                dlgtitle = 'R';
                dims = [1 75];
                definput = {'6378137.0'};
                ans = inputdlg(message,dlgtitle,dims,definput);
                if isempty(ans)==1
                    stop_counter=1;
                    disp('The cancel button was selected.')
                else
                    R = str2num(ans{1});
                    clear ans
                end
            end
            
            
            % GM
            while (isnumeric(GM)==0 || isempty(GM)==1 && stop_counter==0)
                message = {'Please, rewrite the geocentric gravitational constant of the GGM (m^3*s^-2) (GM)'};
                dlgtitle = 'GM';
                dims = [1 75];
                definput = {'3986005.000E+8'};
                ans = inputdlg(message,dlgtitle,dims,definput);
                if isempty(ans)==1
                    stop_counter=1;
                    disp('The cancel button was selected.')
                else
                    GM = str2num(ans{1});
                    clear ans
                end
            end
            
            % Reference ellipsoid
            ell=0;
            while (ell==0 && stop_counter==0)
                if (length(ref_ell)==5)
                    if ((strcmp(ref_ell,'GRS80')) || (strcmp(ref_ell,'grs80')))
                        ell=1;
                    elseif ((strcmp(ref_ell,'WGS84')) || (strcmp(ref_ell,'wgs84')))
                        ell=2;
                    end
                else
                    message = {'Please, rewrite the reference ellipsoid (GRS80/ WGS84):'};
                    dlgtitle = 'Reference ellipsoid';
                    dims = [1 75];
                    definput = {'GRS80'};
                    ans = inputdlg(message,dlgtitle,dims,definput);
                    if isempty(ans)==1
                        stop_counter=1;
                        disp('The cancel button was selected.')
                    else
                        ref_ell = ans{1};
                        clear ans
                    end
                end
            end
        end
        
        if (stop_counter==0 && k==0)
            % (1e)---> load (Lat, Lon, HEIGHT)/ (.txt)
            [users_data,path,~] = uigetfile( ...
                {'*.txt','(*.txt)';
                '*.*',  'All Files (*.*)'}, ...
                'Lod data (lat,lon,h)',...
                'MultiSelect', 'on');
            
            % check if the user click the cancel button
            if isequal(users_data, 0)
                k=1; % cancel button checked/ counter
                disp('The cancel button was selected.')
            else
                if (ischar(users_data)==1) % load data/ 1 .txt
                    users_data={users_data};
                    daily_data_graflab{1,1}= load(path+"\"+users_data{1});
                else
                    % load data/ more than 1 .txt
                    daily_data_graflab = cell((length(users_data)),1);
                    for i = 1:length(users_data)
                        daily_data_graflab{i} = load(path+"\"+users_data{1});
                    end
                end
            end
        end
    end
    
    
    if (k==0 && stop_counter==0)
        %% (2)---> Computing the Gravitational tensor compnents in the LNOF
        for i=1:length(daily_data_graflab)
            % (2a)---output name
            day_output1 = extractBefore(users_data{i},".");% name without synnix (.txt)
            day_output2 = extractBefore(model_name{1,1},".");% name without synnix (.txt)
            % final output
            %output_name =sprintf('%s__%s__%s',day_output2,num2str(nmax),day_output1); % output_name = output file of GrafLab
            output_name =sprintf('a%s_%s__nmax_%s__%s',num2str(i),day_output2,num2str(nmax),day_output1); % output_name = output file of GrafLab
            
            addpath(path)
            addpath(genpath(path_GGM))
            % (2b)--- Run GrafLab multiple times
            GrafLab('OK',GM,R,nmin,nmax,ell,model_name{1},...
                0,1,[],[],[],[],[],[],[],users_data{i},[],[],[],...
                output_name,0,[14 15],1,[],1,1,0,[],[],[],[],[],1)
            
            % info for user
            fprintf(2, '\nINFO GeoGravGOCE:\n')
            X = ['GrafLab output Name:',output_name];
            disp(X)
        end
    end
else
    k=1;
    % message for the user
    %Opt.Interpreter = 'tex';
    %Opt.WindowStyle = 'normal';
    %msgbox({'GrafLab.m file does not exist in your current folder'}, 'Info', 'help', Opt);
    clc
    fprintf(2, '\nGrafLab:\n')
    disp('GrafLab.m file does not exist in your computer.')
    fprintf(2, '\nSuggested Solution:\n')
    disp('GrafLab (GRAvity Field LABoratory) is a MATLAB-based graphical user interface program for computing functionals of the geopotential up to ultra-high degrees and orders.')
    disp(' ')
    disp('Bucha, B., Janák, J., 2013. A MATLAB-based graphical user interface program for computing functionals of the geopotential up to ultra-high degrees and orders.')
    disp(' ')
    disp('You can download the GrafLab.m file from here:')
    X = '<a href = "https://www.svf.stuba.sk/en/kggi/science-and-research/downloads.html?page_id=8479">GrafLab Web Site</a>';
    disp(X)
    disp(' ')
    disp('and then you can re-run the GrafLab button in the GeoGravGOCE app!')
    
    % message for user
    Opt.Interpreter = 'tex';
    Opt.WindowStyle = 'normal';
    msgbox({'GrafLab.m file does not exist in your computer.';...
        ' ';...
        'Please check the Command Window for a Suggested Solution.'}, 'GrafLab Info', 'help', Opt);
    
end

end








