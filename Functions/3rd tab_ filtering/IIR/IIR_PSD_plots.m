function [k] = IIR_PSD_plots(z, Vij_IIR,N2,currentFolder)
%    GeoGravGOCE project
%    E. Mamagiannou, D. Natsiopoulos
%    GravLab, AUTh, 7/3/2020

%    ---------------------------------------------------------------------------------------------
%    INFO
%    *** function for plotting the PSDs after IIR filtering ***

%    *** input ***
%    [input = the "IIR" function's output]
%    z = {6x1} cells =  data before the filtering
%    the format of z.mat:
%    1st cell = Vxx unfiltered
%    2nd cell = Vyy unfiltered
%    3rd cell = Vzz unfiltered
%    4th cell = Vxy unfiltered
%    5th cell = Vxy unfiltered
%    6th cell = Vyz unfiltered
%
%    Vij_FIR = {6x1} cells = the filtered data
%    the format of Vij_IIR.mat:
%    1st cell = Vxx filtered
%    2nd cell = Vyy filtered
%    3rd cell = Vzz filtered
%    4th cell = Vxy filtered
%    5th cell = Vxy filtered
%    6th cell = Vyz filtered
%
%    N2 = N-coefficients = the order of IIR filter / is needed in the GUI for further actions
%    currentFolder =  the current working folder (you can identify it with "pwd")

%    *** output ***
%    k = counter =0,1/ is needed for checks in GUI
%    PSD_GG_GRF_IIR_NumCoefficients_date.fig (automatically saved)
%    PSD_GG_GRF_IIR_NumCoefficients_date.jpeg (automatically saved)
%    ------------------------------------------------------------------------------------------------

%% (1) initiallize the data
% (1a) the unfiltered data, z = users initial data
Vxx_new = z{1,1};
Vyy_new = z{2,1};
Vzz_new = z{3,1};
Vxy_new = z{4,1};
Vxz_new = z{5,1};
Vyz_new = z{6,1};
name_current_day = z{11,1};

% (1b) the filtered data
Vxx_filt_IIR=Vij_IIR{5};
Vyy_filt_IIR=Vij_IIR{6};
Vzz_filt_IIR=Vij_IIR{7};
Vxy_filt_IIR=Vij_IIR{8};
Vxz_filt_IIR=Vij_IIR{9};
Vyz_filt_IIR=Vij_IIR{10};

% (2) make a folder to save the figures (.jpeg) "PSD_GG_GRF_IIR_%s_%s"
p = 1;
foldername = sprintf('PSD IIR filtered Vij GRF%02',p);
currentFolder1=[currentFolder, '\IIR'];
mkdir(currentFolder1, foldername);
currentFolder2=[currentFolder, '\IIR\PSD IIR filtered Vij GRF'];


%% (3) PSD plot
% MBW limits/ for dashed lines
x1=[0.005 0.005];
x2=[0.1 0.1];
y1=[10^(-20) 10^(10)];
% the sampling period (GOCE sampling period = 1 sec)
T_s = 1;

% the figures:
for i=1:length(Vyz_filt_IIR)
    f=figure('visible','off');
    
    % ----- *Vxx* -----
    subplot(2,3,1)
    [freq_IIR,power_FIR] = f_normalized_psd(Vxx_filt_IIR{i},T_s);
    [freq_unfilt,power_unfilt] = f_normalized_psd(Vxx_new{i},T_s);
    
    p(1,1)= semilogy(freq_unfilt(1:end/2),power_unfilt(1:end/2),'Color',[0 1 1]);
    hold on;
    p(2,1)= semilogy(freq_IIR(1:end/2),power_FIR(1:end/2),'Color',[0 0.1 0.9]);
    
    % MBW limits
    hold on;
    plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0]);
    hold on;
    plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0]);
    hold off;
    
    % legend
    legend('PSD Vxx unfiltered','PSD Vxx IIR');
    lgd = legend;
    lgd.FontSize = 12;
    %lgd.ItemTokenSize = [40,25];
    lgd.Location= ('northwest');
    
    % Arrow with two head at both end and text between
    y = [0.61 0.61];
    x = [0.285 0.3];      % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
    annotation('textarrow',x,y,'String',' MBW ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1);
    x = [0.2630 0.248];
    annotation('textarrow',x,y,'FontSize',10,'Linewidth',1);
    
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
    title({['\bf\fontsize{18}PSD - Filtered Vxx - GRF (IIR, N=', num2str(N2),')'] ;num2str(DateString)});
    
    
    % ----- *Vyy* -----
    subplot(2,3,2)
    [freq_IIR,power_FIR] = f_normalized_psd(Vyy_filt_IIR{i},T_s);
    [freq_unfilt,power_unfilt] = f_normalized_psd(Vyy_new{i},T_s);
    
    p(1,1)= semilogy(freq_unfilt(1:end/2),power_unfilt(1:end/2),'Color',[0 1 1]);
    hold on;
    p(2,1)= semilogy(freq_IIR(1:end/2),power_FIR(1:end/2),'Color',[0.6350 0.0780 0.1840]);
    
    % MBW limits
    hold on;
    plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0]);
    hold on;
    plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0]);
    hold off;
    
    % legend
    legend('PSD Vyy unfiltered','PSD Vyy IIR');
    lgd = legend;
    lgd.FontSize = 12;
    %lgd.ItemTokenSize = [40,25];
    lgd.Location= ('northwest');
    
    % Arrow with two head at both end and text between
    y = [0.61 0.61];
    x = [0.5650 0.58];      % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
    annotation('textarrow',x,y,'String',' MBW ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1);
    x = [0.5430 0.528];
    annotation('textarrow',x,y,'FontSize',10,'Linewidth',1);
    
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
    title({['\bf\fontsize{18}PSD - Filtered Vyy - GRF (IIR, N=', num2str(N2),')'] ;num2str(DateString)});
    
    
    % -----*Vzz* -----
    subplot(2,3,3)
    [freq_IIR,power_FIR] = f_normalized_psd(Vzz_filt_IIR{i},T_s);
    [freq_unfilt,power_unfilt] = f_normalized_psd(Vzz_new{i},T_s);
    
    p(1,1)= semilogy(freq_unfilt(1:end/2),power_unfilt(1:end/2),'Color',[0 1 1]);
    hold on;
    p(2,1)= semilogy(freq_IIR(1:end/2),power_FIR(1:end/2),'Color',[0.8500 0.3250 0.0980]);
    
    % MBW limits
    hold on;
    plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0]);
    hold on;
    plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0]);
    hold off;
    
    % legend
    legend('PSD Vzz unfiltered','PSD Vzz IIR');
    lgd = legend;
    lgd.FontSize = 12;
    %lgd.ItemTokenSize = [40,25];
    lgd.Location= ('northwest');
    
    
    % Arrow with two head at both end and text between
    y = [0.61 0.61];
    x = [0.845 0.86];      % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
    annotation('textarrow',x,y,'String',' MBW ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1);
    x = [0.823 0.8080];
    annotation('textarrow',x,y,'FontSize',10,'Linewidth',1);
    
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
    title({['\bf\fontsize{18}PSD - Filtered Vzz - GRF (IIR, N=', num2str(N2),')'] ;num2str(DateString)});
    
    
    % ----- *Vxy* -----
    subplot(2,3,4)
    [freq_IIR,power_FIR] = f_normalized_psd(Vxy_filt_IIR{i},T_s);
    [freq_unfilt,power_unfilt] = f_normalized_psd(Vxy_new{i},T_s);
    
    p(1,1)= semilogy(freq_unfilt(1:end/2),power_unfilt(1:end/2),'Color',[0 1 1]);
    hold on;
    p(2,1)= semilogy(freq_IIR(1:end/2),power_FIR(1:end/2),'Color',[0.4940 0.1840 0.5560]);
    
    % MBW limits
    hold on;
    plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0]);
    hold on;
    plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0]);
    hold off;
    
    % legend
    legend('PSD Vxy unfiltered','PSD Vxy IIR');
    lgd = legend;
    lgd.FontSize = 12;
    %lgd.ItemTokenSize = [40,25];
    lgd.Location= ('northwest');
    
    % Arrow with two head at both end and text between
    y = [0.132 0.132];
    x = [0.285 0.3];      % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
    annotation('textarrow',x,y,'String',' MBW ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1);
    x = [0.2630 0.248];
    annotation('textarrow',x,y,'FontSize',10,'Linewidth',1);
    
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
    title({['\bf\fontsize{18}PSD - Filtered Vxy - GRF (IIR, N=', num2str(N2),')'] ;num2str(DateString)});
    
    
    % ----- *Vxz* -----
    subplot(2,3,5)
    [freq_IIR,power_FIR] = f_normalized_psd(Vxz_filt_IIR{i},T_s);
    [freq_unfilt,power_unfilt] = f_normalized_psd(Vxz_new{i},T_s);
    
    p(1,1)= semilogy(freq_unfilt(1:end/2),power_unfilt(1:end/2),'Color',[0 1 1]);
    hold on;
    p(2,1)= semilogy(freq_IIR(1:end/2),power_FIR(1:end/2),'Color',[0.9290 0.6940 0.1250]);
    
    % MBW limits
    hold on;
    plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0]);
    hold on;
    plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0]);
    hold off;
    
    % legend
    legend('PSD Vxz unfiltered','PSD Vxz IIR');
    lgd = legend;
    lgd.FontSize = 12;
    %lgd.ItemTokenSize = [40,25];
    lgd.Location= ('northwest');
    
    % Arrow with two head at both end and text between
    y = [0.132 0.132];
    x = [0.5650 0.58];      % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
    annotation('textarrow',x,y,'String',' MBW ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1);
    x = [0.5430 0.528];
    annotation('textarrow',x,y,'FontSize',10,'Linewidth',1);
    
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
    title({['\bf\fontsize{18}PSD - Filtered Vxz - GRF (IIR, N=', num2str(N2),')'] ;num2str(DateString)});
    
    
    % ----- *Vyz* -----
    subplot(2,3,6)
    [freq_IIR,power_FIR] = f_normalized_psd(Vyz_filt_IIR{i},T_s);
    [freq_unfilt,power_unfilt] = f_normalized_psd(Vyz_new{i},T_s);
    
    p(1,1)= semilogy(freq_unfilt(1:end/2),power_unfilt(1:end/2),'Color',[0 1 1]);
    hold on;
    p(2,1)= semilogy(freq_IIR(1:end/2),power_FIR(1:end/2),'Color',[0.4660 0.6740 0.1880]);
    
    % MBW limits
    hold on;
    plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0]);
    hold on;
    plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0]);
    hold off;
    
    % legend
    legend('PSD Vyz unfiltered','PSD Vyz IIR');
    lgd = legend;
    lgd.FontSize = 12;
    %lgd.ItemTokenSize = [40,25];
    lgd.Location= ('northwest');
    
    % Arrow with two head at both end and text between
    y = [0.132 0.132];
    x = [0.845 0.86];      % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
    annotation('textarrow',x,y,'String',' MBW ','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1);
    x = [0.823 0.8080];
    annotation('textarrow',x,y,'FontSize',10,'Linewidth',1);
    
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
    title({['\bf\fontsize{18}PSD - Filtered Vyz - GRF (IIR, N=', num2str(N2),')'] ;num2str(DateString)});
    
    % SAVE figure
    % .jpeg
    set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
    filename_save = sprintf('PSD_GG_GRF_IIR_%s_%s.jpeg',num2str(N2),num2str(DateString));
    txtname = fullfile(currentFolder2,filename_save);
    print(f, txtname,'-djpeg','-r100')
    % .fig
    set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');
    filename_save = sprintf('PSD_GG_GRF_IIR_%s_%s.fig',num2str(N2),num2str(DateString));
    txtname = fullfile(currentFolder2,filename_save);
    savefig(txtname);
    
    clc
    fprintf(2, '\nGeoGravGOCE Info:\n')
    disp('a figure was saved in "PSD IIR filtered Vij GRF" folder')
end

% message for the user/ all ok/ check the folder "FIR filtered Gravity Gradients GRF"
% for the resluts.
Opt.Interpreter = 'tex';
Opt.WindowStyle = 'normal';
msgbox({'Your figures (.jpeg & .fig) were saved in the new folder';' "PSD IIR filtered Vij GRF" .';'';' Check them!'}, 'Info', 'help', Opt);
k=1; % counter
end






