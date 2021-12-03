function [lat,lon,h] = XYZ_2_flh(X_inter, Y_inter, Z_inter)
%    GeoGravGOCE
%    GravLab, AUTh, 2020
%    Mamagiannou E., Pitenis E.

%    ------------------------------------------------------------------------------------------------
%    INFO
%    the function converts cartesian coords (GOCE data (X,Y,Z)_EFRF) to (lon,lat,h)
%    reference ellipsoid (GRS80)
%    Fotiou' method - methodos upsous (1998)

%    *** input ***
%    X = coordinates in meters (PSO_2.kin) (column vector)
%    Y = coordinates in meters (PSO_2.kin) (column vector)
%    Z = coordinates in meters (PSO_2.kin) (column vector)

%    *** output ***
%    the function returns LAT and LON in degrees and ALTITUDE in meters.

%    (WGS84 parameters)
%    a=6378137; %(m)
%    b=6356752.3142;
%    f=0.00335281068;
%    ek=0.0066943799; %e^2 = first eccentricity squared
%    ek1=0.0067394964; %e'^2
%    ------------------------------------------------------------------------------------------------

%% GRS80 parameters
a = 6378137;
b = 6356752.3141;
f = 0.00335281068;
ek = 0.00669438; %e^2
ek1 = 0.006739497; %e'^2

% initiallize: LAT and h
lat={};
h={};

for i=1:length(X_inter)
    P=sqrt(X_inter{i}.^2+Y_inter{i}.^2);
    fo=atan(Z_inter{i}.*(1+(ek1))./P); % initiallize the Lat
    W=sqrt(1-(ek).*(sin(fo).^2));
    No=a./W;
    ho=(Z_inter{i}./sin(fo))-((1-ek).*No);
    Po=(No+ho).*cos(fo);
    h1=ho+(P-Po).*cos(fo); % altitude
    fo=atan(tan(fo)./(1+(ek1).*(h1./(No+h1))));
    
    % need 2 iterations
    for j=1:2
        fo=atan((Z_inter{i}+ek.*No.*sin(fo))./P);
    end
    
    % convert rad to degrees
    lat{i,1}=fo.*180./pi; % degrees
    h{i,1}=h1;
end

%% LON (0<lon<360)
lon={};
for i=1:length(X_inter)
    
    for j=1:length(X_inter{i})
        Lon=atan(abs(Y_inter{i}(j)./X_inter{i}(j)));
        if Y_inter{i}(j)>0
            if X_inter{i}(j)>0
                Lon=Lon;
            elseif X_inter{i}(j)==0
                Lon=pi/2;
            elseif X_inter{i}(j)<0
                Lon=pi-Lon;
            end
            
        elseif Y_inter{i}(j)<0
            if X_inter{i}(j)>0
                Lon=2*pi-Lon;
            elseif X_inter{i}(j)==0
                Lon=3*pi/2;
            elseif X_inter{i}(j)<0
                Lon=pi+Lon;
            end
            
        elseif Y_inter{i}(j)==0
            if X_inter{i}(j)>0
                Lon=0;
            elseif X_inter{i}(j)==0
                disp('Undefined');
            elseif X_inter{i}(j)<0
                Lon=pi;
            end
        end
        ll(j,1)=Lon;
        clear Lon
    end
    
    % convert rad to degrees/  reduction -180<lon<180
    lon{i,1}=(ll.*180./pi); % degrees
    for j=1:length(X_inter{i})
        if lon{i}(j)>180
            lon{i}(j)=lon{i}(j)-360;
        end
    end
    clear ll
end
end

