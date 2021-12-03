function [ GGM_LNOF_2_GRF,close_ggm] = ggm_transform_parallel( datafortransform,GGM_data_0, counter_GGM_0,PSO_QAT_data_0,counter_PSO_QAT_0,GGM_c ,PSO_QAT_c )
%   GeoGravGOCE project
%   E. Pitenis
%   GravLab, AUTh, 25/8/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function for choosing single or parallel processing  of the transformation from LNOF to GRF
%   ----------------------------------------------------------------------------------------
%% Creation of folder
p = 1 ;
foldername = sprintf('GGM Transformations%02',p);
mkdir(foldername);
currentFolder = pwd; % Identify current fold
% add path
currentFolder=[currentFolder, '\GGM Transformations'];
%% Preallocations of data
pso1=cell(length(PSO_QAT_data_0),1);
str=cell(length(PSO_QAT_data_0),1);
pso_test1=NaT(length(PSO_QAT_data_0),1);
psoyears=zeros(length(PSO_QAT_data_0),1);
psomonths=zeros(length(PSO_QAT_data_0),1);
psoday=zeros(length(PSO_QAT_data_0),1);
pso=zeros(length(PSO_QAT_data_0),1);
pso_qat_created=zeros(length(PSO_QAT_data_0),1);
b22=zeros(length(GGM_data_0),1);
b33=zeros(length(GGM_data_0),1);
c22=zeros(length(GGM_data_0),1);
c32=zeros(length(GGM_data_0),1);
d12=zeros(length(GGM_data_0),1);
d22=zeros(length(GGM_data_0),1);
datafortransform11=cell(length(datafortransform),1);
%% Load data (GGM and PSO_QAT) and applying of some checks
if (counter_GGM_0>1)||(GGM_c>1)||(counter_PSO_QAT_0>1)||(PSO_QAT_c>1)
    counter_GGM_0=1;
    GGM_c=1;
    counter_PSO_QAT_0=1;
    PSO_QAT_c=1;
end

if (ischar(GGM_data_0)==1) && (ischar(PSO_QAT_data_0)==1)
    firsttest=size(GGM_data_0,1);
    secondtest=size(PSO_QAT_data_0,1);
    thirdtest=length(datafortransform{11,1});
else
    firsttest=length(GGM_data_0);
    secondtest=length(PSO_QAT_data_0);
    thirdtest=length(datafortransform{11,1});
end

if isequal(firsttest,secondtest,thirdtest)
    % load user's EGG_GGM_2 data:
    if (counter_GGM_0==1)
        baseFileNames=GGM_data_0; %
        
        % load data for 1 GGM file
        if (ischar(baseFileNames)==1)
            baseFileNames={baseFileNames};
            name_data_GGM{1,1}=baseFileNames(1);
            z{1,1} = string(name_data_GGM{1,1});
            daily_data_GGM{1,1}= load(z{1});
            clear baseFileNames y z
            
            % load the data/ more than 1 GGM file
        else
            daily_data_GGM=cell(length(GGM_data_0),1);
            name_data_GGM=cell(length(GGM_data_0),1);
            z=cell(length(GGM_data_0),1);
            
            for i=1:length(baseFileNames)
                name_data_GGM{i,1}=baseFileNames(i); % keep the names of the data to know which day we running
            end
            
            for i=1:length(baseFileNames)  % load the data inside / more than one files
                z{i,1} = string(name_data_GGM{i,1}(1));
                daily_data_GGM{i,1}= load(z{i});
            end
            
            clear baseFileNames y z
        end
        
    end
    
    % load user's PSO_QAT_2 data:
    if (counter_PSO_QAT_0==1)
        baseFileNames=PSO_QAT_data_0; %
        
        % load data for 1 GGM file
        if (ischar(baseFileNames)==1)
            baseFileNames={baseFileNames};
            name_data_PSO_QAT{1,1}=baseFileNames(1);
            z{1,1} = string(name_data_PSO_QAT{1,1});
            daily_data_PSO_QAT{1,1}= load(z{1});
            str(1,1)=name_data_PSO_QAT{1};
            pso1(1,1)=extractBetween(str(1,1),36,43); % keeps year/month/day
            pso(1,1)=str2num(pso1{1});
            pso_test1(1,1)=datafortransform{11,1}{1,1}(1);
            psoyears(1,1)=pso_test1.Year(1,1);
            psomonths(1,1)=pso_test1.Month(1,1);
            psoday(1,1)=pso_test1.Day(1,1);
            abc11=sprintf('%02d',psoyears(1,1));
            abc21=sprintf('%02d',psomonths(1,1));
            abc31=sprintf('%02d',psoday(1,1));
            pso_qat=strcat(abc11,abc21,abc31);
            pso_qat_created(1,1)=str2double(pso_qat);
            clear baseFileNames y z
            
            % load the data/ more than 1 GGM file
        else
            daily_data_PSO_QAT=cell(length(PSO_QAT_data_0),1);
            name_data_PSO_QAT=cell(length(PSO_QAT_data_0),1);
            for i=1:length(baseFileNames)
                name_data_PSO_QAT{i,1}=baseFileNames(i); % keep the names of the data to know which day we running
            end
            
            for i=1:length(baseFileNames)  % load the data inside / more than one files
                z{i,1} = string(name_data_PSO_QAT{i,1}(1));
                daily_data_PSO_QAT{i,1}= load(z{i});
            end
            
            for i=1:length(baseFileNames)
                str(i,1)=name_data_PSO_QAT{i};
                pso1(i,1)=extractBetween(str(i,1),36,43); % keeps year/month/day
            end
            
            for i=1:length(baseFileNames)
                pso(i,1)=str2num(pso1{i});
            end
            
            for i=1:length(baseFileNames)
                pso_test1(i,1)=datafortransform{11,1}{i,1}(1);
                psoyears(i,1)=pso_test1.Year(i,1);
                psomonths(i,1)=pso_test1.Month(i,1);
                psoday(i,1)=pso_test1.Day(i,1);
                abc11=sprintf('%02d',psoyears(i,1));
                abc21=sprintf('%02d',psomonths(i,1));
                abc31=sprintf('%02d',psoday(i,1));
                pso_qat=strcat(abc11,abc21,abc31);
                pso_qat_created(i,1)=str2double(pso_qat);
            end
            
            clear baseFileNames y z
        end
    end
    
    %% Checking length of imported data
    a1=length(daily_data_PSO_QAT);
    a2=length(daily_data_GGM);
    a3=length(datafortransform{1,1});
    
    for i=1:length(daily_data_GGM)
        b12=length(daily_data_GGM{i,1});
        b13=length(datafortransform{1,1}{i,1});
        b22(i,1)=b12;
        b33(i,1)=b13;
    end
    b2=b22;
    b3=b33;
    
    
    for m=1:length(daily_data_GGM)
        c22(m,1)=daily_data_GGM{m,1}(1,1);
        c32(m,1)=daily_data_GGM{m,1}(1,2);
        d12(m,1)=datafortransform{1,1}{m,1}(1);
        d22(m,1)=datafortransform{2,1}{m,1}(1);
    end
    c21=c22;
    c31=c32;
    d11=d12;
    d21=d22;
    c2=str2num(sprintf('%.4f',c21));
    c3=str2num(sprintf('%.4f',c31));
    d1=str2num(sprintf('%.4f',d11));
    d2=str2num(sprintf('%.4f',d21));
    
    if isequal(a1,a2,a3)&& isequal(b2,b3) && isequal(pso,pso_qat_created) && isequal(c2,d2) && isequal(c3,d1)
        close_ggm=0;
        
        % GGM Transformation - for one-three files single processing - for more than three files parallel processing
        %initialize variables & creation of data format for parallel pool
        result_GGM=cell(length(datafortransform{1,1}),1);
        
        datafortransform2={datafortransform{1,1}; datafortransform{2,1}; datafortransform{3,1}; datafortransform{4,1};datafortransform{5,1}; datafortransform{6,1}; datafortransform{7,1}; datafortransform{8,1}; datafortransform{9,1}; datafortransform{11,1}; datafortransform{12,1}; datafortransform{13,1}; datafortransform{14,1}; datafortransform{15,1}; datafortransform{16,1}; datafortransform{17,1}};
        
        for j=1:length(datafortransform{1,1})
            datafortransform11{j,1}=cellfun(@(datafortransform11) datafortransform11(j,1), datafortransform2);
        end
        
        datafortransformfinal=datafortransform11;
        
        tic
        el=length(datafortransform{1,1});
        if el<=3
            for p=1:length(datafortransform{1,1})
                [ GGM_LNOF_2_GRF1  ] = LNOF_2_GRF( datafortransformfinal{p,1}, daily_data_GGM{p,1}, daily_data_PSO_QAT{p,1},GGM_c ,PSO_QAT_c);
                result_GGM{p,1}=GGM_LNOF_2_GRF1;
            end
        else
            % Start of parallel computing
            % Checking for parallel pool
            % ----------  Check if a pool already exists ----------
            poolobj = gcp('nocreate');
            if isempty(poolobj)
                poolobj = parpool('local'); % Create a local pool with processes
                poolcreationresult = 'A new pool was created.';
            else
                poolcreationresult = 'Using existing pool.';
            end
            fprintf("%s\n",strcat(poolcreationresult,' NumOfWorkers is:',string(poolobj.NumWorkers)))
            
            parfor p=1:length(datafortransform{1,1})
                [ GGM_LNOF_2_GRF1  ] = LNOF_2_GRF( datafortransformfinal{p,1}, daily_data_GGM{p,1}, daily_data_PSO_QAT{p,1},GGM_c ,PSO_QAT_c);
                result_GGM{p,1}=GGM_LNOF_2_GRF1;
            end
        end
        toc
        
        %GGM_LNOF_2_GRF
        for o=1:length(result_GGM)
            GGM_LNOF_2_GRF{1,1}{o,1}=result_GGM{o,1}{1}{1};
            GGM_LNOF_2_GRF{2,1}{o,1}=result_GGM{o,1}{2}{1};
            GGM_LNOF_2_GRF{3,1}{o,1}=result_GGM{o,1}{3}{1};
            GGM_LNOF_2_GRF{4,1}{o,1}=result_GGM{o,1}{4}{1};
            GGM_LNOF_2_GRF{5,1}{o,1}=result_GGM{o,1}{5}{1};
            GGM_LNOF_2_GRF{6,1}{o,1}=result_GGM{o,1}{6}{1};
            GGM_LNOF_2_GRF{7,1}{o,1}=result_GGM{o,1}{7}{1};
            GGM_LNOF_2_GRF{8,1}{o,1}=result_GGM{o,1}{8}{1};
            GGM_LNOF_2_GRF{9,1}{o,1}=result_GGM{o,1}{9}{1};
            GGM_LNOF_2_GRF{10,1}{o,1}=result_GGM{o,1}{10}{1};
            GGM_LNOF_2_GRF{11,1}{o,1}=result_GGM{o,1}{11}{1};
            GGM_LNOF_2_GRF{12,1}{o,1}=result_GGM{o,1}{12}{1};
            GGM_LNOF_2_GRF{13,1}{o,1}=result_GGM{o,1}{13}{1};
            GGM_LNOF_2_GRF{14,1}{o,1}=result_GGM{o,1}{14}{1};
            GGM_LNOF_2_GRF{15,1}{o,1}=result_GGM{o,1}{15}{1};
            GGM_LNOF_2_GRF{16,1}{o,1}=result_GGM{o,1}{16}{1};
            GGM_LNOF_2_GRF{17,1}{o,1}=result_GGM{o,1}{17}{1};
            GGM_LNOF_2_GRF{18,1}{o,1}=result_GGM{o,1}{18}{1};
            GGM_LNOF_2_GRF{19,1}{o,1}=result_GGM{o,1}{19}{1};
            GGM_LNOF_2_GRF{20,1}{o,1}=result_GGM{o,1}{20}{1};
            GGM_LNOF_2_GRF{21,1}{o,1}=result_GGM{o,1}{21}{1};
            GGM_LNOF_2_GRF{22,1}{o,1}=result_GGM{o,1}{22}{1};
            GGM_LNOF_2_GRF{23,1}{o,1}=result_GGM{o,1}{23}{1};
            GGM_LNOF_2_GRF{24,1}{o,1}=result_GGM{o,1}{24}{1};
            GGM_LNOF_2_GRF{25,1}{o,1}=result_GGM{o,1}{25}{1};
            GGM_LNOF_2_GRF{26,1}{o,1}=result_GGM{o,1}{26}{1};
            GGM_LNOF_2_GRF{27,1}{o,1}=result_GGM{o,1}{27}{1};
            GGM_LNOF_2_GRF{28,1}{o,1}=result_GGM{o,1}{28}{1};
            GGM_LNOF_2_GRF{29,1}{o,1}=result_GGM{o,1}{29}{1};
            GGM_LNOF_2_GRF{30,1}{o,1}=result_GGM{o,1}{30}{1};
            GGM_LNOF_2_GRF{31,1}{o,1}=result_GGM{o,1}{31}{1};
            GGM_LNOF_2_GRF{32,1}{o,1}=result_GGM{o,1}{32}{1};
            GGM_LNOF_2_GRF{33,1}{o,1}=result_GGM{o,1}{33}{1};
            GGM_LNOF_2_GRF{34,1}{o,1}=result_GGM{o,1}{34}{1};
            GGM_LNOF_2_GRF{35,1}{o,1}=result_GGM{o,1}{35}{1};
            GGM_LNOF_2_GRF{36,1}{o,1}=result_GGM{o,1}{36}{1};
            GGM_LNOF_2_GRF{37,1}{o,1}=result_GGM{o,1}{37}{1};
        end
        
        currentFolder1=[currentFolder, '\GGM_LNOF_2_GRF.mat'];
        save(currentFolder1,'GGM_LNOF_2_GRF');
        %% Creation of report about the GGs transformed from LNOF to GRF
        report=' ';
        report =[report, newline 'GeoGravGOCE, GravLab, AUTh, 2020'];
        report =[report, newline ' '];
        report =[report, newline 'The "GGM_LNOF_2_GRF.mat" contains the Vij of GGM in GRF,IRF,EFRF and LNOF(Eötvös):'];
        report =[report, newline 'Dimensions of GGM_LNOF_2_GRF.mat: cell=[37x1] '];
        report =[report, newline ' '];
        report =[report, newline 'subcells = 37 = latitude,longitude,height(GOCE altitude),UTC time (NOM data),the name of the current NOM day/file you process & the 6 Gravity Gradients in GRF,IRF,EFRF and LNOF '];
        report =[report, newline ' '];
        report =[report, newline 'GGM_LNOF_2_GRF{1,1} = latitude(degrees) (GRS80)'];
        report =[report, newline 'GGM_LNOF_2_GRF{2,1} = longitude(degrees) (GRS80)'];
        report =[report, newline 'GGM_LNOF_2_GRF{3,1} = h (meters)(GOCE altitude)(degrees) (GRS80)'];
        report =[report, newline 'GGM_LNOF_2_GRF{4,1} = UTC time (NOM data)'];
        report =[report, newline 'GGM_LNOF_2_GRF{5,1} = The name of the current NOM day/file you process'];
        report =[report, newline 'GGM_LNOF_2_GRF{6,1} = Vxx in GRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{7,1} = Vyy in GRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{8,1} = Vzz in GRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{9,1} = Vxy in GRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{10,1} = Vxz in GRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{11,1} = Vyz in GRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{12,1} = Vxx in IRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{13,1} = Vyy in IRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{14,1} = Vzz in IRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{15,1} = Vxy in IRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{16,1} = Vxz in IRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{17,1} = Vyz in IRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{18,1} = Vxx in EFRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{19,1} = Vyy in EFRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{20,1} = Vzz in EFRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{21,1} = Vxy in EFRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{22,1} = Vxz in EFRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{23,1} = Vyz in EFRF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{24,1} = Vxx in LNOF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{25,1} = Vyy in LNOF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{26,1} = Vzz in LNOF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{27,1} = Vxy in LNOF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{28,1} = Vxz in LNOF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{29,1} = Vyz in LNOF (Eötvös)'];
        report =[report, newline 'GGM_LNOF_2_GRF{30,1} = q1 (for IRF to GRF transformation)'];
        report =[report, newline 'GGM_LNOF_2_GRF{31,1} = q2 (for IRF to GRF transformation)'];
        report =[report, newline 'GGM_LNOF_2_GRF{32,1} = q3 (for IRF to GRF transformation)'];
        report =[report, newline 'GGM_LNOF_2_GRF{33,1} = q4 (for IRF to GRF transformation)'];
        report =[report, newline 'GGM_LNOF_2_GRF{34,1} = q1 (for EFRF to IRF transformation)'];
        report =[report, newline 'GGM_LNOF_2_GRF{35,1} = q2 (for EFRF to IRF transformation)'];
        report =[report, newline 'GGM_LNOF_2_GRF{36,1} = q3 (for EFRF to IRF transformation)'];
        report =[report, newline 'GGM_LNOF_2_GRF{37,1} = q4 (for EFRF to IRF transformation)'];
        report =[report, newline ' '];
        
        currentFolder2=[currentFolder, '\GGM_LNOF_2_GRF_Report.txt'];
        dlmwrite (currentFolder2,report,'delimiter','');
        
    else
        close_ggm=1;
        GGM_LNOF_2_GRF={};
    end
else
    close_ggm=1;
    GGM_LNOF_2_GRF={};
end
end
