function [result] = checking_NOM_PSO(baseFileNames,baseFileNames2)
%   GeoGravGOCE project
%   E. Mamagiannou
%   GravLab, AUTh, 15/9/2020

%   ---------------------------------------------------------------------------------------------
%   The function checks if the EGG_NOM_2 name corresponds precisely to the PSO_2 name.

%   *** input ***
%   baseFileNames = EGG_NOM_2 data (after parsing)
%   baseFileNames2 = PSO_2 data (after parsing)
%   (You can load more than one file simultaneously)

%    *** output ***
%   result = counter/ is needed for further actions in the GUI
%   ---------------------------------------------------------------------------------------------

result=0; % counter/ ok

%% *** NOM ***
% (A1)-----load data for 1 NOM file
if (ischar(baseFileNames)==1)
    baseFileNames={baseFileNames};
    name_data_NOM{1,1}=baseFileNames(1); % keep the NOM names
else
    % (A2)-----load data: more than 1 NOM file
    for i=1:length(baseFileNames)
        name_data_NOM{i,1}=baseFileNames(i); % keep the NOM names
    end
end

% (A3)-----display NOM names: needed for the comparison NOM(i)=PSO(i)
for i=1:length(baseFileNames)
    str=name_data_NOM{i};
    if result==0
        try
            nom1(i,1)=extractBetween(str,20,27); % extract: year/month/day
        catch
            % Error message
            Opt.Interpreter = 'tex';
            Opt.WindowStyle = 'normal';
            msgbox({'The NOM product file name is NOT composed of the following components:';...
                'MM-CCCC-TTTTTTTTTT-yyyymmddThhmmss-YYYYMMDDTHHMMSS-vvvv.XXX';...
                ' ';...
                'For more information, please check:';...
                'Gruber, Thomas, Reiner Rummel, and Radboud Koop. 2007. "HOW to Use GOCE Level 2 Products" European Space Agency, (Special Publication) ESA SP 2006(SP-627):205–11'},...
                'Error - NOM data ', 'Error', Opt);
            % app.Lamp.Color= 'red';% visualization Error: red lamp
            result=1; % counter/ NOT ok
        end
    end
end

%(A4)-----Convert it to numeric array
if result==0
    for i=1:length(baseFileNames)
        nom(i,1)=str2num(nom1{i});
    end
end


%% *** PSO ***
if result==0
    % (B1)-----load data for 1 PSO file
    if (ischar(baseFileNames2)==1)
        baseFileNames2={baseFileNames2};
        name_data_PSO{1,1}=baseFileNames(1);
    else
        % (B2)-----load data: more than 1 PSO file
        for i=1:length(baseFileNames2)
            name_data_PSO{i,1}=baseFileNames2(i); % keep the PSO names
        end
    end
    
    % (B3)-----display PSO names: needed for the comparison NOM(i)=PSO(i)
    for i=1:length(baseFileNames2)
        str=name_data_PSO{i};
        if result==0
            try
                pso1(i,1)=extractBetween(str,36,43); % keeps year/month/day
            catch
                Opt.Interpreter = 'tex';
                Opt.WindowStyle = 'normal';
                msgbox({'The PSO product file name is NOT composed of the following components:';...
                    'MM-CCCC-TTTTTTTTTT-yyyymmddThhmmss-YYYYMMDDTHHMMSS-vvvv.XXX';...
                    ' ';...
                    'For more information, please check:';...
                    'Gruber, Thomas, Reiner Rummel, and Radboud Koop. 2007. "HOW to Use GOCE Level 2 Products" European Space Agency, (Special Publication) ESA SP 2006(SP-627):205–11'},...
                    'Error - PSO data ', 'Error', Opt);
                % app.Lamp.Color= 'red';% visualization Error: red lamp
                result=1; % counter/ NOT ok
            end
        end
    end
    
    %(B4)-----Convert it to numeric array
    if result==0
        for i=1:length(baseFileNames2)
            pso(i,1)=str2num(pso1{i});
        end
    end
end


%% check 1
if result==0
    if length(nom)>=length(pso)
        cc=length(pso);
    else
        cc=length(nom);
    end
    
    % check 2
    for i=1:cc
        if (nom(i)==pso(i))% && (length(nom)==length(pso)))
            result=0; % counter/ ok
        else
            % (1) Matlab's command window message
            fprintf(2, '\nERROR:\n')
            X = ['The NOM file GO_CONS_EGG_NOM_2__',num2str(nom(i)),' does not match with the corresponding loaded PSO file.'];
            disp(X)
            
            % (2) pop-up message
            
            result=1;  % counter/ terminate
        end
    end
end
end

