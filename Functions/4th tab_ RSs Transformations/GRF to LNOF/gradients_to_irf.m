function [ VIRFgradients] = gradients_to_irf(datagrftolnof1)
%   GeoGravGOCE project
%   E. Pitenis
%   GravLab, AUTh, 20/2/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function for the transformation of gravity gradients from GRF to IRF
%   ----------------------------------------------------------------------------------------
%%  Load data for the GRF to IRF transformation
lat=datagrftolnof1{1,1};
lon=datagrftolnof1{2,1};
h=datagrftolnof1{3,1};
Vxx_new = datagrftolnof1{6,1};
Vyy_new = datagrftolnof1{7,1};
Vzz_new =datagrftolnof1{8,1};
Vxy_new = datagrftolnof1{9,1};
Vxz_new = datagrftolnof1{10,1};
Vyz_new = datagrftolnof1{11,1};
time_utc_nom_fractional_new = datagrftolnof1{4,1};
name_current_day = datagrftolnof1{5,1};
q1_new=datagrftolnof1{12,1};
q2_new=datagrftolnof1{13,1};
q3_new=datagrftolnof1{14,1};
q4_new=datagrftolnof1{15,1};
q1int=datagrftolnof1{16,1};
q2int=datagrftolnof1{17,1};
q3int=datagrftolnof1{18,1};
q4int=datagrftolnof1{19,1};

%   preallocations
Vxxirf=cell(length(lon),1);
Vxyirf=cell(length(lon),1);
Vxzirf=cell(length(lon),1);
Vyyirf=cell(length(lon),1);
Vyzirf=cell(length(lon),1);
Vzzirf=cell(length(lon),1);

% transformations
for j=1:length(lon)
    Vxx_new_1=Vxx_new{j,1};
    Vyy_new_1=Vyy_new{j,1};
    Vzz_new_1=Vzz_new{j,1};
    Vxy_new_1=Vxy_new{j,1};
    Vxz_new_1=Vxz_new{j,1};
    Vyz_new_1=Vyz_new{j,1};
    q1_new_1=q1_new{j,1};
    q2_new_1=q2_new{j,1};
    q3_new_1=q3_new{j,1};
    q4_new_1=q4_new{j,1};
    
    % preallocation
    R=zeros(3,3,length(q1_new_1));
    
    % creation of rotation R matrix
    for i=1:length(q1_new_1)
        R(1,1,i)=q1_new_1(i,1)^2-q2_new_1(i,1)^2-q3_new_1(i,1)^2+q4_new_1(i,1)^2;
        R(1,2,i)=2*(q1_new_1(i,1)*q2_new_1(i,1)+q3_new_1(i,1)*q4_new_1(i,1));
        R(1,3,i)=2*(q1_new_1(i,1)*q3_new_1(i,1)-q2_new_1(i,1)*q4_new_1(i,1));
        R(2,1,i)=2*(q1_new_1(i,1)*q2_new_1(i,1)-q3_new_1(i,1)*q4_new_1(i,1));
        R(2,2,i)=-q1_new_1(i,1)^2+q2_new_1(i,1)^2-q3_new_1(i,1)^2+q4_new_1(i,1)^2;
        R(2,3,i)=2*(q2_new_1(i,1)*q3_new_1(i,1)+q1_new_1(i,1)*q4_new_1(i,1));
        R(3,1,i)=2*(q1_new_1(i,1)*q3_new_1(i,1)+q2_new_1(i,1)*q4_new_1(i,1));
        R(3,2,i)=2*(q2_new_1(i,1)*q3_new_1(i,1)-q1_new_1(i,1)*q4_new_1(i,1));
        R(3,3,i)=-q1_new_1(i,1)^2-q2_new_1(i,1)^2+q3_new_1(i,1)^2+q4_new_1(i,1)^2;
    end
    
    % Creation of the VGRF matrix
    L1=length(Vxx_new_1);
    VGRF=zeros(3,3,L1);
    VGRF(1,1,:)=Vxx_new_1;
    VGRF(1,2,:)=Vxy_new_1;
    VGRF(1,3,:)=Vxz_new_1;
    VGRF(2,1,:)=Vxy_new_1;
    VGRF(2,2,:)=Vyy_new_1;
    VGRF(2,3,:)=Vyz_new_1;
    VGRF(3,1,:)=Vxz_new_1;
    VGRF(3,2,:)=Vyz_new_1;
    VGRF(3,3,:)=Vzz_new_1;
    
    % Creation of the VIRF matrix
    
    L3=length(q1_new_1);
    VIRF=zeros(3,3,L3);
    for i=1:length(Vxx_new_1)
        VIRF(:,:,i)=(R(:,:,i)')*VGRF(:,:,i)*R(:,:,i);
    end
    
    % Extraction OF THE VIRF matrix components
    VxxIRF=VIRF(1,1,:);
    %VxyIRF=VIRF(1,2,:);
    %VxzIRF=VIRF(1,3,:);
    VxyIRF=VIRF(2,1,:);
    VyyIRF=VIRF(2,2,:);
    %VyzIRF=VIRF(2,3,:);
    VxzIRF=VIRF(3,1,:);
    VyzIRF=VIRF(3,2,:);
    VzzIRF=VIRF(3,3,:);
    
    VxxIRF=reshape(VxxIRF,[length(Vxx_new_1),1]);
    VxyIRF=reshape(VxyIRF,[length(Vxx_new_1),1]);
    VxzIRF=reshape(VxzIRF,[length(Vxx_new_1),1]);
    VyyIRF=reshape(VyyIRF,[length(Vxx_new_1),1]);
    VyzIRF=reshape(VyzIRF,[length(Vxx_new_1),1]);
    VzzIRF=reshape(VzzIRF,[length(Vxx_new_1),1]);
    
    % Save each iteration in a cell
    Vxxirf{j,1}=VxxIRF;
    Vxyirf{j,1}=VxyIRF;
    Vxzirf{j,1}=VxzIRF;
    Vyyirf{j,1}=VyyIRF;
    Vyzirf{j,1}=VyzIRF;
    Vzzirf{j,1}=VzzIRF;
end

VxxIRF=Vxxirf;
VxyIRF=Vxyirf;
VxzIRF=Vxzirf;
VyyIRF=Vyyirf;
VyzIRF=Vyzirf;
VzzIRF=Vzzirf;

VIRFgradients{1,1}=lat;
VIRFgradients{2,1}=lon;
VIRFgradients{3,1}=h;
VIRFgradients{4,1}=time_utc_nom_fractional_new;
VIRFgradients{5,1}=name_current_day;
VIRFgradients{6,1}=VxxIRF;
VIRFgradients{7,1}=VyyIRF;
VIRFgradients{8,1}=VzzIRF;
VIRFgradients{9,1}=VxyIRF;
VIRFgradients{10,1}=VxzIRF;
VIRFgradients{11,1}=VyzIRF;
VIRFgradients{12,1}=q1_new;
VIRFgradients{13,1}=q2_new;
VIRFgradients{14,1}=q3_new;
VIRFgradients{15,1}=q4_new;
VIRFgradients{16,1}=q1int;
VIRFgradients{17,1}=q2int;
VIRFgradients{18,1}=q3int;
VIRFgradients{19,1}=q4int;
end