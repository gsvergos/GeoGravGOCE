function [ GGM_LNOF_2_GRF1  ] = LNOF_2_GRF(datafortransform, daily_data_GGM, daily_data_PSO_QAT,GGM_c ,PSO_QAT_c)
%   GeoGravGOCE project
%   E. Pitenis (Quaternion interpolation code by D.Piretzidis )
%   GravLab, AUTh, 20/2/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function for the transformation from LNOF to GRF of the GGM's gravity gradients
%   ----------------------------------------------------------------------------------------
%% Load initial data for transformation
lon1 = datafortransform{1,1};
lat1 = datafortransform{2,1};
h1 = datafortransform{3,1};
time_utc_nom_fractional_new1 = datafortransform{10,1};
name_current_day1 = datafortransform{11,1}; %need for plots
q1_new1=datafortransform{12,1};
q2_new1=datafortransform{13,1};
q3_new1=datafortransform{14,1};
q4_new1=datafortransform{15,1};
t1_nom1=datafortransform{16,1};

lon{1,1}=lon1;
lat{1,1}=lat1;
h{1,1}=h1;
time_utc_nom_fractional_new{1,1}=time_utc_nom_fractional_new1;
name_current_day{1,1}=name_current_day1;
q1_new{1,1}=q1_new1;
q2_new{1,1}=q2_new1;
q3_new{1,1}=q3_new1;
q4_new{1,1}=q4_new1;
t1_nom{1,1}=t1_nom1;

daily_data_PSO_QAT1{1,1}=daily_data_PSO_QAT;
daily_data_GGM1{1,1}=daily_data_GGM;

%% Preallocations
q1_efrf=cell(length(daily_data_PSO_QAT1),1);
q2_efrf=cell(length(daily_data_PSO_QAT1),1);
q3_efrf=cell(length(daily_data_PSO_QAT1),1);
q4_efrf=cell(length(daily_data_PSO_QAT1),1);
t11_qat=cell(length(q1_efrf),1);
t12_qat=cell(length(q1_efrf),1);
time_qat_final=cell(length(q1_efrf),1);
Vxx_GGM=cell(length(daily_data_GGM1),1);
Vyy_GGM=cell(length(daily_data_GGM1),1);
Vzz_GGM=cell(length(daily_data_GGM1),1);
Vxy_GGM=cell(length(daily_data_GGM1),1);
Vxz_GGM=cell(length(daily_data_GGM1),1);
Vyz_GGM=cell(length(daily_data_GGM1),1);
%% PSO_QAT processing

if (PSO_QAT_c==1)
    
    % load .qat files for the same day(s) as the ones you calculated in the Vij_calculate tab
    %for i=1:length(daily_data_PSO_QAT1)
    i=1;
    q1_efrf{i,1}=daily_data_PSO_QAT1{i}(:,2);
    q2_efrf{i,1}=daily_data_PSO_QAT1{i}(:,3);
    q3_efrf{i,1}=daily_data_PSO_QAT1{i}(:,4);
    q4_efrf{i,1}=daily_data_PSO_QAT1{i}(:,5);
    %end
    
    % Creation of time for the PSO_2 (.qat) file
    for i=1:length(q1_efrf)
        ta=time_utc_nom_fractional_new{i,1}(1,1);
        tayears=ta.Year;
        tamonths=ta.Month;
        taday=ta.Day;
        t_qat=datetime(tayears,tamonths,taday,0,0,0);
        z=(length(q1_efrf{i,1}))-1;
        t1_qat=(t_qat+seconds(0:z))';
        %t1_qat=(t_qat+seconds(0:86399))';
        t11_qat{i,1}=t1_qat;
        t12_qat{i,1}=utc2gps(t1_qat);
        time_qat_final{i,1}=(t12_qat{i,1}-723186)*86400;
    end
    
    q1_efrf_new=q1_efrf;
    q2_efrf_new=q2_efrf;
    q3_efrf_new=q3_efrf;
    q4_efrf_new=q4_efrf;
    
    % Erase data in .qat file according to length of NOM files
    for k=1:length(lon)
        t1_nom_1=t1_nom{k,1};
        time_qat_final_1=time_qat_final{k,1};
        q1_efrf_new_1=q1_efrf_new{k,1};
        q2_efrf_new_1=q2_efrf_new{k,1};
        q3_efrf_new_1=q3_efrf_new{k,1};
        q4_efrf_new_1=q4_efrf_new{k,1};
        time_utc_nom_fractional_new_1 =time_utc_nom_fractional_new{k,1};
        
        B=dateshift(time_utc_nom_fractional_new_1,'start','second');
        %A=setdiff(t11_qat{k,1},B);
        D=ismember(t11_qat{k,1},B);
        rowsToDelete = any(D==0, 2);
        time_qat_final_1(rowsToDelete,:) = []; % erase rows in time_qat_final_1
        q1_efrf_new_1(rowsToDelete,:) = []; % erase rows in q1_efrf_new_1
        q2_efrf_new_1(rowsToDelete,:) = []; % erase rows in q2_efrf_new_1
        q3_efrf_new_1(rowsToDelete,:) = []; % erase rows in q3_efrf_new_1
        q4_efrf_new_1(rowsToDelete,:) = []; % erase rows in q4_efrf_new_1
        
        % Quaternion interpolation code by D.Piretzidis (Interpolation of Quaternions as described in GOCE Level 2 Product Data Handbook and D. Piretzidis master)
        
        % preallocations
        q1int=zeros(length(lat1),1);
        q2int=zeros(length(lat1),1);
        q3int=zeros(length(lat1),1);
        q4int=zeros(length(lat1),1);
        
        scan1=abs(length(t1_nom_1)-length(time_qat_final_1)+2000);
        scan2=abs(length(t1_nom_1)-length(time_qat_final_1)+2000);
        for j=1:length(t1_nom_1)
            
            if (j-scan1)<=0
                scan11=j-1;
            else
                scan11=scan1;
            end
            
            if (j+scan2)>=length(time_qat_final_1)
                scan22=length(time_qat_final_1)-j;
            else
                scan22=scan2;
            end
            
            for i=(j-scan11):(j+scan22-1)
                ta=time_qat_final_1(i,1);
                tb=time_qat_final_1(i+1,1);
                t=t1_nom_1(j,1);
                if (ta<=t)&&(t<=tb)
                    
                    qa1=q1_efrf_new_1(i,1); qa2=q2_efrf_new_1(i,1); qa3=q3_efrf_new_1(i,1); qa4=q4_efrf_new_1(i,1);
                    qb1=q1_efrf_new_1(i+1,1); qb2=q2_efrf_new_1(i+1,1); qb3=q3_efrf_new_1(i+1,1); qb4=q4_efrf_new_1(i+1,1);
                    
                    scalar_q=qa1*qb1+qa2*qb2+qa3*qb3;
                    if  scalar_q<0
                        qb1=-qb1; qb2=-qb2; qb3=-qb3; qb4=-qb4;
                    end
                    
                    qab1=qa4*qb1-qa1*qb4+qa3*qb2-qa2*qb3;
                    qab2=qa4*qb2-qa2*qb4+qa1*qb3-qa3*qb1;
                    qab3=qa4*qb3-qa3*qb4+qa2*qb1-qa1*qb2;
                    qab4=qa4*qb4+qa1*qb1+qa2*qb2+qa3*qb3;
                    
                    Phiab=2*acos(qab4);
                    Phiat=Phiab*(t-ta)/(tb-ta);
                    
                    qat1=qab1*(sin(Phiat/2))/(sin(Phiab/2));
                    qat2=qab2*(sin(Phiat/2))/(sin(Phiab/2));
                    qat3=qab3*(sin(Phiat/2))/(sin(Phiab/2));
                    qat4=cos(Phiat/2);
                    
                    q1int(j,1)=qa4*qat1+qa1*qat4-qa3*qat2+qa2*qat3;
                    q2int(j,1)=qa4*qat2+qa2*qat4-qa1*qat3+qa3*qat1;
                    q3int(j,1)=qa4*qat3+qa3*qat4-qa2*qat1+qa1*qat2;
                    q4int(j,1)=qa4*qat4-qa1*qat1-qa2*qat2-qa3*qat3;
                end
            end
        end
        
        q1int(end)=q1_efrf_new_1(end);
        q2int(end)=q2_efrf_new_1(end);
        q3int(end)=q3_efrf_new_1(end);
        q4int(end)=q4_efrf_new_1(end);
        
        % preallocations
        q1_int=cell(length(lon),1);
        q2_int=cell(length(lon),1);
        q3_int=cell(length(lon),1);
        q4_int=cell(length(lon),1);
        
        q1_int{k,1}=q1int;
        q2_int{k,1}=q2int;
        q3_int{k,1}=q3int;
        q4_int{k,1}=q4int;
    end
    
    q1int=q1_int;
    q2int=q2_int;
    q3int=q3_int;
    q4int=q4_int;
    
end
%% GGM processing and transformation from LNOF to GRF for the GGM model (as described in GOCE Level 2 Product Data Handbook and D. Piretzidis master)
if (GGM_c==1)
    
    %for i=1:length(daily_data_GGM1)
    i=1;
    % Gravity_Gradients in GGM-LNOF
    Vxx_GGM{i,1}=daily_data_GGM1{i}(:,4);
    Vyy_GGM{i,1}=daily_data_GGM1{i}(:,5);
    Vzz_GGM{i,1}=daily_data_GGM1{i}(:,6);
    Vxy_GGM{i,1}=daily_data_GGM1{i}(:,7);
    Vxz_GGM{i,1}=daily_data_GGM1{i}(:,8);
    Vyz_GGM{i,1}=daily_data_GGM1{i}(:,9);
    %end
    
    % Transformation from LNOF to GRF for the GGM model
    
    % load data needed for the transformation
    j=1;
    %for j=1:length(Vxx_GGM)
    Vxx_GGM_1=Vxx_GGM{j,1};
    Vyy_GGM_1=Vyy_GGM{j,1};
    Vzz_GGM_1=Vzz_GGM{j,1};
    Vxy_GGM_1=Vxy_GGM{j,1};
    Vxz_GGM_1=Vxz_GGM{j,1};
    Vyz_GGM_1=Vyz_GGM{j,1};
    q1_new_1=q1_new{j,1};
    q2_new_1=q2_new{j,1};
    q3_new_1=q3_new{j,1};
    q4_new_1=q4_new{j,1};
    q1int_1=q1int{j,1};
    q2int_1=q2int{j,1};
    q3int_1=q3int{j,1};
    q4int_1=q4int{j,1};
    lat_1=lat{j,1};
    lon_1=lon{j,1};
    
    % Preallocations for speed - Creation of zero matrices for the LNOF to GRF transformation
    
    % create GGs matrix in EFRF (preallocations)
    Vxx_efrf_new_1=zeros(length(lat_1),1);
    Vyy_efrf_new_1=zeros(length(lat_1),1);
    Vxy_efrf_new_1=zeros(length(lat_1),1);
    Vxz_efrf_new_1=zeros(length(lat_1),1);
    Vyz_efrf_new_1=zeros(length(lat_1),1);
    Vzz_efrf_new_1=zeros(length(lat_1),1);
    
    % create GGs matrix in IRF (preallocations)
    Vxx_IRF=zeros(length(lat_1),1);
    Vyy_IRF=zeros(length(lat_1),1);
    Vxy_IRF=zeros(length(lat_1),1);
    Vxz_IRF=zeros(length(lat_1),1);
    Vyz_IRF=zeros(length(lat_1),1);
    Vzz_IRF=zeros(length(lat_1),1);
    
    % create GGs matrix in GRF (preallocations)
    Vxx_GRF=zeros(length(lat_1),1);
    Vyy_GRF=zeros(length(lat_1),1);
    Vxy_GRF=zeros(length(lat_1),1);
    Vxz_GRF=zeros(length(lat_1),1);
    Vyz_GRF=zeros(length(lat_1),1);
    Vzz_GRF=zeros(length(lat_1),1);
    
    % create rotation matrices for the transformation
    % (preallocations)
    R_EFRF=zeros(3,3,length(lat_1));
    R_IRF=zeros(3,3,length(lat_1));
    R=zeros(3,3,length(lat_1));
    
    % Initialization of transformation
    for i=1:length(lat_1)
        
        % create the GG matrix for GGM in LNOF
        V_LNOF=[Vxx_GGM_1(i,1),Vxy_GGM_1(i,1),Vxz_GGM_1(i,1); Vxy_GGM_1(i,1),Vyy_GGM_1(i,1),Vyz_GGM_1(i,1); Vxz_GGM_1(i,1),Vyz_GGM_1(i,1),Vzz_GGM_1(i,1)];
        
        % Transformation LNOF to EFRF
        
        % Creation of matrix for the rotation from LNOF to EFRF note that the lat lon and h refer to the position vextor in EFRF
        R_EFRF(1,1,i)=-sind(lat_1(i,1))*cosd(lon_1(i,1));
        R_EFRF(1,2,i)=-sind(lat_1(i,1))*sind(lon_1(i,1));
        R_EFRF(1,3,i)=cosd(lat_1(i,1));
        R_EFRF(2,1,i)=sind(lon_1(i,1));
        R_EFRF(2,2,i)=-cosd(lon_1(i,1));
        R_EFRF(2,3,i)=0;
        R_EFRF(3,1,i)=cosd(lat_1(i,1))*cosd(lon_1(i,1));
        R_EFRF(3,2,i)=cosd(lat_1(i,1))*sind(lon_1(i,1));
        R_EFRF(3,3,i)=sind(lat_1(i,1));
        
        % Computation of GGs in EFRF - since the rotation matrix R_EFRF
        % corresponds to the rotation from EFRF to LNOF, the equation is as
        % follows: Vefrf=R'*Vlnof*R:
        V_efrf_new_1=(R_EFRF(:,:,i)')*V_LNOF*R_EFRF(:,:,i);
        
        Vxx_efrf_new_1(i,1)=V_efrf_new_1(1,1);
        Vxy_efrf_new_1(i,1)=V_efrf_new_1(1,2);
        Vxz_efrf_new_1(i,1)=V_efrf_new_1(1,3);
        Vyy_efrf_new_1(i,1)=V_efrf_new_1(2,2);
        Vyz_efrf_new_1(i,1)=V_efrf_new_1(2,3);
        Vzz_efrf_new_1(i,1)=V_efrf_new_1(3,3);
        
        % Transformation EFRF to IRF
        
        % Creation of matrix for the rotation from EFRF to IRF
        R_IRF(1,1,i)=q1int_1(i,1)^2 - q2int_1(i,1)^2 - q3int_1(i,1)^2 + q4int_1(i,1)^2;
        R_IRF(1,2,i)=2*(q1int_1(i,1)*q2int_1(i,1) + q3int_1(i,1)*q4int_1(i,1));
        R_IRF(1,3,i)=2*(q1int_1(i,1)*q3int_1(i,1) - q2int_1(i,1)*q4int_1(i,1));
        R_IRF(2,1,i)=2*(q1int_1(i,1)*q2int_1(i,1) - q3int_1(i,1)*q4int_1(i,1));
        R_IRF(2,2,i)=-q1int_1(i,1)^2 + q2int_1(i,1)^2 - q3int_1(i,1)^2 + q4int_1(i,1)^2;
        R_IRF(2,3,i)=2*(q2int_1(i,1)*q3int_1(i,1) + q1int_1(i,1)*q4int_1(i,1));
        R_IRF(3,1,i)=2*(q1int_1(i,1)*q3int_1(i,1) + q2int_1(i,1)*q4int_1(i,1));
        R_IRF(3,2,i)=2*(q2int_1(i,1)*q3int_1(i,1) - q1int_1(i,1)*q4int_1(i,1));
        R_IRF(3,3,i)=-q1int_1(i,1)^2 - q2int_1(i,1)^2 + q3int_1(i,1)^2 + q4int_1(i,1)^2;
        
        % Computation of GGs in IRF - since the rotation matrix R_IFRF
        % corresponds to the rotation from EFRF to IRF, the equation is as
        % follows: Virf=R*Vefrf*R':
        V_IRF=R_IRF(:,:,i)*V_efrf_new_1*(R_IRF(:,:,i)');
        
        Vxx_IRF(i,1)=V_IRF(1,1);
        Vxy_IRF(i,1)=V_IRF(1,2);
        Vxz_IRF(i,1)=V_IRF(1,3);
        Vyy_IRF(i,1)=V_IRF(2,2);
        Vyz_IRF(i,1)=V_IRF(2,3);
        Vzz_IRF(i,1)=V_IRF(3,3);
        
        
        % Transformation IRF to GRF
        
        % Creation of matrix for the rotation from IRF to GRF
        R(1,1,i)=q1_new_1(i,1)^2 - q2_new_1(i,1)^2 - q3_new_1(i,1)^2 + q4_new_1(i,1)^2;
        R(1,2,i)=2*(q1_new_1(i,1)*q2_new_1(i,1) + q3_new_1(i,1)*q4_new_1(i,1));
        R(1,3,i)=2*(q1_new_1(i,1)*q3_new_1(i,1) - q2_new_1(i,1)*q4_new_1(i,1));
        R(2,1,i)=2*(q1_new_1(i,1)*q2_new_1(i,1) - q3_new_1(i,1)*q4_new_1(i,1));
        R(2,2,i)=-q1_new_1(i,1)^2 + q2_new_1(i,1)^2 - q3_new_1(i,1)^2 + q4_new_1(i,1)^2;
        R(2,3,i)=2*(q2_new_1(i,1)*q3_new_1(i,1) + q1_new_1(i,1)*q4_new_1(i,1));
        R(3,1,i)=2*(q1_new_1(i,1)*q3_new_1(i,1) + q2_new_1(i,1)*q4_new_1(i,1));
        R(3,2,i)=2*(q2_new_1(i,1)*q3_new_1(i,1) - q1_new_1(i,1)*q4_new_1(i,1));
        R(3,3,i)=-q1_new_1(i,1)^2 - q2_new_1(i,1)^2 + q3_new_1(i,1)^2 + q4_new_1(i,1)^2;
        
        % Computation of GGs in GRF - since the rotation matrix R
        % corresponds to the rotation from IRF to GRF, the equation is as
        % follows: Vgrf=R*Virf*R':
        V_GRF=R(:,:,i)*V_IRF*(R(:,:,i)');
        
        Vxx_GRF(i,1)=V_GRF(1,1);
        Vxy_GRF(i,1)=V_GRF(1,2);
        Vxz_GRF(i,1)=V_GRF(1,3);
        Vyy_GRF(i,1)=V_GRF(2,2);
        Vyz_GRF(i,1)=V_GRF(2,3);
        Vzz_GRF(i,1)=V_GRF(3,3);
        
    end
    
    %preallocations
    %
    VxxGRF=cell(length(Vxx_GGM),1);
    VxyGRF=cell(length(Vxx_GGM),1);
    VxzGRF=cell(length(Vxx_GGM),1);
    VyyGRF=cell(length(Vxx_GGM),1);
    VyzGRF=cell(length(Vxx_GGM),1);
    VzzGRF=cell(length(Vxx_GGM),1);
    
    VxxIRF=cell(length(Vxx_GGM),1);
    VxyIRF=cell(length(Vxx_GGM),1);
    VxzIRF=cell(length(Vxx_GGM),1);
    VyyIRF=cell(length(Vxx_GGM),1);
    VyzIRF=cell(length(Vxx_GGM),1);
    VzzIRF=cell(length(Vxx_GGM),1);
    
    Vxxefrf_new_1=cell(length(Vxx_GGM),1);
    Vxyefrf_new_1=cell(length(Vxx_GGM),1);
    Vxzefrf_new_1=cell(length(Vxx_GGM),1);
    Vyyefrf_new_1=cell(length(Vxx_GGM),1);
    Vyzefrf_new_1=cell(length(Vxx_GGM),1);
    Vzzefrf_new_1=cell(length(Vxx_GGM),1);
    
    % keep values
    VxxGRF{j,1}=Vxx_GRF;
    VxyGRF{j,1}=Vxy_GRF;
    VxzGRF{j,1}=Vxz_GRF;
    VyyGRF{j,1}=Vyy_GRF;
    VyzGRF{j,1}=Vyz_GRF;
    VzzGRF{j,1}=Vzz_GRF;
    
    VxxIRF{j,1}=Vxx_IRF;
    VxyIRF{j,1}=Vxy_IRF;
    VxzIRF{j,1}=Vxz_IRF;
    VyyIRF{j,1}=Vyy_IRF;
    VyzIRF{j,1}=Vyz_IRF;
    VzzIRF{j,1}=Vzz_IRF;
    
    Vxxefrf_new_1{j,1}=Vxx_efrf_new_1;
    Vxyefrf_new_1{j,1}=Vxy_efrf_new_1;
    Vxzefrf_new_1{j,1}=Vxz_efrf_new_1;
    Vyyefrf_new_1{j,1}=Vyy_efrf_new_1;
    Vyzefrf_new_1{j,1}=Vyz_efrf_new_1;
    Vzzefrf_new_1{j,1}=Vzz_efrf_new_1;
    %end
    
    % Creation of cells containing the Gravity Gradients for all loaded days in
    % GRF,IRF and EFRF
    
    Vxx_GRF=VxxGRF;
    Vxy_GRF=VxyGRF;
    Vxz_GRF=VxzGRF;
    Vyy_GRF=VyyGRF;
    Vyz_GRF=VyzGRF;
    Vzz_GRF=VzzGRF;
    
    Vxx_IRF=VxxIRF;
    Vxy_IRF=VxyIRF;
    Vxz_IRF=VxzIRF;
    Vyy_IRF=VyyIRF;
    Vyz_IRF=VyzIRF;
    Vzz_IRF=VzzIRF;
    
    %Vxx_efrf_new_1=Vxxefrf_new_1;
    %Vxy_efrf_new_1=Vxyefrf_new_1;
    %Vxz_efrf_new_1=Vxzefrf_new_1;
    %Vyy_efrf_new_1=Vyyefrf_new_1;
    %Vyz_efrf_new_1=Vyzefrf_new_1;
    %Vzz_efrf_new_1=Vzzefrf_new_1;
    
    % Save GGs
    % in GRF
    GGM_LNOF_2_GRF1{6,1}=Vxx_GRF;
    GGM_LNOF_2_GRF1{7,1}=Vyy_GRF;
    GGM_LNOF_2_GRF1{8,1}=Vzz_GRF;
    GGM_LNOF_2_GRF1{9,1}=Vxy_GRF;
    GGM_LNOF_2_GRF1{10,1}=Vxz_GRF;
    GGM_LNOF_2_GRF1{11,1}=Vyz_GRF;
    
    % in IRF
    GGM_LNOF_2_GRF1{12,1}=Vxx_IRF;
    GGM_LNOF_2_GRF1{13,1}=Vyy_IRF;
    GGM_LNOF_2_GRF1{14,1}=Vzz_IRF;
    GGM_LNOF_2_GRF1{15,1}=Vxy_IRF;
    GGM_LNOF_2_GRF1{16,1}=Vxz_IRF;
    GGM_LNOF_2_GRF1{17,1}=Vyz_IRF;
    
    % in EFRF
    GGM_LNOF_2_GRF1{18,1}=Vxxefrf_new_1;
    GGM_LNOF_2_GRF1{19,1}=Vyyefrf_new_1;
    GGM_LNOF_2_GRF1{20,1}=Vzzefrf_new_1;
    GGM_LNOF_2_GRF1{21,1}=Vxyefrf_new_1;
    GGM_LNOF_2_GRF1{22,1}=Vxzefrf_new_1;
    GGM_LNOF_2_GRF1{23,1}=Vyzefrf_new_1;
    
    % in LNOF
    GGM_LNOF_2_GRF1{24,1}=Vxx_GGM;
    GGM_LNOF_2_GRF1{25,1}=Vyy_GGM;
    GGM_LNOF_2_GRF1{26,1}=Vzz_GGM;
    GGM_LNOF_2_GRF1{27,1}=Vxy_GGM;
    GGM_LNOF_2_GRF1{28,1}=Vxz_GGM;
    GGM_LNOF_2_GRF1{29,1}=Vyz_GGM;
    
    % needs for plots
    GGM_LNOF_2_GRF1{2,1}=lon;
    GGM_LNOF_2_GRF1{1,1}= lat;
    GGM_LNOF_2_GRF1{3,1}= h;
    GGM_LNOF_2_GRF1{4,1}= time_utc_nom_fractional_new;
    GGM_LNOF_2_GRF1{5,1}= name_current_day;
    
    GGM_LNOF_2_GRF1{30,1}=q1_new;
    GGM_LNOF_2_GRF1{31,1}=q2_new;
    GGM_LNOF_2_GRF1{32,1}=q3_new;
    GGM_LNOF_2_GRF1{33,1}=q4_new;
    GGM_LNOF_2_GRF1{34,1}=q1int;
    GGM_LNOF_2_GRF1{35,1}=q2int;
    GGM_LNOF_2_GRF1{36,1}=q3int;
    GGM_LNOF_2_GRF1{37,1}=q4int;
end
end