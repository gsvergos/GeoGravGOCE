function [Vij_FIR,test,N1,b1] = FIR(z,currentFolder)
%    GeoGravGOCE project
%    Initial code of FIR filtering: X. Oikonomidou
%    E. Mamagiannou, D. Natsiopoulos
%    GravLab, AUTh, 7/3/2020

%    ---------------------------------------------------------------------------------------------
%    INFO
%    The function creates a FIR filter with N order
%    and then filters the Vij.

%    *** input ***
%    z = {6x1} cells = reduced Vij data ready for filtering
%    the format of z.mat:
%    1st cell = Vxx
%    2nd cell = Vyy
%    3rd cell = Vzz
%    4th cell = Vxy
%    5th cell = Vxy
%    6th cell = Vyz
%    currentFolder = the current working folder (you can identify it with "pwd")

%    *** output ***
%    Vij_FIR = {6x1} cells = your reduced filtered data
%    the format of Vij_FIR.mat:
%    1st cell = Vxx filtered
%    2nd cell = Vyy filtered
%    3rd cell = Vzz filtered
%    4th cell = Vxy filtered
%    5th cell = Vxy filtered
%    6th cell = Vyz filtered
%    test = a figure / for the dispay panel in the GUI
%    N1 = N-coefficients = the order of FIR filter / is needed in the GUI for further actions
%    b1 = the Window-based FIR filter design / is needed in the GUI for further actions
%    ------------------------------------------------------------------------------------------------

%% make a folder to save the output
p = 1;
foldername = sprintf('FIR%02',p);
mkdir(currentFolder, foldername);
currentFolder2=[currentFolder, '\FIR\Vij_FIR.mat'];
currentFolder3=[currentFolder, '\FIR\Vij_FIR_Report'];

%% (1)--- classification ---
% z = data_for_filtering
lon = z{7,1};
lat = z{8,1};
h = z{9,1};
% Gravity Gradients
Vxx_new = z{1,1};
Vyy_new = z{2,1};
Vzz_new = z{3,1};
Vxy_new = z{4,1};
Vxz_new = z{5,1};
Vyz_new = z{6,1};
name_current_day = z{11,1}; %needed for plots
% counters
k=0; % counter all ok/ check
q=0; % counter all ok/ check


%% (2)--- FIR bandpass Filter ---
% frequency specifications
T_s=1;  % the sampling period (for GOCE the sampling period = 1 sec)
F_s=1/T_s;
F_Nyq=F_s/2; % Nyquist frequency

% GOCE Measurement BandWidth (MBW)
F_pass1=0.005; %Hz
F_pass2=0.1;  % Hz

%pandpass sample
F_pass1_n=F_pass1/F_Nyq;
F_pass2_n=F_pass2/F_Nyq;

% fir1 design an nth-order multiband FIR filter
% and uses a Hamming window
% user input
Message = sprintf('Please, enter a value for N-coefficients of FIR filter. \n\nSuggested (20 < coefficients < 2000) \n');
dlgtitle = 'Input filter order (N)';
definput = {'1500'}; % default
opts.Interpreter = 'tex';
answer = inputdlg(Message,dlgtitle,[1 60],definput,opts);

% check the user's answer
while (q==0)
    if isempty(answer)==1
        k=1; % cancel button checked
        disp('The FIR cancel button was selected.')
        q=1;
    else
        N1 = str2num(answer{1}); % converts the character array or string scalar to a numeric
        if (isempty(N1)==1)
            Message = sprintf('Invalid N-value. \nPlease, re-enter a value for N-coefficients of FIR filter. \n\nSuggested (20 < coefficients < 2000) \n');
            dlgtitle = 'Input filter order (N)';
            definput = {'1500'}; % default
            opts.Interpreter = 'tex';
            answer = inputdlg(Message,dlgtitle,[1 60],definput,opts);
        else
            q=1; % counter
        end
    end
end


if k==0
    N=N1 +0; % coefficients
    win=hamming(N);
    b1=fir1(N-1,[F_pass1_n F_pass2_n],'bandpass',win,'scale');
    
    for i=1:length(Vxx_new)
        % filtfilt(b,a,x)= performs zero-phase digital filtering by processing the input data, x,
        % minimizes start-up and ending transients by matching initial conditions.
        % b, a = Transfer function coefficients, specified as vectors.
        % If you use an all-pole filter, enter 1 for b.
        % If you use an all-zero (FIR) filter, enter 1 for a.
        Vxx_filt_FIR{i,1}=filtfilt(b1,1,Vxx_new{i});
        Vyy_filt_FIR{i,1}=filtfilt(b1,1,Vyy_new{i});
        Vzz_filt_FIR{i,1}=filtfilt(b1,1,Vzz_new{i});
        Vxy_filt_FIR{i,1}=filtfilt(b1,1,Vxy_new{i});
        Vxz_filt_FIR{i,1}=filtfilt(b1,1,Vxz_new{i});
        Vyz_filt_FIR{i,1}=filtfilt(b1,1,Vyz_new{i});
    end
    
    %% (3)--- Trandformation ---
    % transform the filtered Vij from GRF to LNOF
    if length(z)==19 % if only option 2 (load data)
        % required input for transformations
        datagrftolnoffiltered{1,:}= lat;            %lat
        datagrftolnoffiltered{2,:}= lon;            %lon
        datagrftolnoffiltered{3,:}= h;              %h
        datagrftolnoffiltered{4,:}= z{10};          %UTC time
        datagrftolnoffiltered{5,:}= z{11};          % name current day
        datagrftolnoffiltered{6,:}= Vxx_filt_FIR;   % Vxx in GRF
        datagrftolnoffiltered{7,:}= Vyy_filt_FIR;   % Vyy in GRF
        datagrftolnoffiltered{8,:}= Vzz_filt_FIR;   % Vzz in GRF
        datagrftolnoffiltered{9,:}= Vxy_filt_FIR;   % Vxy in GRF
        datagrftolnoffiltered{10,:}= Vxz_filt_FIR;  % Vxz in GRF
        datagrftolnoffiltered{11,:}= Vyz_filt_FIR;  % Vyz in GRF
        datagrftolnoffiltered{12,:}= z{12};         % q1 (IRF - GRF)
        datagrftolnoffiltered{13,:}= z{13};         % q2 (IRF - GRF)
        datagrftolnoffiltered{14,:}= z{14};         % q3 (IRF - GRF)
        datagrftolnoffiltered{15,:}= z{15};         % q4 (IRF - GRF)
        datagrftolnoffiltered{16,:}= z{16};         % q1 (EFRF-IRF)
        datagrftolnoffiltered{17,:}= z{17};         % q2 (EFRF-IRF)
        datagrftolnoffiltered{18,:}= z{18};         % q3 (EFRF-IRF)
        datagrftolnoffiltered{19,:}= z{19};         % q4 (EFRF-IRF)
        
        % transformations
        [VIRFfiltgradients] = gradients_to_irf_filtered(datagrftolnoffiltered); % to IRF
        [VEFRFfiltgradients] = gradients_to_efrf_filtered(VIRFfiltgradients); % to EFRF
        [VLNOF_gradients_filt] = gradients_to_lnof_filtered(VEFRFfiltgradients); % to LNOF
    end
    
    
    %% (4) ---save the filtered data & the corresponding report ---
    if length(z)==19
        Vij_FIR{1,1}=lat; % lat
        Vij_FIR{2,1}=lon; %lon
        Vij_FIR{3,1}=h; %h
        Vij_FIR{4,1}=z{10}; % UTC time
        Vij_FIR{5,1}=Vxx_filt_FIR; % Vxx -filtered -GRF
        Vij_FIR{6,1}=Vyy_filt_FIR; % Vyy -filtered -GRF
        Vij_FIR{7,1}=Vzz_filt_FIR; % Vzz -filtered -GRF
        Vij_FIR{8,1}=Vxy_filt_FIR; % Vxy -filtered -GRF
        Vij_FIR{9,1}=Vxz_filt_FIR; % Vxz -filtered -GRF
        Vij_FIR{10,1}=Vyz_filt_FIR; % Vyz -filtered -GRF
        Vij_FIR{11,1}=VLNOF_gradients_filt{6}; % Vxx -filtered -LNOF
        Vij_FIR{12,1}=VLNOF_gradients_filt{7}; % Vxx -filtered -LNOF
        Vij_FIR{13,1}=VLNOF_gradients_filt{8}; % Vxx -filtered -LNOF
        Vij_FIR{14,1}=VLNOF_gradients_filt{9}; % Vxx -filtered -LNOF
        Vij_FIR{15,1}=VLNOF_gradients_filt{10}; % Vxx -filtered -LNOF
        Vij_FIR{16,1}=VLNOF_gradients_filt{11}; % Vxx -filtered -LNOF
        % save (.mat)
        save(currentFolder2,'Vij_FIR');
        
        % the corresponding report (.txt)
        report=' ';
        report =[report, newline 'The format of the output "Vij_FIR.mat": '];
        report =[report, newline 'cells:'];
        report =[report, newline 'Vij_FIR{1} = latitude (degrees)'];
        report =[report, newline 'Vij_FIR{2} = longtitude (degrees)'];
        report =[report, newline 'Vij_FIR{3} = altitude (meters)'];
        report =[report, newline 'Vij_FIR{4} = UTC (time)'];
        report =[report, newline ' '];
        report =[report, newline 'Vij_FIR{5} = Vxx filtered in GRF (Eötvös)'];
        report =[report, newline 'Vij_FIR{6} = Vyy filtered in GRF (Eötvös)'];
        report =[report, newline 'Vij_FIR{7} = Vzz filtered in GRF (Eötvös)'];
        report =[report, newline 'Vij_FIR{8} = Vxy filtered in GRF (Eötvös)'];
        report =[report, newline 'Vij_FIR{9} = Vxz filtered in GRF (Eötvös)'];
        report =[report, newline 'Vij_FIR{10} = Vzy filtered in GRF (Eötvös)'];
        report =[report, newline ' '];
        report =[report, newline 'Vij_FIR{11} = Vxx filtered in LNOF (Eötvös)'];
        report =[report, newline 'Vij_FIR{12} = Vyy filtered in LNOF  (Eötvös)'];
        report =[report, newline 'Vij_FIR{13} = Vzz filtered in LNOF  (Eötvös)'];
        report =[report, newline 'Vij_FIR{14} = Vzy filtered in LNOF  (Eötvös)'];
        report =[report, newline 'Vij_FIR{15} = Vzy filtered in LNOF  (Eötvös)'];
        report =[report, newline 'Vij_FIR{16} = Vzy filtered in LNOF  (Eötvös)'];
        report =[report, newline ' '];
        report =[report, newline 'each of the 16 cells contains N interiors cells, N= number of the files you processed in the GUI.'];
        dlmwrite (currentFolder3,report,'delimiter','');
    else
        Vij_FIR{1,1}=lat; % lat
        Vij_FIR{2,1}=lon; %lon
        Vij_FIR{3,1}=h; %h
        Vij_FIR{4,1}=z{10}; % UTC time
        Vij_FIR{5,1}=Vxx_filt_FIR; % Vxx -filtered -GRF
        Vij_FIR{6,1}=Vyy_filt_FIR; % Vyy -filtered -GRF
        Vij_FIR{7,1}=Vzz_filt_FIR; % Vzz -filtered -GRF
        Vij_FIR{8,1}=Vxy_filt_FIR; % Vxy -filtered -GRF
        Vij_FIR{9,1}=Vxz_filt_FIR; % Vxz -filtered -GRF
        Vij_FIR{10,1}=Vyz_filt_FIR; % Vyz -filtered -GRF
        % save (.mat)
        save(currentFolder2,'Vij_FIR');
        
        % the corresponding report (.txt)
        report=' ';
        report =[report, newline 'The format of the output "Vij_FIR.mat": '];
        report =[report, newline 'cells:'];
        report =[report, newline 'Vij_FIR{1} = latitude (degrees)'];
        report =[report, newline 'Vij_FIR{2} = longtitude (degrees)'];
        report =[report, newline 'Vij_FIR{3} = altitude (meters)'];
        report =[report, newline 'Vij_FIR{4} = UTC (time)'];
        report =[report, newline 'Vij_FIR{5} = Vxx filtered in GRF (Eötvös)'];
        report =[report, newline 'Vij_FIR{6} = Vyy filtered in GRF (Eötvös)'];
        report =[report, newline 'Vij_FIR{7} = Vzz filtered in GRF (Eötvös)'];
        report =[report, newline 'Vij_FIR{8} = Vxy filtered in GRF (Eötvös)'];
        report =[report, newline 'Vij_FIR{9} = Vxz filtered in GRF (Eötvös)'];
        report =[report, newline 'Vij_FIR{10} = Vzy filtered in GRF (Eötvös)'];
        report =[report, newline ' '];
        report =[report, newline 'each of the 16 cells contains N interiors cells, N= number of the files you processed in the GUI.'];
        dlmwrite (currentFolder3,report,'delimiter','');
    end
    % message for user
    Opt.Interpreter = 'tex';
    Opt.WindowStyle = 'normal';
    msgbox({'Your results were saved in the new "FIR" folder.';'';' Check them!'}, 'End of processing', 'help', Opt);
    
    
    %% (4)---display/ figures for GUI/---
    
    % --- PSD  ---
    %MBW limits
    x1=[0.005 0.005];
    x2=[0.1 0.1];
    y1=[10^(-20) 10^(10)];
    T_s = 1; % the sampling period (for GOCE the sampling period = 1 sec)
    
    test = figure('visible','off');
    i=1; %counter
    
    %***Vzz***
    [freq_FIR,power_FIR] = f_normalized_psd(Vzz_filt_FIR{i},T_s);
    [freq_unfilt,power_unfilt] = f_normalized_psd(Vzz_new{i},T_s);
    
    p(1,1)= semilogy(freq_unfilt(1:end/2),power_unfilt(1:end/2),'Color',[0.62 0.93 0.71]);
    hold on;
    p(2,1)=semilogy(freq_FIR(1:end/2),power_FIR(1:end/2),'Color',[0.6350 0.0780 0.1840]);
    
    % MBW limits
    hold on;
    plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0]);
    hold on;
    plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0]);
    hold off;
    
    % legend
    legend('PSD Vzz unfiltered','PSD Vzz FIR');
    lgd = legend;
    lgd.FontSize = 12;
    %lgd.ItemTokenSize = [40,25];
    lgd.Location= ('southwest');
    
    % Arrow with two head at both end and text between
    y = [0.76 0.76];
    x = [0.69 0.75];      % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
    annotation('textarrow',x,y,'String','  MBW','FontSize' ,12,'FontSize',12,'Linewidth',1)
    x = [0.61 0.55];
    annotation('textarrow',x,y,'FontSize',10,'Linewidth',1)
    
    % log scale
    set(gca,'YScale','log','XScale','log');
    grid on;
    axis([10^(-5),10^(0),10^(-7),10^(2)]);
    
    %axis labels
    xlabel('Frequency (Hz) ','fontsize',16);
    ylabel('Power Spectral Density ','fontsize',16);
    
    % title
    a=name_current_day{i,1}(i);
    DateString = datestr( a );
    %DateString = datestr( a,'mmm-yyyy' ); % needs for title
    title({['\bf\fontsize{16}PSD - Filtered Vzz - GRF (FIR, N=', num2str(N1),')'] ;num2str(DateString)})
    
else
    % message for user
    Opt.Interpreter = 'tex';
    Opt.WindowStyle = 'normal';
    msgbox({'You have pressed the FIR cancel button.'}, 'FIR', 'help', Opt);
    
    % to avoid output problems
    Vij_FIR=[];
    test=[];
    N1=[];
    b1=[];
end
end

