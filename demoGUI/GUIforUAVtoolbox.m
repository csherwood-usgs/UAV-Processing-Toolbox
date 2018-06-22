% GUIforUAVtoolbox Graphical User Interface for the UAV Processing Toolbox
% KV WRL 04.2017
% Matlab version required: R2016b

function GUIforUAVtoolbox()


close all
clc
addpath('/Users/patrickscordato/Desktop/SSF_2018/sandwich_beach_cam/practice/gcp_2015_12_22')
addpath('/Users/patrickscordato/Desktop/SSF_2018/sandwich_beach_cam/calibration/sandwich_UAV-Processing-Toolbox')
% Some graphical settings
% set(0,'DefaultTextFontsize',10, ...
% 'DefaultTextFontname','Times New Roman', ...
% 'DefaultTextFontWeight','bold', ...
% 'DefaultAxesFontsize',10, ...
% 'DefaultAxesFontname','Times New Roman', ...
% 'DefaultLineLineWidth', 1.5,...
% 'DefaultLineMarkerSize', 8,...
% 'DefaultAxesLineWidth', 0.75)


% Add path
str = which('GUIforUAVtoolbox.m');
index = regexp(str, filesep);
mainDir = str(1:index(end-1));
addpath(genpath(mainDir));

% Set some default values
% set(groot,'DefaultAxesFontSize',8)
% set(groot,'DefaultLineLineWidth',1.5)
set(groot,'Units','normalized')
% set(groot,'DefaultTextFontSize',16,'DefaultTextFontName','times')

%% Figure
f = figure(...
    'Name', 'UAV Processing Toolbox',...
    'Units', 'normalized',...
    'Position', [0,0,1,0.9]);

% Move the window to the center of the screen.
movegui(f, 'center')

% Create 3 tabs (Initial set-up, Camera settings, GCPs and Outputs)
tgroup = uitabgroup(...
    'Parent', f,...
    'Tag', 'tabGroup');
tab1 = uitab(...
    'Parent', tgroup,...
    'Title', '1. Initial set-up',...
    'Tag','tab1');
tab2 = uitab(...
    'Parent', tgroup,...
    'Title', '2. Camera parameters',...
    'Tag','tab2');
tab3 = uitab(...
    'Parent', tgroup,...
    'Title', '3. GCPs and Ref points',...
    'Tag','tab3');

%% Tab1

% Select the firs tab within the tabgroup
tgroup.SelectedTab = tab1;

% Horizontal alignment between the 2 panels
hHBoxTab1 = uix.HBox(...
    'Parent', tab1,...
    'Padding', 5,...
    'Spacing', 10);

% Create Panel for inputs (filenames & pathnames)
hPanelInputs = uix.Panel(...
    'Parent', hHBoxTab1,...
    'Padding', 5,...
    'Title', 'Filenames & Pathnames');
% Create Panel for settings
hPanelSettings = uix.Panel(...
    'Parent', hHBoxTab1,...
    'Padding', 5,...
    'Title', 'Rectification settings');

%% Panel Inputs
hVBoxInput = uix.VBox(...
    'Parent', hPanelInputs,...
    'Padding', 5,...
    'Spacing',10);

% 1. Station Name
hHBoxInput1 = uix.HBox(...
    'Parent', hVBoxInput,...
    'Padding', 5,...
    'Spacing', 5);
hText = uicontrol(...
    'Parent', hHBoxInput1,...
    'Style', 'text',...
    'String', 'Station Name',...
    'Fontsize', 8,...
    'Fontweight', 'bold',...
    'HorizontalAlignment', 'left');
hEdit1 = uicontrol(...
    'Parent', hHBoxInput1,...
    'Tag', 'edit1',...
    'Style', 'edit',...
    'String', 'Enter Station name',...
    'Fontsize', 7,...
    'FontAngle', 'italic',...
    'Callback', {@editStationName_Callback});
hButton1 = uix.Empty('Parent', hHBoxInput1);

% 2. Input Folder (pnIn)
hHBoxInput2 = uix.HBox(...
    'Parent', hVBoxInput,...
    'Padding', 5,...
    'Spacing', 5);
hText = uicontrol(...
    'Parent', hHBoxInput2,...
    'Style', 'text',...
    'String', 'Input folder',...
    'Fontsize', 8,...
    'Fontweight', 'bold',...
    'HorizontalAlignment', 'left');
hEdit2 = uicontrol(...
    'Parent', hHBoxInput2,...
    'Tag','edit2',...
    'Style', 'edit',...
    'String', 'Enter folder containing frames',...
    'Fontsize', 7,...
    'FontAngle', 'italic',...
    'Callback', {@editPnIn_CallBack});
hButton2 = uicontrol(...
    'Parent', hHBoxInput2,...
    'Style', 'pushbutton',...
    'String', '...',...
    'Callback', {@buttonPnIn_Callback});

% 3. Output Folder (pncx)
hHBoxInput3 = uix.HBox(...
    'Parent', hVBoxInput,...
    'Padding', 5,...
    'Spacing', 5);
hText = uicontrol(...
    'Parent', hHBoxInput3,...
    'Style', 'text',...
    'String', 'Output folder',...
    'Fontsize', 8,...
    'Fontweight', 'bold',...
    'HorizontalAlignment', 'left');
hEdit3 = uicontrol(...
    'Parent', hHBoxInput3,...
    'Tag','edit3',...
    'Style', 'edit',...
    'String', 'Enter folder containing frames',...
    'Fontsize', 7,...
    'FontAngle', 'italic',...
    'Callback', {@editPncx_CallBack});
hButton3 = uicontrol(...
    'Parent', hHBoxInput3,...
    'Style', 'pushbutton',...
    'String', '...',...
    'Callback', {@buttonPncx_Callback});

% 4. Frames suffix
hHBoxInput4 = uix.HBox(...
    'Parent', hVBoxInput,...
    'Padding', 5,...
    'Spacing', 5);
hText = uicontrol(...
    'Parent', hHBoxInput4,...
    'Style', 'text',...
    'String', 'Frames suffix',...
    'Fontsize', 8,...
    'Fontweight', 'bold',...
    'HorizontalAlignment', 'left');
hEdit4 = uicontrol(...
    'Parent', hHBoxInput4,...
    'Tag', 'edit4',...
    'Style', 'edit',...
    'String', 'Enter frames name-suffix',...
    'Fontsize', 7,...
    'FontAngle', 'italic',...
    'CallBack', {@editFrameSuffix_Callback});
hButton4 = uix.Empty( 'Parent', hHBoxInput4);

% 5. GCP filename
hHBoxInput5 = uix.HBox(...
    'Parent', hVBoxInput,...
    'Padding', 5,...
    'Spacing', 5);
hText = uicontrol(...
    'Parent', hHBoxInput5,...
    'Style', 'text',...
    'String', 'GCPs File',...
    'Fontsize', 8,...
    'Fontweight', 'bold',...
    'HorizontalAlignment', 'left');
hEdit5 = uicontrol(...
    'Parent', hHBoxInput5,...
    'Tag','edit5',...
    'Style', 'edit',...
    'String', 'Enter GCPs filename (.mat)',...
    'Fontsize', 7,...
    'FontAngle', 'italic',...
    'Callback', {@editGCPsfilename_CallBack});
hButton5 = uicontrol(...
    'Parent', hHBoxInput5,...
    'Style', 'pushbutton',...
    'String', '...',...
    'Callback', {@buttonGCPsfilename_Callback});

% 6. GCP list
hHBoxInput6 = uix.HBox(...
    'Parent', hVBoxInput,...
    'Padding', 5,...
    'Spacing', 5);
hText = uicontrol(...
    'Parent', hHBoxInput6,...
    'Style', 'text',...
    'String', 'GCPs to be used',...
    'Fontsize', 8,...
    'Fontweight', 'bold',...
    'HorizontalAlignment', 'left');
hEdit6 = uicontrol(...
    'Parent', hHBoxInput6,...
    'Tag','edit6',...
    'Style', 'edit',...
    'String', 'Enter GCP numbers (eg. 1 3 4 7)',...
    'Fontsize', 7,...
    'FontAngle', 'italic',...
    'Callback', {@editGCPList_CallBack});
hButton6 = uicontrol(...
    'Parent', hHBoxInput6,...
    'Tag', 'button6',...
    'Style', 'pushbutton',...
    'String', 'list',...
    'Callback',...
    {@buttonGCPList_Callback},...
    'Enable', 'off');

% 7. Reference points
hHBoxInput7 = uix.HBox(...
    'Parent', hVBoxInput,...
    'Padding', 5,...
    'Spacing', 5);
hText = uicontrol(...
    'Parent', hHBoxInput7,...
    'Style', 'text',...
    'String', '# of refpoints',...
    'Fontsize', 8,...
    'Fontweight', 'bold',...
    'HorizontalAlignment', 'left');
hEdit7 = uicontrol(...
    'Parent', hHBoxInput7,...
    'Tag','edit7',...
    'Style', 'edit',...
    'String', '',...
    'Fontsize', 7,...
    'Callback', {@editRefpoints_CallBack});
hEmpty = uix.Empty('Parent', hHBoxInput7);

% 8.Insts File
hHBoxInput8 = uix.HBox(...
    'Parent', hVBoxInput,...
    'Padding', 5,...
    'Spacing', 5);
hText = uicontrol(...
    'Parent', hHBoxInput8,...
    'Style', 'text',...
    'String', 'Instruments File',...
    'Fontsize', 8,...
    'Fontweight', 'bold',...
    'HorizontalAlignment', 'left');
hEdit8 = uicontrol(...
    'Parent', hHBoxInput8,...
    'Tag','edit8',...
    'Style', 'edit',...
    'String', 'Enter InstsFile.m',...
    'Fontsize', 7,...
    'FontAngle', 'italic',...
    'Callback', {@editInstsfile_CallBack});
hButton8 = uicontrol(...
    'Parent', hHBoxInput8,...
    'Style', 'pushbutton',...
    'String', '...',...
    'Callback', {@buttonInstsfile_Callback});

% Alignments for Panel Inputs
% Vertical
set(hVBoxInput, 'Heights', [30 30 30 30 30 30 30 30])
% Horizontal
set(hHBoxInput1, 'Widths', [100 -1 20])  
set(hHBoxInput2, 'Widths', [100 -1 20])    
set(hHBoxInput3, 'Widths', [100 -1 20])
set(hHBoxInput4, 'Widths', [100 -1 20])
set(hHBoxInput5, 'Widths', [100 -1 20])
set(hHBoxInput6, 'Widths', [100 -1 40])
set(hHBoxInput7, 'Widths', [100 40 -1])
set(hHBoxInput8, 'Widths', [100 -1 20])



%% Panel Settings
hVBoxSettings = uix.VBox(...
    'Parent', hPanelSettings,...
    'Padding', 5,...
    'Spacing',5);

% Argus coordinate system
hText = uicontrol(...
    'Parent', hVBoxSettings,...
    'Style', 'text',...
    'String', 'Argus coordinate system',...
    'Fontsize', 8,...
    'Fontweight', 'bold');

% 9. Local coordinate system (EPSG code)
hHBoxSettings1 = uix.HBox(...
    'Parent', hVBoxSettings,...
    'Padding', 5,...
    'Spacing', 5);
hText = uicontrol(...
    'Parent', hHBoxSettings1,...
    'Style', 'text',...
    'String', 'CoordSys EPSG',...
    'Fontsize', 7,...
    'Fontweight', 'bold',...
    'HorizontalAlignment', 'left');
hEdit9 = uicontrol(...
    'Parent', hHBoxSettings1,...
    'Tag','edit9',...
    'Style', 'edit',...
    'String', '',...
    'Fontsize', 7,...
    'Callback', {@editEpsgcode_CallBack});
hTextCoordsys = uicontrol(...
    'Parent', hHBoxSettings1,...
    'Tag', 'textCoordsys',...
    'Style', 'text',...
    'String', '...',...
    'Fontsize', 9,...
    'Fontweight', 'normal',...
    'FontAngle', 'italic');
hCheckLocal = uicontrol(...
    'Parent', hHBoxSettings1,...
    'Tag', 'checkLocal',...
    'Style', 'checkbox',...
    'String', 'Local',...
    'Fontsize', 7,...
    'Fontweight', 'bold',...
    'Callback', {@checkLocal_CallBack});
% 10. Argus local origin Eastings
hHBoxSettings2 = uix.HBox(...
    'Parent', hVBoxSettings,...
    'Padding', 5,...
    'Spacing', 5);
hText = uicontrol(...
    'Parent', hHBoxSettings2,...
    'Style', 'text',...
    'String', 'Eastings [m]',...
    'Fontsize', 7,...
    'Fontweight', 'bold',...
    'HorizontalAlignment', 'left');
hEdit10 = uicontrol(...
    'Parent', hHBoxSettings2,...
    'Tag','edit10',...
    'Style', 'edit',...
    'String', '',...
    'Fontsize', 7,...
    'Callback', {@editXArgus_CallBack});

% 11. Argus local origin Northings
hHBoxSettings3 = uix.HBox(...
    'Parent', hVBoxSettings,...
    'Padding', 5,...
    'Spacing', 5);
hText = uicontrol(...
    'Parent', hHBoxSettings3,...
    'Style', 'text',...
    'String', 'Northings [m]',...
    'Fontsize', 7,...
    'Fontweight', 'bold',...
    'HorizontalAlignment', 'left');
hEdit11 = uicontrol(...
    'Parent', hHBoxSettings3,...
    'Tag','edit11',...
    'Style', 'edit',...
    'String', '',...
    'Fontsize', 7,...
    'Callback', {@editYArgus_CallBack});

% 12. Argus local origin Rotation
hHBoxSettings4 = uix.HBox(...
    'Parent', hVBoxSettings,...
    'Padding', 5,...
    'Spacing', 5);
hText = uicontrol(...
    'Parent', hHBoxSettings4,...
    'Style', 'text',...
    'String', 'Rotation angle [�]',...
    'Fontsize', 7,...
    'Fontweight', 'bold',...
    'HorizontalAlignment', 'left');
hEdit12 = uicontrol(...
    'Parent', hHBoxSettings4,...
    'Tag','edit12',...
    'Style', 'edit',...
    'String', '',...
    'Fontsize', 7,...
    'Callback', {@editRotArgus_CallBack});

hEmpty = uix.Empty('Parent', hVBoxSettings);

% Rectification settings
hText = uicontrol(...
    'Parent', hVBoxSettings,...
    'Style', 'text',...
    'String', 'Rectification Limits',...
    'Fontsize', 8,...
    'Fontweight', 'bold');
hText = uicontrol(...
    'Parent', hVBoxSettings,...
    'Style', 'text',...
    'String', 'in Argus (cross-shore/alongshore) coordinates [m]',...
    'Fontsize', 7,...
    'Fontweight', 'normal');

% 13. X limits
hHBoxSettings5 = uix.HBox(...
    'Parent', hVBoxSettings,...
    'Padding', 5,...
    'Spacing', 5);
hText = uicontrol(...
    'Parent', hHBoxSettings5,...
    'Style', 'text',...
    'String', 'Xmin',...
    'Fontsize', 7,...
    'Fontweight', 'bold');
hEdit13a = uicontrol(...
    'Parent', hHBoxSettings5,...
    'Tag','edit13a',...
    'Style', 'edit',...
    'String', '',...
    'Fontsize', 7,...
    'Callback', {@editXmin_CallBack});
hText = uicontrol(...
    'Parent', hHBoxSettings5,...
    'Style', 'text',...
    'String', 'Xmax',...
    'Fontsize', 7,...
    'Fontweight', 'bold');
hEdit13b = uicontrol(...
    'Parent', hHBoxSettings5,...
    'Tag','edit13b',...
    'Style', 'edit',...
    'String', '',...
    'Fontsize', 7,...
    'Callback', {@editXmax_CallBack});
hText = uicontrol(...
    'Parent', hHBoxSettings5,...
    'Style', 'text',...
    'String', 'dX',...
    'Fontsize', 7,...
    'Fontweight', 'bold');
hEdit13c = uicontrol(...
    'Parent', hHBoxSettings5,...
    'Tag','edit13c',...
    'Style', 'edit',...
    'String', '',...
    'Fontsize', 7,...
    'Callback', {@editdX_CallBack});

% 14. Y limits
hHBoxSettings6 = uix.HBox(...
    'Parent', hVBoxSettings,...
    'Padding', 5,...
    'Spacing', 5);
hText = uicontrol(...
    'Parent', hHBoxSettings6,...
    'Style', 'text',...
    'String', 'Ymin',...
    'Fontsize', 7,...
    'Fontweight', 'bold');
hEdit14a = uicontrol(...
    'Parent', hHBoxSettings6,...
    'Tag','edit14a',...
    'Style', 'edit',...
    'String', '',...
    'Fontsize', 7,...
    'Callback', {@editYmin_CallBack});
hText = uicontrol(...
    'Parent', hHBoxSettings6,...
    'Style', 'text',...
    'String', 'Ymax',...
    'Fontsize', 7,...
    'Fontweight', 'bold');
hEdit14b = uicontrol(...
    'Parent', hHBoxSettings6,...
    'Tag','edit14b',...
    'Style', 'edit',...
    'String', '',...
    'Fontsize', 7,...
    'Callback', {@editYmax_CallBack});
hText = uicontrol(...
    'Parent', hHBoxSettings6,...
    'Style', 'text',...
    'String', 'dY',...
    'Fontsize', 7,...
    'Fontweight', 'bold');
hEdit14c = uicontrol(...
    'Parent', hHBoxSettings6,...
    'Tag','edit14c',...
    'Style', 'edit',...
    'String', '',...
    'Fontsize', 7,...
    'Callback', {@editdY_CallBack});

% 15. Z-level
hHBoxSettings7 = uix.HBox(...
    'Parent', hVBoxSettings,...
    'Padding', 5,...
    'Spacing', 5);
hEmpty = uix.Empty('Parent', hHBoxSettings7);
hEmpty = uix.Empty('Parent', hHBoxSettings7);
hText = uicontrol(...
    'Parent', hHBoxSettings7,...
    'Style', 'text',...
    'String', 'Z-level',...
    'Fontsize', 7,...
    'Fontweight', 'bold');
hEdit15 = uicontrol(...
    'Parent', hHBoxSettings7,...
    'Tag','edit15',...
    'Style', 'edit',...
    'String', '',...
    'Fontsize', 7,...
    'Callback', {@editZlevel_CallBack});
hEmpty = uix.Empty('Parent', hHBoxSettings7);
hEmpty = uix.Empty('Parent', hHBoxSettings7);

% Alignments for Panel Settings
% Vertical
set(hVBoxSettings, 'Heights', [20 30 30 30 30 8 20 15 30 30 30]);
% Horizontal
set(hHBoxSettings1, 'Widths', [90 50 -1 60])
set(hHBoxSettings2, 'Widths', [90 -1 ])
set(hHBoxSettings3, 'Widths', [90 -1 ])
set(hHBoxSettings4, 'Widths', [90 -1 ])
set(hHBoxSettings5, 'Widths', [40 -1 40 -1 40 -1])
set(hHBoxSettings6, 'Widths', [40 -1 40 -1 40 -1])
set(hHBoxSettings7, 'Widths', [40 -1 40 -1 40 -1])


%% Tab2

% Vertical aligment between Camera panel and Axes 
hVBoxTab2 = uix.VBox('Parent', tab2,...
    'Padding', 5,...
    'Spacing',3);

% Horizontal alignment between Intrinsic and Extrinsic camera parameters
hHBoxCamera = uix.HBox('Parent', hVBoxTab2,...
    'Spacing',10);

% Panel Intrinsic camera parameters 
hPanelCamInt = uix.Panel('Parent', hHBoxCamera);
hVBoxCamera1 = uix.VBox('Parent', hPanelCamInt,...
    'Padding', 5,...
    'Spacing',10);
hText  = uicontrol(...
    'Parent', hVBoxCamera1,...
    'Style', 'Text',...
    'String', 'Intrinsic camera parameters',...
    'Fontsize', 9,...
    'Fontweight', 'bold');
hHBoxCamInt = uix.HBox('Parent', hVBoxCamera1,...
    'Spacing',15);
hVBoxCamInt = uix.VBox('Parent', hHBoxCamInt,...
    'Spacing', 10);

% 16. Camera Name
hHBoxCameraName = uix.HBox('Parent', hVBoxCamInt,...
    'Spacing',5);
hText  = uicontrol(...
    'Parent', hHBoxCameraName,...
    'Style', 'Text',...
    'String', 'Camera',...
    'Fontsize', 8,...
    'Fontweight', 'bold',...
    'HorizontalAlignment', 'left');
% Populate popup menu from the cameras present in makeLCPP3.m by looking
% which word is after 'case'
cameraFile = which('makeLCPP3.m');
fid = fopen(cameraFile);
tline = fgetl(fid);
counter = 1;
while ischar(tline)
    if contains(tline,'case')
        [temp1 temp2]= strtok(tline,' ');
        temp2 = erase(temp2,'''');
        temp2 = erase(temp2,' ');
        cameraNames{counter} = temp2;
        counter = counter + 1;
    end
   tline = fgetl(fid);
end
fclose(fid);
cameraNames{counter} = 'custom';
hPopupCam = uicontrol( ...
    'Parent', hHBoxCameraName,...
    'Style', 'popupmenu',...
    'Tag', 'popupCam',...
    'String', cameraNames,...
    'Callback', {@popupCam_Callback});

% 17. Camera Resolution
hHBoxCameraRes = uix.HBox('Parent', hVBoxCamInt,...
    'Spacing',3);
hText  = uicontrol(...
    'Parent', hHBoxCameraRes,...
    'Style', 'Text',...
    'String', 'Resolution',...
    'Fontsize', 8,...
    'Fontweight', 'bold',...
    'HorizontalAlignment', 'left');
hEdit17a = uicontrol(...
    'Parent', hHBoxCameraRes,...
    'Tag','edit17a',...
    'Style', 'Edit',...
    'String', 'NU (eg. 3840)',...
    'Fontsize', 7,...
    'FontAngle', 'italic',...
    'Callback', {@editUpixels_CallBack});
hText  = uicontrol(...
    'Parent', hHBoxCameraRes,...
    'Style', 'Text',...
    'String', 'x',...
    'Fontsize', 10,...
    'Fontweight', 'normal');
hEdit17b = uicontrol(...
    'Parent', hHBoxCameraRes,...
    'Tag','edit17b',...
    'Style', 'Edit',...
    'String', 'NV (eg. 2160)',...
    'Fontsize', 7,...
    'FontAngle', 'italic',...
    'Callback', {@editVpixels_CallBack});

% 18. Button Get
hButtonCamInt = uicontrol(...
    'Parent', hVBoxCamInt,...
    'tag', 'buttonGet',...
    'Style', 'pushbutton',...
    'String', 'Get',...
    'Callback', {@buttonCamInt_CallBack});

% 18b & 18c. Horizontal alignment with 2 buttons (save and load camera)
hHBoxSaveLoad = uix.HBox('Parent', hVBoxCamInt,...
    'Spacing',3);
hButtonSave = uicontrol(...
    'Parent', hHBoxSaveLoad,...
    'tag', 'buttonSave',...
    'Style', 'pushbutton',...
    'String', 'Save camera',...
    'Enable','off',...
    'Callback', {@buttonSave_CallBack});
hButtonLoad = uicontrol(...
    'Parent', hHBoxSaveLoad,...
    'tag', 'buttonLoad',...
    'Style', 'pushbutton',...
    'String', 'Load camera',...
    'Enable','off',...
    'Callback', {@buttonLoad_CallBack});

% 19. Table for internal camera parameters
hTableCamInt = uitable(...
    'Parent', hHBoxCamInt,...
    'Tag', 'tableCamInt',...
    'Units', 'pixels',...
    'ColumnName', {'Value','Unit'},...
    'RowName', {'fx','fy','c0U','c0V','d1','d2','d3','t1','t2'},...
    'ColumnEditable', [true false],...
    'Data', {'0' sprintf('    %s','pixels'); '0' sprintf('    %s','pixels'); ...
    '0' sprintf('    %s','pixels'); '0' sprintf('    %s','pixels'); ...
    '0' sprintf('    %s','-'); '0' sprintf('    %s','-'); '0' sprintf('    %s','-'); ...
    '0' sprintf('    %s','-'); '0' sprintf('    %s','-')});

% Panel extrinsic camera parameters
hPanelCamExt = uix.Panel(...
    'Parent', hHBoxCamera);
hVBoxCamera2 = uix.VBox('Parent', hPanelCamExt,...
    'Padding', 5,...
    'Spacing',10);
hText  = uicontrol(...
    'Parent', hVBoxCamera2,...
    'Style', 'Text',...
    'String', 'Extrinsic camera parameters',...
    'Fontsize', 9,...
    'Fontweight', 'bold');

% 20. Table for external camera parameters
hHBoxCamExtTable = uix.HBox('Parent', hVBoxCamera2);
hEmpty = uix.Empty('Parent', hHBoxCamExtTable);
htableCamExt = uitable(...
    'Parent', hHBoxCamExtTable,...
    'Tag', 'tableCamExt',...
    'Units', 'pixels',...
    'ColumnName', {'Value','Unit','Unknown'},...
    'RowName', {'X','Y','Z','Azimuth','Tilt','Roll'},...
    'ColumnEditable', [true false true],...
    'Data', {'0' sprintf('     %s','m') true; '0' sprintf('     %s','m') true; ...
    '0' sprintf('     %s','m') true; '0' sprintf('     %s','deg') true; ...
    '0' sprintf('     %s','deg') true ; '0' sprintf('     %s','deg') true});
hEmpty = uix.Empty('Parent', hHBoxCamExtTable);

% 21. Button Get from EXIF
hHBoxCamExtGet = uix.HBox('Parent', hVBoxCamera2);
hEmpty = uix.Empty('Parent', hHBoxCamExtGet);
hButtonCamExt = uicontrol(...
    'Parent', hHBoxCamExtGet,...
    'Style', 'pushbutton',...
    'String', 'Get from EXIF (load snapshot)',...
    'Callback', {@buttonCamExt_CallBack});
hEmpty = uix.Empty('Parent', hHBoxCamExtGet);


% Alignments for Tab Camera
set(hHBoxCameraName, 'Widths', [60 -1])
set(hHBoxCameraRes, 'Widths', [60 -1 10 -1])
set(hVBoxCamera1, 'Heights', [20 -1])
set(hVBoxCamInt, 'Heights', [20 20 20 20])
set(hVBoxCamera2, 'Heights', [20 -1 20])
set(hHBoxCamExtTable, 'Widths', [-1 -200 -1])

% 22. Axes below the 2 panels
hAxesTab2 = axes(...
    'Parent', hVBoxTab2,...
    'Tag', 'axesTab2',...
    'Visible', 'off');

% 23. Button 'Save initial settings and continue'
hHboxButtonFinishedInit = uix.HBox(...
    'Parent', hVBoxTab2,...
    'Padding',5);
hEmpty = uix.Empty('Parent', hHboxButtonFinishedInit);
hButtonFinishedInit = uicontrol(...
    'Parent', hHboxButtonFinishedInit,...
    'Style', 'pushbutton',...
    'String', 'Save initial settings and continue',...
    'Tag', 'buttonFinishedInit',...
    'CallBack', {@buttonFinishedInit_CallBack});
hButtonFinishedInit.BackgroundColor = 'g';
hEmpty = uix.Empty('Parent', hHboxButtonFinishedInit);


set(hHboxButtonFinishedInit, 'Widths', [-1 -2 -1])
set(hVBoxTab2, 'Heights', [-1 -1.3 30]);


%% Tab3

% Vertical alignment for Axes and command panel
hVBoxTab3 = uix.VBox(...
    'Parent', tab3,...
    'Padding', 5,...
    'Spacing', 2);

% 24. Axes on Tab3
hAxesTab3 = axes(...
    'Parent', hVBoxTab3,...
    'Tag', 'axesTab3',...
    'Visible', 'off');
axis(hAxesTab3, 'image');
axis(hAxesTab3, 'ij')
hAxesTab3.NextPlot = 'add';

% Create Panel on Tab3
hHboxPanelInst = uix.HBox(...
    'Parent', hVBoxTab3,...
    'Padding', 0,...
    'Spacing', 10);
hPanelInst = uix.Panel(...
    'Parent', hHboxPanelInst,...
    'Padding', 10,...
    'Title', 'Instructions');
hVBoxCommands =  uix.VBox(...
    'Parent', hPanelInst,...
    'Padding', 2,...
    'Spacing', 10);

% 25. Two text lines for instructions
hCommandText1 = uicontrol(...
    'Parent', hVBoxCommands,...
    'Style', 'Text',...
    'Tag', 'textCommand1',... 
    'String', 'Instructions will appear here as you go',...
    'Fontsize', 10,...
    'Fontweight', 'normal',...
    'HorizontalAlignment', 'left');
hCommandText2 = uicontrol(...
    'Parent', hVBoxCommands,...
    'Style', 'Text',...
    'Tag', 'textCommand2',... 
    'String', '',...
    'Fontsize', 10,...
    'Fontweight', 'bold',...
    'HorizontalAlignment', 'left');

% Create 4 buttons on the right side of the panel
hVBoxButtonsTab3 =  uix.VBox(...
    'Parent', hHboxPanelInst,...
    'Padding', 5,...
    'Spacing', 3);

% 26. First frame processing
hButtonFirstframe = uicontrol(...
    'Parent', hVBoxButtonsTab3,...
    'Style', 'pushbutton',...
    'Tag', 'firstframe',...
    'String', 'First frame processing',...
    'Callback', {@buttonFirstframe_CallBack});

% 27. Pixel instruments
hButtonPixelInsts = uicontrol(...
    'Parent', hVBoxButtonsTab3,...
    'Style', 'pushbutton',...
    'Tag', 'pixelInsts',...
    'String', 'Pixel Instruments',...
    'Callback', {@buttonPixelInsts_CallBack},...
    'Enable','off');

% 28. Batch processing
hButtonBatch = uicontrol(...
    'Parent', hVBoxButtonsTab3,...
    'Style', 'pushbutton',...
    'Tag', 'batchprocessing',...
    'String', 'Batch processing',...
    'Callback', {@buttonBatch_CallBack},...
    'Enable', 'off');

% 29. Argus-like products
hButtonShowFigures1 = uicontrol(...
    'Parent', hVBoxButtonsTab3,...
    'Style', 'pushbutton',...
    'Tag', 'showfigures1',...
    'String', 'Argus-like products',...
    'Callback', {@buttonShowFiguresArgus_CallBack},...
    'Enable', 'off');

% 30. Geometries
hButtonShowFigures2 = uicontrol(...
    'Parent', hVBoxButtonsTab3,...
    'Style', 'pushbutton',...
    'Tag', 'showfigures2',...
    'String', 'Geometries',...
    'Callback', {@buttonShowFiguresGeom_CallBack},...
    'Enable', 'off');

set(hHboxPanelInst, 'Widths', [-3 -1]);
set(hVBoxTab3, 'Heights', [-4 -1]);


%% Default values
str = which('GUIforUAVtoolbox.m');
index = regexp(str, filesep);
currDir = str(1:index(end));

% Load inputs file
loadInputs = questdlg('Would you like to use an input file?',...
            'Load inputs',...
            'Yes', 'No', 'Yes');
        
if strcmp(loadInputs, 'No')
    
    handles.inputs.localCoords = 0;
      
else
    % Ask user to open an inputFile
    [inputsFn, inputPn] = uigetfile('*.m','Select input file');
    
    % Read inputs file
    p = pwd;
    eval(['cd ' inputPn]);
    [inputsFn, remain] = strtok(inputsFn, '.');
    eval(inputsFn);
    eval(['cd ' p]);
    clear p

    handles.inputs = inputs;
    
    % Display inputs from file on GUI
    
    % Panel Filenames & Pathnames
    hEdit1.String = handles.inputs.stationStr;
    hEdit2.String = handles.inputs.pnIn;
    hEdit3.String = handles.inputs.pncx;
    hEdit4.String = handles.inputs.frameFn;
    hEdit5.String = handles.inputs.gcpFn;
    hEdit6.String = num2str(handles.inputs.gcpList);
    hEdit7.String = num2str(handles.inputs.nRefs);
    hEdit8.String = handles.inputs.instsFn;
    
    % Panel Argus Coordinate System
    hEdit9.String = num2str(handles.inputs.ArgusCoordsys.EPSG);
    hEdit10.String = num2str(handles.inputs.ArgusCoordsys.X0);
    hEdit11.String = num2str(handles.inputs.ArgusCoordsys.Y0);
    hEdit12.String = num2str(handles.inputs.ArgusCoordsys.rot);
    % Display name of EPSG in text field
    latlongepsg = 4326; % not important just for getting the name of the epsg code
    xyepsg = handles.inputs.ArgusCoordsys.EPSG;
    [E, N, logconv] = convertCoordinates(0, 0,'CS1.code', latlongepsg, 'CS2.code', xyepsg);
    hTextCoordsys.String = logconv.CS2.name;
    
    % If localCoords flag is on, disable Argus coordinate system fields
    if handles.inputs.localCoords
        hCheckLocal.Value = 1;
        hEdit9.Enable = 'off';
        hEdit10.Enable = 'off';
        hEdit11.Enable = 'off';
        hEdit12.Enable = 'off';
        
    end
    
    % Rectification limits
    hEdit13a.String = num2str(handles.inputs.rectxy(1));
    hEdit13b.String = num2str(handles.inputs.rectxy(3));
    hEdit13c.String = num2str(handles.inputs.rectxy(2));
    hEdit14a.String = num2str(handles.inputs.rectxy(4));
    hEdit14b.String = num2str(handles.inputs.rectxy(6));
    hEdit14c.String = num2str(handles.inputs.rectxy(5));
    hEdit15.String = num2str(handles.inputs.rectz);
    
    % Panel intrinsic camera parameters (cameraName and cameraRes)
    hEdit17a.String = num2str(handles.inputs.cameraRes(1));
    hEdit17b.String = num2str(handles.inputs.cameraRes(2));
    hPopupCam.Value = find(strcmp(hPopupCam.String,handles.inputs.cameraName));
    % Fill table with intrinsic camera parameters
    handles.camInt = makeLCPP3(handles.inputs.cameraName, handles.inputs.cameraRes(1), handles.inputs.cameraRes(2));
    hTableCamInt.Data(:,1) = {sprintf(' %.2f',handles.camInt.fx) ...
        sprintf(' %.2f',handles.camInt.fy) ...
        sprintf(' %.2f',handles.camInt.c0U) ...
        sprintf(' %.2f',handles.camInt.c0V) ...
        sprintf(' %.2f',handles.camInt.d1) ...
        sprintf(' %.2f',handles.camInt.d2) ...
        sprintf(' %.2f',handles.camInt.d3) ...
        sprintf(' %.2f',handles.camInt.t1) ...
        sprintf(' %.2f',handles.camInt.t2) ...
        };
    % Camera extrinsic parameters
    
    % check if snapshotFn field is empty or not
    % if snapshot available, extract metadata from snapshot with exiftool
    % routines
    if ~isempty(handles.inputs.snapshotFn)
        % try/catch structure in case the snapshot is not found
        try
        
            % Get data/time variables
            [handles.inputs.dateVect handles.inputs.GMT] = getTimestamp(handles.inputs.snapshotFn);
            handles.inputs.dn0 = datenum(handles.inputs.dateVect) - str2double(handles.inputs.GMT)/24;
            handles.inputs.dayFn = argusDay(matlab2Epoch(handles.inputs.dn0));

            % Get FOV (field of view) for calculating horizon
            handles.inputs.FOV = getFOV(handles.inputs.snapshotFn);

            % Known flags
            htableCamExt.Data{1,3} = not(logical(handles.inputs.knownFlags(1)));
            htableCamExt.Data{2,3} = not(logical(handles.inputs.knownFlags(2)));
            htableCamExt.Data{3,3} = not(logical(handles.inputs.knownFlags(3)));
            htableCamExt.Data{4,3} = not(logical(handles.inputs.knownFlags(4)));
            htableCamExt.Data{5,3} = not(logical(handles.inputs.knownFlags(5)));
            htableCamExt.Data{6,3} = not(logical(handles.inputs.knownFlags(6)));

            % Display snapshot
            I = imread(handles.inputs.snapshotFn);
            imagesc(I, 'Parent', hAxesTab2);
            hAxesTab2.DataAspectRatio = [1 1 1];
            title(hAxesTab2, ['Snapshot from ' handles.inputs.stationStr ' ' ...
                datestr(handles.inputs.dateVect) ' GMT ' ...
                handles.inputs.GMT] , 'fontweight', 'normal', 'fontsize' , 11);
            hAxesTab2.XTick = [];
            hAxesTab2.YTick = [];

            % if localCoords flag is off
            if ~handles.inputs.localCoords
                % Get camera extrinsic parameters from snapshot
                handles.camExt = getExtrinsicParam(handles.inputs.snapshotFn,...
                    handles.inputs.ArgusCoordsys.EPSG);
            else
                % Get camera extrinsic parameters from inputsFile (in local
                % Argus coordinates)
                handles.camExt.camX = handles.inputs.camExt(1);
                handles.camExt.camY = handles.inputs.camExt(2);
                handles.camExt.camZ = handles.inputs.camExt(3);
                handles.camExt.camYaw = handles.inputs.camExt(4);
                handles.camExt.camPitch = handles.inputs.camExt(5) - 90;
                handles.camExt.camRoll = handles.inputs.camExt(6);
            end

            % Fill table
            htableCamExt.Data(:,1) = {sprintf(' %.2f',handles.camExt.camX) ...
                sprintf(' %.2f',handles.camExt.camY) ...
                sprintf(' %.2f',handles.camExt.camZ) ...
                sprintf(' %.2f',handles.camExt.camYaw) ...
                sprintf(' %.2f',handles.camExt.camPitch + 90) ...
                sprintf(' %.2f',handles.camExt.camRoll)};       
        catch
            errordlg('Could not read snapshot!', 'Error')
        end
        
    % in case there isn't any snapshot available
    else
            % if localCoords flag is off
            if ~handles.inputs.localCoords
                % Set all extrinsic parameters to 0
                handles.camExt.camX = 0;
                handles.camExt.camY = 0;
                handles.camExt.camZ = 0;
                handles.camExt.camYaw = 0;
                handles.camExt.camPitch = 0;
                handles.camExt.camRoll = 0;
            else
                % Get camera extrinsic parameters from inputsFile (in local
                % Argus coordinates)
                handles.camExt.camX = handles.inputs.camExt(1);
                handles.camExt.camY = handles.inputs.camExt(2);
                handles.camExt.camZ = handles.inputs.camExt(3);
                handles.camExt.camYaw = handles.inputs.camExt(4);
                handles.camExt.camPitch = handles.inputs.camExt(5) - 90;
                handles.camExt.camRoll = handles.inputs.camExt(6);
            end
            % Fill table
            htableCamExt.Data(:,1) = {sprintf(' %.2f',handles.camExt.camX) ...
                sprintf(' %.2f',handles.camExt.camY) ...
                sprintf(' %.2f',handles.camExt.camZ) ...
                sprintf(' %.2f',handles.camExt.camYaw) ...
                sprintf(' %.2f',handles.camExt.camPitch + 90) ...
                sprintf(' %.2f',handles.camExt.camRoll)};
            % set title as "no snapshot available"
            plot(hAxesTab2, 1,1,'wo')
            hAxesTab2.XTick = [];
            hAxesTab2.YTick = [];            
            title(hAxesTab2, 'NO SNAPSHOT AVAILABLE')
    end
end

handles.plotOn1 = 0;
handles.plotOn2 = 0;

handles.f = f;
guidata(f,handles)
         
end

%% Functions Tab1

% 1. Callback StationName
function editStationName_Callback(hObject, eventdata)
    handles = guidata(hObject);
    
    htextStationEdit = findobj('tag', 'edit1');
    handles.inputs.stationStr = htextStationEdit.String;
    
    guidata(hObject,handles)
end
% 2. Callback Input folder (pnIn)
function buttonPnIn_Callback(hObject, eventdata)
    handles = guidata(hObject);
    
    handles.inputs.pnIn = uigetdir;
    htextPnInEdit = findobj('tag', 'edit2');
    htextPnInEdit.String = handles.inputs.pnIn;
    
    guidata(hObject,handles)
end 
function editPnIn_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    htextPnInEdit = findobj('tag', 'edit2');
    handles.inputs.pnIn = htextPnInEdit.String;
    
    guidata(hObject,handles)
end
% 3. Callback Output folder (pncx)
function buttonPncx_Callback(hObject, eventdata)
    handles = guidata(hObject);
    
    handles.inputs.pncx = uigetdir;
    htextPncxEdit = findobj('tag', 'edit3');
    htextPncxEdit.String = handles.inputs.pncx;
    
    guidata(hObject,handles)
end
function editPncx_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    htextPncxEdit = findobj('tag', 'edit3');
    handles.inputs.pncx = htextPncxEdit.String;
    
    guidata(hObject,handles)
end
% 4. Callback FrameSuffix
function editFrameSuffix_Callback(hObject, eventdata)
    handles = guidata(hObject);
    
    htextFrameEdit = findobj('tag', 'edit4');
    handles.inputs.frameFn = htextFrameEdit.String;
    
    guidata(hObject,handles)
end
% 5. Callback GCPs filename
function editGCPsfilename_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    htextGCPsfilenameEdit = findobj('tag', 'edit5');
    handles.inputs.gcpFn = htextGCPsfilenameEdit.String;
    
    try
        gcpFile = load(handles.inputs.gcpFn);
        handles.gcp = gcpFile.gcp;
        hbuttonList = findobj('tag', 'button6');
        hbuttonList.Enable = 'on';
    catch
        errordlg('gcpFile could not be loaded! Check filename and try again.', 'Error');
        error('gcpFile could not be loaded! Check filename and try again.');
    end
    
    guidata(hObject,handles)
end
function buttonGCPsfilename_Callback(hObject, eventdata)
    handles = guidata(hObject);
    
    [filename, pathname] = uigetfile('*.mat', 'Select gcp file');
    
    if filename == 0
       errordlg('gcpFile was not selected!', 'Error');
       error('gcpfile was not selected') 
       
    else      
        handles.inputs.gcpFn = fullfile(pathname, filename);
        htextGCPsfilenameEdit = findobj('tag', 'edit5');
        htextGCPsfilenameEdit.String = handles.inputs.gcpFn;
        
        try
            gcpFile = load(handles.inputs.gcpFn);
            handles.gcp = gcpFile.gcp;
            hbuttonList = findobj('tag', 'button6');
            hbuttonList.Enable = 'on';
        catch
            errordlg('gcpFile could not be loaded! Check filename and try again.', 'Error');
            error('gcpFile could not be loaded! Check filename and try again.');
        end
        
    end
    
    guidata(hObject,handles)
end
% 6. Callback GCPList
function editGCPList_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    hEditGCPList = findobj('tag', 'edit6');
    s = hEditGCPList.String;
    cnt = 1;
    while 1
        [num remain] = strtok(s);
        handles.inputs.gcpList(cnt) =  str2double(num);
        cnt = cnt + 1;
        if isempty(remain)
            break;
        else
            s = remain;
        end   
    end
 
    guidata(hObject,handles)
end
function buttonGCPList_Callback(hObject, eventdata)
    handles = guidata(hObject);
    
    gcpFile = handles.gcp;
    
    for i = 1:length(gcpFile)
        listStr{i} = gcpFile(i).name;
    end  
    [selection , ok] = listdlg('PromptString','Select GCPs :',...
                'SelectionMode','multiple', 'Name', 'GCP List',...
                'ListString', listStr );
    if ok
       handles.inputs.gcpList = selection; 
    end
    
    hEditGCPList = findobj('tag', 'edit6');
    hEditGCPList.String = num2str(handles.inputs.gcpList);  
            
    guidata(hObject,handles)
end
% 7. Callback number of refpoints
function editRefpoints_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    hEditRefpoints = findobj('tag', 'edit7');
    handles.inputs.nRefs = str2double(hEditRefpoints.String);
    
    if isempty(handles.inputs.nRefs) || isnan(handles.inputs.nRefs)
        errordlg('You did not enter a number for Reference points', 'Error')
        error('You did not enter a number for Reference points')
    end
        
    guidata(hObject,handles)
end
% 8. Callback Instrument file
function editInstsfile_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    htextInstsfileEdit = findobj('tag', 'edit8');
    handles.inputs.instsFn = htextInstsfileEdit.String; 
    
    guidata(hObject,handles)
end
function buttonInstsfile_Callback(hObject, eventdata)
    handles = guidata(hObject);
    
    [filename, pathname] = uigetfile('*.m', 'Select pixel instruments file');
    
    if filename == 0
       errordlg('Insts file was not selected', 'Error');
       error('Insts file was not selected');
       
    else
        handles.inputs.instsFn = fullfile(pathname, filename);
        
        htextInstsfileEdit = findobj('tag', 'edit8');
        htextInstsfileEdit.String = handles.inputs.instsFn;
    end
    guidata(hObject,handles)
end

% 9. Callback EPSG code
function editEpsgcode_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    hEditEpsgcode = findobj('tag', 'edit9');
    handles.inputs.ArgusCoordsys.EPSG = str2double(hEditEpsgcode.String);
    
    if isempty(handles.inputs.ArgusCoordsys.EPSG) || isnan(handles.inputs.ArgusCoordsys.EPSG)
        errordlg('You did not enter a number for EPSG code', 'Error');
        error('You did not enter a number for EPSG code');
    end
    
    % Display name of EPSG in text field
    try
        latlongepsg = 4326; % not important
        xyepsg = handles.inputs.ArgusCoordsys.EPSG;
        [E, N, logconv] = convertCoordinates(0, 0,'CS1.code', latlongepsg, 'CS2.code', xyepsg);
        hTextCoordsys = findobj('Tag', 'textCoordsys');
        hTextCoordsys.String = logconv.CS2.name;
    catch
        errordlg(['EPSG code unknown : ' num2str(handles.inputs.ArgusCoordsys.EPSG)], 'Error');
        error(['EPSG code unknown : ' num2str(handles.inputs.ArgusCoordsys.EPSG)]);
    end
    guidata(hObject,handles)
end
% 9b. Checkbox Local coordinates
function checkLocal_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    hCheckLocal = findobj('tag','checkLocal');
    hEditEpsgcode = findobj('tag', 'edit9');
    hEditXArgus = findobj('tag', 'edit10');
    hEditYArgus = findobj('tag', 'edit11');
    hEditRotArgus = findobj('tag', 'edit12');
    
    if hCheckLocal.Value == 1
        
        % Set localCoords to TRUE
        handles.inputs.localCoords = 1;
        
        % Disable all the panel 
        hEditEpsgcode.Enable = 'off';
        hEditXArgus.Enable = 'off';
        hEditYArgus.Enable = 'off';
        hEditRotArgus.Enable = 'off';
        
    else
        % Set localCoords to FALSE
        handles.inputs.localCoords = 0;
        
        % Enable all the panels
        hEditEpsgcode.Enable = 'on';
        hEditXArgus.Enable = 'on';
        hEditYArgus.Enable = 'on';
        hEditRotArgus.Enable = 'on';

    end
    
    guidata(hObject,handles)
end
% 10. Callback Argus Local origin Eastings
function editXArgus_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    hEditXArgus = findobj('tag', 'edit10');
    handles.inputs.Argus.X0 = str2double(hEditXArgus.String);
    
    if isempty(handles.inputs.ArgusCoordsys.X0) || isnan(handles.inputs.ArgusCoordsys.X0)
        errordlg('You did not enter a number for Argus Local Origin Eastings', 'Error');
        error('You did not enter a number for Argus Local Origin Eastings');
    end
        
    guidata(hObject,handles)
end
% 11. Callback Argus Local origin Northings
function editYArgus_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    hEditYArgus = findobj('tag', 'edit11');
    handles.inputs.ArgusCoordsys.Y0 = str2double(hEditYArgus.String);
    
    if isempty(handles.inputs.ArgusCoordsys.Y0) || isnan(handles.inputs.ArgusCoordsys.Y0)
        errordlg('You did not enter a number for Argus Local Origin Northings', 'Error');
        error('You did not enter a number for Argus Local Origin Northings');
    end
        
    guidata(hObject,handles)
end
% 12. Callback Argus Local origin Rotation
function editRotArgus_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    hEditRotArgus = findobj('tag', 'edit12');
    handles.inputs.ArgusCoordsys.rot = str2double(hEditRotArgus.String);
    
    if isempty(handles.inputs.ArgusCoordsys.rot) || isnan(handles.inputs.ArgusCoordsys.rot)
        errordlg('You did not enter a number for Argus rotation angle', 'Error');
        error('You did not enter a number for Argus rotation angle');
    end
        
    guidata(hObject,handles)
end
% 13a. Callback Xmin
function editXmin_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    hEditXmin = findobj('tag', 'edit13a');
    handles.inputs.rectxy(1) = str2double(hEditXmin.String);
    
    if isempty(handles.inputs.rectxy(1)) || isnan(handles.inputs.rectxy(1))
        errordlg('You did not enter a number for Xmin', 'Error');
        error('You did not enter a number for Xmin');
    end
        
    guidata(hObject,handles)
end
% 13b. Callback Xmax
function editXmax_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    hEditXmax = findobj('tag', 'edit13b');
    handles.inputs.rectxy(3) = str2double(hEditXmax.String);
    
    if isempty(handles.inputs.rectxy(3)) || isnan(handles.inputs.rectxy(3))
        errordlg('You did not enter a number for Xmax', 'Error');
        error('You did not enter a number for Xmax');
    end
        
    guidata(hObject,handles)
end
% 13c. Callback dX
function editdX_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    hEditdX = findobj('tag', 'edit13c');
    handles.inputs.rectxy(2) = str2double(hEditdX.String);
    
    if isempty(handles.inputs.rectxy(2)) || isnan(handles.inputs.rectxy(2))
        errordlg('You did not enter a number for dX', 'Error');
        error('You did not enter a number for dX');
    end
        
    guidata(hObject,handles)
end
% 14a. Callback Ymin
function editYmin_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    hEditYmin = findobj('tag', 'edit14a');
    handles.inputs.rectxy(4) = str2double(hEditYmin.String);
    
    if isempty(handles.inputs.rectxy(4)) || isnan(handles.inputs.rectxy(4))
        errordlg('You did not enter a number for Ymin', 'Error');
        error('You did not enter a number for Ymin');
    end
        
    guidata(hObject,handles)
end
% 14b. Callback Ymax
function editYmax_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    hEditYmax = findobj('tag', 'edit14b');
    handles.inputs.rectxy(6) = str2double(hEditYmax.String);
    
    if isempty(handles.inputs.rectxy(6)) || isnan(handles.inputs.rectxy(6))
        errordlg('You did not enter a number for Ymax', 'Error');
        error('You did not enter a number for Ymax');
    end
        
    guidata(hObject,handles)
end
% 14c. Callback dY
function editdY_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    hEditdY = findobj('tag', 'edit14c');
    handles.inputs.rectxy(5) = str2double(hEditdY.String);
    
    if isempty(handles.inputs.rectxy(5)) || isnan(handles.inputs.rectxy(5))
        errordlg('You did not enter a number for dY', 'Error');
        error('You did not enter a number for dY');
    end
        
    guidata(hObject,handles)
end
% 15. Callback Z-level
function editZlevel_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    hEditZlevel = findobj('tag', 'edit15');
    handles.inputs.rectz = str2double(hEditZlevel.String);
    
    if isempty(handles.inputs.rectz) || isnan(handles.inputs.rectz)
        errordlg('You did not enter a number for Z-level', 'Error');
        error('You did not enter a number for Z-level');
    end
        
    guidata(hObject,handles)
end


%% Functions Tab2

% 16. Callback Camera Name
function popupCam_Callback(hObject, eventdata)
    handles = guidata(hObject);
    
    hpopup = findobj('tag', 'popupCam');
    val = hpopup.Value; 
    string = hpopup.String;
    handles.inputs.cameraName = string{val};
    
    % disable get if cameraName is 'custom' and enable save and load
    % buttons
    hButtonGet = findobj('tag','buttonGet');
    hButtonSave = findobj('tag','buttonSave');
    hButtonLoad = findobj('tag','buttonLoad');
    if strcmp(string{val},'custom')
        hButtonGet.Enable = 'off';
        hButtonSave.Enable = 'on';
        hButtonLoad.Enable = 'on';
    else
        hButtonGet.Enable = 'on';
        hButtonSave.Enable = 'off';
        hButtonLoad.Enable = 'off';
    end
    
    guidata(hObject,handles)
end
% 17. Callback Camera Resolution
function editUpixels_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    hUpix = findobj('tag', 'edit17a');
    handles.inputs.cameraRes(1) = str2double(hUpix.String);
    
    if isempty(handles.inputs.cameraRes(1)) || isnan(handles.inputs.cameraRes(1))
        errordlg('You did not enter a number for # U pixels', 'Error');
        error('You did not enter a number for # U pixels');
    end
    
    guidata(hObject,handles)
end
function editVpixels_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    hVpix = findobj('tag', 'edit17b');
    handles.inputs.cameraRes(2) = str2double(hVpix.String);
    
    if isempty(handles.inputs.cameraRes(2)) || isnan(handles.inputs.cameraRes(2))
        errordlg('You did not enter a number for # V pixels', 'Error');
        error('You did not enter a number for # V pixels')
    end
    
    guidata(hObject,handles)
end
% 18. Callback Get intrinsic camera parameters
function buttonCamInt_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    % Image size
    NU = handles.inputs.cameraRes(1);
    NV = handles.inputs.cameraRes(2);
    
    % Get camera lens calibration parameters (intrinsic)
    handles.camInt = makeLCPP3(handles.inputs.cameraName, NU, NV);
    
    % Fill table
    htableCamInt = findobj('tag', 'tableCamInt');
    htableCamInt.Data(:,1) = {sprintf(' %.2f',handles.camInt.fx) ...
        sprintf(' %.2f',handles.camInt.fy) ...
        sprintf(' %.2f',handles.camInt.c0U) ...
        sprintf(' %.2f',handles.camInt.c0V) ...
        sprintf(' %.2f',handles.camInt.d1) ...
        sprintf(' %.2f',handles.camInt.d2) ...
        sprintf(' %.2f',handles.camInt.d3) ...
        sprintf(' %.2f',handles.camInt.t1) ...
        sprintf(' %.2f',handles.camInt.t2) ...
        };
    
    guidata(hObject,handles)
end
% 18b. Callback Save camera
function buttonSave_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    % Retrieve data from table and put into structure customLCP
    htableCamInt = findobj('tag', 'tableCamInt');
    camInt_vec = str2double(htableCamInt.Data(:,1));
    customLCP.fx = camInt_vec(1);
    customLCP.fy = camInt_vec(2);
    customLCP.c0U = camInt_vec(3);
    customLCP.c0V = camInt_vec(4);
    customLCP.d1 = camInt_vec(5);
    customLCP.d2 = camInt_vec(6);
    customLCP.d3 = camInt_vec(7);
    customLCP.t1 = camInt_vec(8);
    customLCP.t2 = camInt_vec(9);
    
    hUpix = findobj('tag', 'edit17a');
    customLCP.NU = str2double(hUpix.String);
    if isempty(customLCP.NU) || isnan(customLCP.NU)
        errordlg('You did not enter a number for # U pixels', 'Error');
        error('You did not enter a number for # U pixels');
    end
    hVpix = findobj('tag', 'edit17b');
    customLCP.NV = str2double(hVpix.String);
    if isempty(customLCP.NV) || isnan(customLCP.NV)
        errordlg('You did not enter a number for # V pixels', 'Error');
        error('You did not enter a number for # V pixels');
    end
    
    customLCP = makeRadDist(customLCP);
    customLCP = makeTangDist(customLCP);
    
    % Ask user for filename and folder
    [baseFn, folder] = uiputfile('*.mat', 'Save your camera LCP file (.mat)');
    fileName = fullfile(folder,baseFn);
    save(fileName,'customLCP')
    
    guidata(hObject,handles)
end
% 18c. Callback Load camera
function buttonLoad_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    % Ask user to load camera file
    [baseFn, folder] = uigetfile('*.mat', 'Load your camera LCP file (.mat)');
    fileName = fullfile(folder,baseFn);
    load(fileName);
    
    % Fill table
    htableCamInt = findobj('tag', 'tableCamInt');
    htableCamInt.Data(:,1) = {sprintf(' %.2f',customLCP.fx) ...
        sprintf(' %.2f',customLCP.fy) ...
        sprintf(' %.2f',customLCP.c0U) ...
        sprintf(' %.2f',customLCP.c0V) ...
        sprintf(' %.2f',customLCP.d1) ...
        sprintf(' %.2f',customLCP.d2) ...
        sprintf(' %.2f',customLCP.d3) ...
        sprintf(' %.2f',customLCP.t1) ...
        sprintf(' %.2f',customLCP.t2) ...
        };
    
    hEdit17a = findobj('tag','edit17a');
    hEdit17b = findobj('tag','edit17b');
    hEdit17a.String = num2str(customLCP.NU);
    hEdit17b.String = num2str(customLCP.NV);
    
    guidata(hObject,handles)
end
% 21. Button Get extrinsic camera parameters from EXIF
function buttonCamExt_CallBack(hObject, eventdata)
    handles = guidata(hObject);

    % Select snapshot containing the geotags
    [filename, pathname] = uigetfile('*.jpg', 'Select the Snapshot');

    % Extract exttrinsic camera parameters (exiftool)
    
    % Get data/time variables
    [handles.inputs.dateVect handles.inputs.GMT] = getTimestamp([pathname filename]);
    handles.inputs.dn0 = datenum(handles.inputs.dateVect) - str2double(handles.inputs.GMT)/24;
    handles.inputs.dayFn = argusDay(matlab2Epoch(handles.inputs.dn0));
    
    % Get FOV (field of view) for calculating horizon
    handles.inputs.FOV = getFOV([pathname filename]);
    
    % if localCoords flag is off
    if ~handles.inputs.localCoords
        % Use EPSG code to convert from lat/lon (WGS84) to local coordsys
        handles.camExt = getExtrinsicParam([pathname filename],...
            handles.inputs.ArgusCoordsys.EPSG); 
        
        % Fill table
        htableCamExt = findobj('tag', 'tableCamExt');
        htableCamExt.Data(:,1) = {sprintf(' %.2f',handles.camExt.camX) ...
            sprintf(' %.2f',handles.camExt.camY) ...
            sprintf(' %.2f',handles.camExt.camZ) ...
            sprintf(' %.2f',handles.camExt.camYaw) ...
            sprintf(' %.2f',handles.camExt.camPitch + 90) ...
            sprintf(' %.2f',handles.camExt.camRoll)};     
    end
    
    % Display snapshot
    I = imread(fullfile(pathname, filename));
    hAxesTab2 = findobj('Tag', 'axesTab2');
    imagesc(I, 'Parent', hAxesTab2);
    hAxesTab2.DataAspectRatio = [1 1 1];
    title(hAxesTab2, ['Snapshot from ' handles.inputs.stationStr ' ' ...
        datestr(handles.inputs.dateVect) ' GMT ' ...
        handles.inputs.GMT] , 'fontweight', 'normal', 'fontsize' , 11);
    hAxesTab2.XTick = [];
    hAxesTab2.YTick = [];
    hAxesTab2.Tag = 'axesTab2';
    
    guidata(hObject,handles)
end
% 23. Callback Button 'Save initial settings and continue'
function buttonFinishedInit_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    % Load gcp structure
    try
        gcpFile = load(handles.inputs.gcpFn);
    catch
        errordlg('gcpFile could not be loaded! Check filename and try again.', 'Error');
        error('gcpFile could not be loaded! Check filename and try again.');
    end
    
    handles.gcp = gcpFile.gcp;
    
    % if localCoords flag is off, convert from world to argus
    if ~handles.inputs.localCoords
        
        % Convert gcps from world to Argus coordinates
        argusOrigin = [handles.inputs.ArgusCoordsys.X0, ...
            handles.inputs.ArgusCoordsys.Y0, ...
            handles.inputs.ArgusCoordsys.Z0];
        
        argusRotation = handles.inputs.ArgusCoordsys.rot;
        
        for i = 1:length(handles.gcp)
            
            coord = [handles.gcp(i).x handles.gcp(i).y handles.gcp(i).z];
            
            % convert from world to argus
            xyzArg = local2Argus(coord, argusOrigin, argusRotation);
            % update the values in gcp structure
            handles.gcp(i).x = xyzArg(1);
            handles.gcp(i).y = xyzArg(2);
            handles.gcp(i).z = xyzArg(3);
        end
        
    end
    
    % Lens calibration camera parameters (get table values)
    htableCamInt = findobj('tag', 'tableCamInt');
    camInt_vec = str2double(htableCamInt.Data(:,1));
    handles.camInt.fx = camInt_vec(1);
    handles.camInt.fy = camInt_vec(2);
    handles.camInt.c0U = camInt_vec(3);
    handles.camInt.c0V = camInt_vec(4);
    handles.camInt.d1 = camInt_vec(5);
    handles.camInt.d2 = camInt_vec(6);
    handles.camInt.d3 = camInt_vec(7);
    handles.camInt.t1 = camInt_vec(8);
    handles.camInt.t2 = camInt_vec(9);
    
    hUpix = findobj('tag', 'edit17a');
    handles.camInt.NU = str2double(hUpix.String);
    if isempty(handles.camInt.NU) || isnan(handles.camInt.NU)
        errordlg('You did not enter a number for # U pixels', 'Error');
        error('You did not enter a number for # U pixels');
    end
    hVpix = findobj('tag', 'edit17b');
    handles.camInt.NV = str2double(hVpix.String);
    if isempty(handles.camInt.NV) || isnan(handles.camInt.NV)
        errordlg('You did not enter a number for # V pixels', 'Error');
        error('You did not enter a number for # V pixels');
    end
    handles.camInt = makeRadDist(handles.camInt);
    handles.camInt = makeTangDist(handles.camInt);
    
    % Initial geometries (get from table values)
    htableCamExt = findobj('tag', 'tableCamExt');
    camExt_vec = str2double(htableCamExt.Data(:,1));
    handles.camExt.camX = camExt_vec(1);
    handles.camExt.camY = camExt_vec(2);
    handles.camExt.camZ = camExt_vec(3);
    handles.camExt.camRoll = camExt_vec(6);
    handles.camExt.camTilt= camExt_vec(5);
    handles.camExt.camYaw = camExt_vec(4);
    
    % if localCoords flag is off, convert from world to argus
    if ~handles.inputs.localCoords
        % Convert initial geometry from Local to Argus coordinates
        coord = camExt_vec(1:3)';
        xyzArg = local2Argus(coord, argusOrigin, argusRotation);
    
        % Subtract Argus rotation to Azimuth angle
        az_corrected = handles.camExt.camYaw - argusRotation;
        
        % Fill inputs structure
        handles.inputs.xyCam = xyzArg([1 2]);
        handles.inputs.zCam = handles.camExt.camZ - handles.inputs.ArgusCoordsys.Z0;
        handles.inputs.azTilt = [az_corrected handles.camExt.camTilt] / 180*pi;
        handles.inputs.roll = handles.camExt.camRoll / 180*pi;
    else
        handles.inputs.xyCam = [handles.camExt.camX handles.camExt.camY];
        handles.inputs.zCam = handles.camExt.camZ;
        handles.inputs.azTilt = [handles.camExt.camYaw handles.camExt.camTilt] / 180*pi;
        handles.inputs.roll = handles.camExt.camRoll / 180*pi;     
    end
    
    % Get knownFlags from table ticks
    handles.inputs.knownFlags = not([htableCamExt.Data{:,3}]);
    
    % processing parameters
    bs = [handles.inputs.xyCam handles.inputs.zCam handles.inputs.azTilt handles.inputs.roll];
    handles.inputs.beta0 = bs(find(~handles.inputs.knownFlags));
    handles.inputs.knowns = bs(find(handles.inputs.knownFlags));
    
    % Perform some checks
    if isempty(dir(fullfile(handles.inputs.pnIn, [handles.inputs.frameFn '*'])))
        errordlg(sprintf('%s \n %s \n %s', 'Frames could not be found. Verify the following fields:', 'Input folder', 'Frames suffix'), 'Error')
        error('Frames could not be found. Verify the following fields: Input folder, Frames suffix')
    end
    
    % Save inputs structure in a log file (.mat)
    inputs = handles.inputs;
    save(fullfile(handles.inputs.pncx,...
        ['log_input' datestr(now, 'yyyymmdd_HHMMSS') '.mat']), 'inputs')
    
    hbuttonFinishedInit = findobj('Tag', 'buttonFinishedInit');
    hbuttonFinishedInit.BackgroundColor = [0.94 0.94 0.94];
    %hbuttonFinishedInit.Enable = 'off';
    
    guidata(hObject,handles)
end


%% Functions Tab3

function buttonFirstframe_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    % Initialize a UAV movie analysis using the first frame.
    % Replaces initUAVAnalysis.m
    
    % Load GCPs
    inputs = handles.inputs;
    try
        gcp = handles.gcp;
    catch
        errordlg('Save initial settings on Tab 2 (green button) before going to Tab 3!', 'Error')
        error('Save initial settings on Tab 2 (green button) before going to Tab 3!')
    end
    
    htextCommand1 = findobj('Tag', 'textCommand1');
    htextCommand2 = findobj('Tag', 'textCommand2');
    hAxesTab3 = findobj('Tag', 'axesTab3');
    hFirstFrame = findobj('Tag', 'firstframe');
    hFirstFrame.Enable = 'off';
    
    % Start first frame analysis
    
    e0 = matlab2Epoch(inputs.dn0);
    % create clipFns, a structure with all the images filenames
    clipFns = dir(fullfile(inputs.pnIn, [inputs.frameFn '*']));
    NClips = length(clipFns);

    % read the first frame
    I = imread(fullfile(inputs.pnIn, clipFns(1).name));
    
    % Fill meta structure
    meta.showFoundRefPoints = inputs.showFoundRefPoints;
    meta.globals.lcp = handles.camInt;
    meta.globals.knownFlags = inputs.knownFlags;
    meta.globals.knowns = inputs.knowns;
    
    % Image dimensions
    NU = meta.globals.lcp.NU;
    NV = meta.globals.lcp.NV;
    lcp = meta.globals.lcp;
    
    % When geometries are solved for each frame in turn, the results are saved
    % in a metadata file in the cx folder for this day.  First search to see if
    % such a folder already exists, in which we don't have to re-do all of the
    % geometries.  Allow a few second slop in time (look for first 9 out of 10
    % digits in epoch time.
    bar = num2str(e0);
    foo = dir(fullfile(inputs.pncx,[ bar(1:9) '*meta*']));
    if ~isempty(foo)
        useMeta = questdlg(['Found old metadata ' foo(1).name ' , would you like to use it?'],...
            'Metadata',...
            'Yes', 'No, start over', 'Yes');
        if ~strcmpi(useMeta, 'Yes')
            foo = [];
        end
    end
    % if using the old meta data
    if ~isempty(foo)
        % flag that old geoms exist and is loaded
        oldGeoms = 1;           
        load(fullfile(inputs.pncx, foo(1).name));
        betas = meta.betas;
        htextCommand1.String = ['Old metadata loaded: ' foo(1).name];
        htextCommand2.String = '';
        
        % Show gcps and refpoints of metadata loaded
        imagesc(I, 'Parent', hAxesTab3);
        axis image
        % Show GCPs
        plot(hAxesTab3, meta.gcpUV_clicked(:,1), meta.gcpUV_clicked(:,2), 'go', 'markerfacecolor', 'g', 'markersize', 3)
        plot(hAxesTab3, meta.gcpUV_computed(:,1),meta.gcpUV_computed(:,2),'ro')
        % Show refPoints
        for i = 1:length(meta.refPoints)
            hrectangle = patch([meta.refPoints(i).bBox(1,1) meta.refPoints(i).bBox(2,1),...
                meta.refPoints(i).bBox(2,1) meta.refPoints(i).bBox(1,1)],...
                [meta.refPoints(i).bBox(1,2) meta.refPoints(i).bBox(1,2),...
                meta.refPoints(i).bBox(2,2) meta.refPoints(i).bBox(2,2)],...
                [0 1 0], 'Parent', hAxesTab3);
            hrectangle.EdgeColor = 'y';
            hrectangle.FaceAlpha = 0;
            hrectangle.LineWidth = 1.5;
            plot(hAxesTab3, meta.refPoints(i).Ur, meta.refPoints(i).Vr, 'b.', 'markersize', 10)
            plot(hAxesTab3, meta.refPoints(i).UV_ref(:,1), meta.refPoints(i).UV_ref(:,2), 'ko', 'markersize', 5)
        end
    
    % if no metafile is found
    else 
        oldGeoms = 0;
        betas = nan(NClips, 6); % contains the computed geometries
        MSE = nan(NClips,1);    % contains the MSE for the computed geometries
        CI = nan(2, 6, NClips); % contains the confidence intervals for the computed geometries
        
        % Stage 1: displays the frame and asks user to ginput the locations of points
        % specified in gcpUseList whose locations and id are in gcps structure.
        % The nonlinear fit is seeded with 6 dof beta0 = [xyzCam azimuth tilt, roll]
        % with angles in radians.
        % Returns the best fit geometry beta6 dof.
           
        % NOTE - lcp, NU and NV are passed in meta but are made global for nlinfit.
        % this is only used for output to findUVnDOF
        
        global globs
        globs = meta.globals;
        
        % Gcp locations
        nGcps = length(inputs.gcpList);
        x = [gcp(inputs.gcpList).x];
        y = [gcp(inputs.gcpList).y];
        z = [gcp(inputs.gcpList).z];
        xyz = [x' y' z'];

        imagesc(I, 'Parent', hAxesTab3);
        axis image
        % Digitize position of each gcp in gcpList
        
        htextCommand1.String = ['Computing geometry using ' num2str(nGcps) ' control points...'...
            ' zoom in and press any key when ready to click'];
              
        for i = 1: nGcps  
            htextCommand2.String = (['Digitize ' gcp(inputs.gcpList(i)).name]);
            zoom on;
            pause() % you can zoom with your mouse and when your image is okay, you press any key
            zoom off;
            UV(i,:) = ginput(1);
            hold on
            plot(hAxesTab3, UV(i,1),UV(i,2),'go', 'markerfacecolor', 'g', 'markersize', 3);
            zoom out
        end
        
        % Find best fit geometry (extrinsic parameters)
        options.Tolfun = 1e-12;
        options.TolX = 1e-12;
        try
            % Non-linear fit, output geometry, residuals, covariance matrix and mse
            [beta, R, ~, CovB, mse, ~] = ....
                nlinfit(xyz, [UV(:,1); UV(:,2)], 'findUVnDOF', inputs.beta0, options);
        catch
            errordlg('Could not compute geometry with the given GCPs', 'Error');
            error('Could not compute geometry with the given GCPs');
        end
        
        % Compute confidence intervals for each of the fitted parameters
        ci = nlparci(beta, R, 'covar', CovB);
        
        % Fill 1st Beta
        beta6DOF = nan(1,6);
        beta6DOF(find(globs.knownFlags)) = globs.knowns;
        beta6DOF(find(~globs.knownFlags)) = beta;
        betas(1,:) = beta6DOF;
        
        % Fill 1st CI
        ci6DOF = nan(2,6);
        ci6DOF(:, find(globs.knownFlags)) = zeros(2,length(globs.knowns));
        ci6DOF(:, find(~globs.knownFlags)) = ci';
        CI(:,:,1) = ci6DOF;
        
        % Fill 1st MSE
        MSE(1) = mse;
        
        % Plot gcps transformed in image coordinates by the fitted geometry
        UV_computed = findUVnDOF(betas(1,:), xyz, globs);
        UV_computed = reshape(UV_computed,[],2);
        plot(hAxesTab3, UV_computed(:,1),UV_computed(:,2),'ro');
        
        % Plot checkpoints : GCPs that were not used to compute geometry
        cmap = hsv(length(gcp));
        for i = 1:length(gcp)
            if ~ismember(gcp(i).num, inputs.gcpList)
                UV_checkpoint = findUVnDOF(betas(1,:), [gcp(i).x gcp(i).y gcp(i).z], meta.globals);
                UV_checkpoint = round(reshape(UV_checkpoint,[],2));
                plot(hAxesTab3, UV_checkpoint(:,1), UV_checkpoint(:,2), '+', 'Color', cmap(i,:), 'Markersize', 6, 'Tag', 'checkpoints');
                text(UV_checkpoint(:,1) + 5, UV_checkpoint(:,2), gcp(i).name, ....
                    'Color', cmap(i,:), 'Fontsize', 9, 'Parent', hAxesTab3, 'Tag', 'checkpoints');
            end
        end
        
        % Horizon part ( from Argus code )
        
        % Jacobian might be ill-suited and produce an error in nlinfit in findUVnDOF
        % So use try/catch structure
        try 
            
            % Compute horizon
            rho = pi/180; % degrees to radians
            FOV = inputs.FOV*rho;
            daz = -FOV/2:FOV/100:FOV/2;
            az = beta6DOF(4) + daz;
            [xh, yh, zh] = findHorizon(betas(1,1), betas(1,2),...
                betas(1,3), az(:) );
            
            % Plot horizon
            UV_horizon = findUVnDOF(betas(1,:), [xh yh zh], meta.globals);
            UV_horizon = round(reshape(UV_horizon,[],2));
            UV_horizon(isnan(UV_horizon(:,1)),:) = [];
            UV_horizon(UV_horizon(:,1) < 1 | ...
                UV_horizon(:,1) > NU , : ) = [];
            UV_horizon(UV_horizon(:,2) < 1 | ...
                UV_horizon(:,2) > NV , : ) = [];
            plot(hAxesTab3, UV_horizon(:,1), UV_horizon(:,2),...
                'm-.', 'linewidth', 1,...
                'Tag', 'hrz_line');
            
        catch
            msgbox('Horizon could not be computed.')
            zoom out;
        end
        
        htextCommand1.String = 'Geometry computed. If the green dots are surrounded by red circles, geometry fit is ok.';
        htextCommand2.String = [sprintf('RMSE = %.2f pixels\n', sqrt(mse)) 'Press any key to continue'];
        
        zoom out;
        zoom on;
        pause() % you can zoom with your mouse and when your image is okay, you press any key
        zoom off;
        zoom out;
        
        % Print in output directory a screenshot of the GCPs used
        hFig = figure;
        hAxes = copyobj(hAxesTab3,hFig); % Copy axes object into figure
        set(gca,'units','normalized','position',[0 0 1 1])
        axis on
        hAxes.XTickLabel = [];
        hAxes.YTickLabel = [];
        hAxes.Title.String = 'GCPs used';
        print(hFig, fullfile(inputs.pncx, 'GCPsUsed'), '-djpeg', '-r300')
        delete(hFig);
        
        % Stage 2 is the creation of reference points, each expressed in
        % a structure. User is aked to define a bounding box in which a bright or dark Center
        % of Mass (COM) will define the position of the reference point in all the frames.
     
        % Use gray-scale image
        delete(findobj('Tag','checkpoints'));
        Ig = rgb2gray(I);
        imagesc(Ig, 'Parent', hAxesTab3);
        axis image
        colormap(hAxesTab3, 'gray')
        
        htextCommand1.String = ['Identify ' num2str(inputs.nRefs) ' reference points ... '...
            ' Pick features brighter/darker than their surroundings.'...
            ' Ensure that the first is the '...
            'most isolated from nearby objects and give an adequate buffer '...
            'to allow for inter-frame aim point wander.'];
        
        
        % Select each reference point
        i = 1;
        while i <= inputs.nRefs
            
            htextCommand2.String = ['Refpoint ' num2str(i) '/' num2str(inputs.nRefs) ' ... ' 'Zoom in and press any key when ready to click, then pick top left and bottom right corner of bounding box (2 clicks).'];
           
            zoom on;
            pause()   % zoom with your mouse and when your image is okay, you press any key
            zoom off; % to escape the zoom mode
            
            % Pick top left and bottom right corner of bounding box (bBox)
            bBox = ginput(2);
            
            
            if bBox(1,1) > bBox(2,1) || bBox(1,2) > bBox(2,2)
                errordlg(sprintf('%s \n %s \n %s','Bounding box was not selected properly!',...
                    'First click on the top-left corner and then on the botton-right corner.',...
                    'Press any key to repeat selection'), 'Error')
                continue
            end
             
            zoom out;
            % Plot bounding box
            hrectangle = patch([bBox(1,1) bBox(2,1) bBox(2,1) bBox(1,1)],...
                [bBox(1,2) bBox(1,2) bBox(2,2) bBox(2,2)],...
                [0 1 0], 'Parent', hAxesTab3);
            hrectangle.EdgeColor = 'y';
            hrectangle.FaceAlpha = 0;
            hrectangle.LineWidth = 1.5;
            refPoints(i).bBox = bBox;
            
            % Choose if you want a bright or dark reference point
            refpointType = questdlg('Is this a bright or dark contrast reference point?',...
            'Reference point type',...
            'Bright', 'Dark', 'Bright');
        
            switch refpointType
                case 'Bright'
                    refPoints(i).type = 'b';
                case 'Dark'
                    refPoints(i).type = 'd';
            end
            
            % Select threshold for Center Of Mass (COM)
            [refPoints(i).Ur, refPoints(i).Vr, refPoints(i).thresh, refPoints(i).zRef] = GUIfindCOMRefObjFirstPass(Ig, bBox, refPoints(i).type);
            
            % Update refPoints struct with world coordinates (xyz) of refpoint and
            % extent of the bounding box in pixels(dUV).
            refPoints(i).dUV = round(diff(bBox)/2);
            refPoints(i).xyz = findXYZ6dof(refPoints(i).Ur, refPoints(i).Vr, refPoints(i).zRef, ...
                beta6DOF, meta.globals.lcp);
            
            % Plot refPoint
            plot(hAxesTab3, refPoints(i).Ur, refPoints(i).Vr, 'b.', 'markersize', 10)
            
            refPoints(i).UV_ref = findUVnDOF(beta, refPoints(i).xyz, globs);
            refPoints(i).UV_ref = reshape(refPoints(i).UV_ref,[],2);
            plot(hAxesTab3, refPoints(i).UV_ref(:,1), refPoints(i).UV_ref(:,2), 'ko', 'markersize', 5)
            
            i = i + 1;
        end
    end
        
    % Save meta structure (if not already there)
    if  oldGeoms==0
        info.time = e0; info.station = inputs.stationStr; info.camera = 'x';
        info.type = 'meta'; info.format = 'mat';
        metaFn = argusFilename(info);
        meta.gcpFn = inputs.gcpFn; 
        meta.gcpList = inputs.gcpList;
        meta.betas = betas;
        meta.CI = CI;
        meta.MSE = MSE;
        meta.refPoints = refPoints;
        meta.gcpUV_clicked = UV;
        meta.gcpUV_computed = UV_computed;
        save(fullfile(inputs.pncx, metaFn),'meta')
        htextCommand1.String = ['First frame processing finished. Metadata saved in output directory : ' metaFn] ;
        htextCommand2.String = '';
    end
    
    % Print in output directory a screenshot of the GCPs and refPoints used
    hFig = figure;
    hAxes = copyobj(hAxesTab3,hFig); % Copy axes object into figure
    set(gca,'units','normalized','position',[0 0 1 1])
    axis on
    hAxes.XTickLabel = [];
    hAxes.YTickLabel = [];
    hAxes.Title.String = 'GCPs and reference points used';
    print(hFig, fullfile(inputs.pncx, 'GCPsandRefpoints'), '-djpeg', '-r300')
    delete(hFig);

    % Save in handles structure
    handles.meta = meta;    
    handles.oldGeoms = oldGeoms;
    
    % Enable bactch pixelInsts
    hPixelInsts = findobj('Tag', 'pixelInsts');
    hPixelInsts.Enable = 'on';
    
    guidata(hObject,handles)
end

function buttonPixelInsts_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    % Add path to PIXel-Toolbox
    str = which('GUIforUAVtoolbox.m');
    index = regexp(str, filesep);
    gitDir = str(1:index(end-2));
    pathPIX = fullfile(gitDir, 'PIXel-Toolbox');
    addpath(genpath(pathPIX))
    % Check if path was properly added, otherwise ask user to select folder
    % containing the PIXel-Toolbox
    if isempty(which('PIXAddLine.m'))
        pathPIX = uigetdir(gitDir, 'Select folder containing the PIXel-Toolbox');
        addpath(genpath(pathPIX))
    end
    
    htextCommand1 = findobj('Tag', 'textCommand1');
    htextCommand2 = findobj('Tag', 'textCommand2');
    hAxesTab3 = findobj('Tag', 'axesTab3');
    
    inputs = handles.inputs;
    meta = handles.meta;
    betas = meta.betas;
    clipFns = dir(fullfile(inputs.pnIn, [inputs.frameFn '*']));
    I = imread(fullfile(inputs.pnIn, clipFns(1).name));
    [NV, NU, NC] = size(I);

    global globs
    globs = meta.globals;

    % Load InstsFile and show the pixel instruments on first frame
    p = pwd;
    idx_filesep = strfind(inputs.instsFn, filesep);
    eval(['cd ' inputs.instsFn(1:idx_filesep(end)-1)]);
    instfile_name = inputs.instsFn(idx_filesep(end)+1:end);
    idx_format = strfind(inputs.instsFn(idx_filesep(end)+1:end), '.');
    instfile_name = instfile_name(1:idx_format-1);
    eval(['r = ' instfile_name ' ;'] );
    eval(['cd ' p]);
    
    clear p idx_filesep idx_format instfile_name
    
    % set up instruments and stacks for PIXel toolbox
    [geom, cam, ip] = lcpBeta2GeomCamIp( meta.globals.lcp, betas(1,:) );
    r = PIXParameterizeR( r, cam, geom, ip );
    r = PIXRebuildCollect( r );
    
    % Plot pixel instruments
    diff_insts = unique(r.names);
    n_insts = length(diff_insts);
     
    cmap = hsv(n_insts);
    imagesc(I, 'Parent', hAxesTab3)
    for i = 1: n_insts
        label_insts = strcmp(r.names,diff_insts{i});
        U_insts = r.cams.U(label_insts);
        V_insts = r.cams.V(label_insts);
        plot(hAxesTab3, U_insts,V_insts,'.', 'color', cmap(i,:))
    end
    xlim(hAxesTab3, [0 NU])
    ylim(hAxesTab3, [0 NV])
    
    htextCommand1.String = 'Are you happy with the pixel instruments?';
    textX = sprintf(' If yes: press the Batch processing button. \n If not: modify the InstsFile and press the Pixel instruments button to replot.'); 
    htextCommand2.String = textX;
      
    handles.insts = r;
    
    % Enable bactch processing button
    hBatchprocessing = findobj('Tag', 'batchprocessing');
    hBatchprocessing.Enable = 'on';
    
    guidata(hObject,handles)
end

function buttonBatch_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    % Disable bactch pixelInsts
    hPixelInsts = findobj('Tag', 'pixelInsts');
    hPixelInsts.Enable = 'off';
    
    % This button processes the remaining frames and saves the outputs
    
    htextCommand1 = findobj('Tag', 'textCommand1');
    htextCommand2 = findobj('Tag', 'textCommand2');
    hAxesTab3 = findobj('Tag', 'axesTab3');
    
    inputs = handles.inputs;
    gcp = handles.gcp;
    meta = handles.meta;
    r = handles.insts;
    betas = meta.betas;
    CI = meta.CI;
    MSE = meta.MSE;
    oldGeoms = handles.oldGeoms;
    
    global globs currentAxes
    globs = meta.globals;
    currentAxes = hAxesTab3;
    
    % Print in output directory a screenshot of the pixel instruments used
    hFig = figure;
    hAxes = copyobj(hAxesTab3,hFig); % Copy axes object into figure
    set(gca,'units','normalized','position',[0 0 1 1])
    axis on
    hAxes.XTickLabel = [];
    hAxes.YTickLabel = [];
    hAxes.Title.String = 'Pixel instruments used';
    print(hFig, fullfile(inputs.pncx, 'PixelInstruments'), '-djpeg', '-r300')
    delete(hFig);
    
    e0 = matlab2Epoch(inputs.dn0);
    
    % create clipFbns, a structure with all the images filenames
    clipFns = dir(fullfile(inputs.pnIn, [inputs.frameFn '*']));
    NClips = length(clipFns);

    % Create vector dn which contains the time-stamps in datanum
    dn = datenum(inputs.dateVect) + ([1:NClips]-1)*inputs.dt;
    % read the first frame
    I = imread(fullfile(inputs.pnIn, clipFns(1).name));
    [NV, NU, NC] = size(I);
    Ig = rgb2gray(I);
      
    htextCommand1.String = 'Batch processing started...';
    htextCommand2.String = '';
    
    % Disable bactch processing button
    hBatchprocessing = findobj('Tag', 'batchprocessing');
    hBatchprocessing.Enable = 'off';
     
    % save the info in the stacks structure.
    stack.r = r;
    nPix = size(r.cams(1).U, 1);
    stack.data = nan(NClips, nPix, 1 );
    
    % if betas contains any NaNs, geomeries have to be done again. oldGeoms
    % is put to 0.
    if sum(sum(isnan(betas))) ~= 0
        oldGeoms = 0;
    end
    
    % Now sample the frames at the pixels indicated by insts, starting with the first. 
    % data is a structure with the data for each pixel instrument.
    data = sampleDJIFrame(r, Ig, betas(1,:), meta.globals); % fill first frame
    stack.data(1,:) = data';

    
    % Create images structure which contains Argus image products 
    % (timex, bright, dark)
    if inputs.doImageProducts
        images.xy = inputs.rectxy;
        images.z = inputs.rectz;
        images = buildRectProducts(dn(1), images, I, betas(1,:), meta.globals);
    end
    
    % Set some counters
    tic;
    nTic = 5;
    lastToc = toc;
    failFlag = 0;
    
    % Main loop on the frames
    for clip = 2: NClips
        
        % Display remaining time
        if( mod(clip,nTic) == 0 )
            tottoc = toc;
            pftoc = (tottoc-lastToc)/nTic;
            lastToc = tottoc;
            left = (NClips-clip)*toc/clip;
            leftm = floor(left/60);
            lefts = floor(left-leftm*60);
            htextCommand2.String = sprintf('Frames: %4d/%d -  total time: %6.1fs -  time per frame: %.2fs -  remaining time: %2d:%02d\r', ...
                clip, NClips, tottoc, pftoc, leftm, lefts);
            pause(0.001)
        end
        
        % Read a new frame and find the new geometry, betas, and save in
        % matrix.  Then sample both the stacks and build the image
        % products.
        I = imread(fullfile(inputs.pnIn, clipFns(clip).name));
        Ig = double(rgb2gray(I));
        
        % Compute geometries if oldGeoms = 0
        if ~oldGeoms
            cla(hAxesTab3, 'reset')
            [beta1, ~, ~, failFlag, ci, mse] = ...
                GUIfindNewBeta(Ig, betas(clip-1, ~meta.globals.knownFlags), meta);
            if failFlag         % deal with end of useable run
                break
            else
                betas(clip,:) = beta1;
                CI(:,:,clip) = ci;
                MSE(clip) = mse;
            end
        end
        
        % must redo r for each new beta
        [geom, cam, ip] = lcpBeta2GeomCamIp( meta.globals.lcp, betas(clip,:) );
        r = PIXParameterizeR( r, cam, geom, ip );
        r = PIXRebuildCollect( r );

        data = sampleDJIFrame(r, Ig, betas(clip,:), meta.globals);
        stack.data(clip,:) = data';        
        
        % Create images structure which contains Argus image products
        if inputs.doImageProducts
            images = buildRectProducts(dn(clip), images, double(I), ...
                betas(clip,:), meta.globals);
        end
        
    end
    
    if inputs.doImageProducts
        finalImages = makeFinalImages(images);
    end
    finalImages.snap = imread(fullfile(inputs.pnIn, clipFns(1).name));

    % Warning if geometry failed
    if failFlag
        htextCommand1.String = 'Batch processing interrupted.';
        htextCommand2.String = ( ['Loss of lock on base reference point at frame ' num2str(clip) ]);
    elseif( NClips ~= max(find(~isnan(betas(:,1)))) )
        htextCommand1.String = 'Batch processing interrupted.';
        htextCommand2.String = ['Fewer geometry solutions than than input images. Possible ' ...
            'failure in geoometry solution at frame ' num2str(clip)];
    end
    
    htextCommand1.String = 'Saving outputs...';
    pause(0.001)
    
    % Save metadata
    info.time = e0; info.station = inputs.stationStr; info.camera = 'x';
    info.type = 'meta'; info.format = 'mat';
    metaFn = argusFilename(info);
    meta.gcpFn = inputs.gcpFn; meta.gcpList = inputs.gcpList;
    meta.betas = betas;
    meta.CI = CI;
    meta.MSE = MSE;
    save(fullfile(inputs.pncx, metaFn),'meta')
    
    % Save outputs
    folderImages = fullfile(inputs.pncx, 'images');
    folderMat = fullfile(inputs.pncx, 'mat');
    folderGeoms = fullfile(folderImages, 'geometries');
    % create directories if they don't exist
    if ~exist(folderImages)
        mkdir(folderImages)
    end
    if ~exist(folderMat)
        mkdir(folderMat)
    end
    if ~exist(folderGeoms)
        mkdir(folderGeoms)
    end
    
    % Save the image products
    info.type = 'imageProducts';
    info.format = 'mat';
    imageFn = argusFilename(info);
    save(fullfile(folderMat, imageFn), 'finalImages')
    
    % Save instrument data (vBar, runup, cBathy grid)
    unames = unique(r.names);
    
    for i = 1: length(unames)
        label_insts = strcmp(r.names,unames{i});
        
        % save the stack structure 
        foo.xyz = r.cams(1).XYZ(label_insts,:);
        foo.name = unames{i};
        foo.data = stack.data(:,label_insts);
        foo.dn = dn;
        
        % save .mat file
        info.type = unames{i};
        stackFn = argusFilename(info);
        save(fullfile(folderMat, stackFn), 'foo')
        
        % save .png file
        if ~isempty(strfind(unames{i}, 'vBar'))
            
            figure('Name', unames{i}, 'Tag', unames{i}, 'Units', 'normalized')
            imagesc(foo.xyz(:,2), foo.dn, foo.data)
            colormap('gray')
            xlabel('y-alongshore [m]')
            ylabel('GMT time of day')
            datetick('y',13,'keepticks')
            title(unames{i})
            set(gca, 'xdir','reverse')
            
            
            info.type = unames{i};
            info.format = 'jpg';
            fn = argusFilename(info);
            
            set(gcf, 'Position', [0 0 1 1])
            print(gcf, fullfile(folderImages, fn), '-djpeg', '-r300')
            set(gcf, 'Visible', 'off')
            info.format = 'mat';
            
        elseif ~isempty(strfind(unames{i}, 'runup'))
            
            figure('Name', unames{i}, 'Tag', unames{i}, 'Units', 'normalized')
            imagesc(foo.xyz(:,1), foo.dn, foo.data)
            colormap('gray')
            xlabel('x-crossshore [m]')
            ylabel('GMT time of day')
            datetick('y',13,'keepticks')
            title(unames{i})

            info.type = unames{i};
            info.format = 'jpg';
            fn = argusFilename(info);
            
            set(gcf, 'Position', [0 0 1 1])
            print(gcf, fullfile(folderImages, fn), '-djpeg', '-r300')
            set(gcf, 'Visible', 'off')
            info.format = 'mat';
            
        else
            continue
        end
        
    end
    
    % Save snap
    figure('Name', 'Snap', 'Tag', 'Snap', 'Units', 'normalized'); clf
    imagesc(finalImages.snap);
    title(['Snap for ' datestr(finalImages.dn)])
    axis image; grid on
    info.type = 'snap';
    info.format = 'jpg';
    fn = argusFilename(info);
    set(gcf, 'Position', [0 0 1 1]);
    print(gcf, fullfile(folderImages, fn), '-djpeg', '-r300')
    set(gcf, 'Visible', 'off')
    
    % Save timex
    figure('Name', 'Timex', 'Tag', 'Timex', 'Units', 'normalized'); clf
    imagesc(finalImages.x,finalImages.y,finalImages.timex);
    xlabel('x (m)'); ylabel('y (m)'); title(['Timex for ' datestr(finalImages.dn)])
    axis xy;axis image; grid on
    info.type = 'timex';
    info.format = 'jpg';
    fn = argusFilename(info);
    set(gcf, 'Position', [0 0 1 1]);
    print(gcf, fullfile(folderImages, fn), '-djpeg', '-r300')
    set(gcf, 'Visible', 'off')
    
    % Save bright
    figure('Name', 'Max', 'Tag', 'Max', 'Units', 'normalized'); clf
    imagesc(finalImages.x,finalImages.y,finalImages.bright);
    xlabel('x (m)'); ylabel('y (m)'); title(['Max for ' datestr(finalImages.dn)])
    axis xy;axis image; grid on
    info.type = 'max';
    info.format = 'jpg';
    fn = argusFilename(info);
    set(gcf, 'Position', [0 0 1 1]);
    print(gcf, fullfile(folderImages, fn), '-djpeg', '-r300')
    set(gcf, 'Visible', 'off')
    
    % Save dark
    figure('Name', 'Min', 'Tag', 'Min', 'Units', 'normalized'); clf
    imagesc(finalImages.x,finalImages.y,finalImages.dark);
    xlabel('x (m)'); ylabel('y (m)'); title(['Min for ' datestr(finalImages.dn)])
    axis xy;axis image; grid on
    info.type = 'min';
    info.format = 'jpg';
    fn = argusFilename(info);
    set(gcf, 'Position', [0 0 1 1]);
    print(gcf, fullfile(folderImages, fn), '-djpeg', '-r300')
    set(gcf, 'Visible', 'off')
    
    % Plot external camera parameters (betas) with confidence intervals
    
    % Confidence intervals for each variable
    ciX = reshape(CI(:,1,:),2,NClips,[]);
    ciY = reshape(CI(:,2,:),2,NClips,[]);
    ciZ = reshape(CI(:,3,:),2,NClips,[]);
    ciAzimuth = reshape(CI(:,4,:),2,NClips,[])*180/pi;
    ciTilt = reshape(CI(:,5,:),2,NClips,[])*180/pi;
    ciRoll = reshape(CI(:,6,:),2,NClips,[])*180/pi;
    
    
    % Attitudes (Azimuth Tilt Roll)
    attitude = betas(:,[4 5 6])*180/pi; % rad to degrees
    
    % Plot Position
    baricenter = mean(betas(:,[1 2]));
    r_2sigma = 2*sqrt( std(betas(:,1))^2 + std(betas(:,2))^2);
    
    figure('Name', 'UAV Position', 'Tag', 'Position'); clf
    width = 12;
    height = 10;
    margHor = [1.5 1.5];
    margVer = [1.5 1.5];
    gaps = [0 0];
    h = geomplot(1,1,1,1,width,height,margHor,margVer,gaps);
    hold on
    axis equal
    plot(betas(2:end-1,1) - baricenter(1), betas(2:end-1,2) - baricenter(2), 'k.', 'markerfacecolor', 'k', 'markersize', 8, 'DisplayName', 'geoms')
    plot(betas(1,1) - baricenter(1), betas(1,2) - baricenter(2), 'go', 'markerfacecolor', 'g', 'markersize', 3, 'DisplayName', '1st')
    plot(betas(end,1)  - baricenter(1), betas(end,2) - baricenter(2), 'ro', 'markerfacecolor', 'r', 'markersize', 3, 'DisplayName', 'last')
    plot(r_2sigma*cos(0:0.1:2*pi+0.1),r_2sigma*sin(0:0.1:2*pi+0.1), 'b--', 'linewidth', 2.5, 'DisplayName', ' r = 2\sigma')
    xlabel('Eastings [m]','FontSize',10)
    ylabel('Northings [m]','FontSize',10)
    set(gca,'FontSize',10, 'Xgrid', 'on', 'Ygrid', 'on')
    title(['Horizontal movement, \sigma = ' sprintf('%.2f', sqrt( std(betas(:,1))^2 + std(betas(:,2))^2) ) ' m'])
    legend('show')
    % Save position
    info.type = 'UAV_position';
    info.format = 'jpg';
    fn = argusFilename(info);
    set(gcf,'position',[0 0 1 1])
    print(gcf, fullfile(folderGeoms, fn), '-djpeg', '-r300')
    set(gcf, 'Visible', 'off')
    
    % Plot 4 camera extrinsic parameters
    figure('Name', 'UAV Coordinates', 'Tag', 'Coordinates'); clf

    width = 16;
    height = 3;
    margHor = [1.5 1.5];
    margVer = [1.5 1.5];
    gaps = [0 1];
    
    % Plot Z
    h1 = geomplot(4,1,1,1,width,height,margHor,margVer,gaps);
    hold on
    box on
    axis tight
    plot(dn,betas(:,3), 'linestyle','-', 'linewidth', 1, 'color', [0 0 0])
    X_plot  = [dn(2:end), fliplr(dn(2:end))];
    Y_plot  = [ciZ(1,2:end), fliplr(ciZ(2,2:end))];
    fill(X_plot, Y_plot , 1,....
        'facecolor',[0.6 0.6 0.6], ...
        'edgecolor','none', ...
        'facealpha', 0.5);
    axis tight
    grid on
    ylabel('Z [m]')
    datetick('x',13,'keepticks')
    t1 = sprintf('Z coordinate (range = %.2f m)', range(betas(:,3)));
    title(t1)
    
    % Plot Azimuth
    h2 = geomplot(4,1,2,1,width,height,margHor,margVer,gaps);
    hold on
    box on
    axis tight
    plot(dn,betas(:,4)*180/pi, 'linestyle','-', 'linewidth', 1, 'color', [0 0 0])
    X_plot  = [dn(2:end), fliplr(dn(2:end))];
    Y_plot  = [ciAzimuth(1,2:end), fliplr(ciAzimuth(2,2:end))];
    fill(X_plot, Y_plot , 1,....
        'facecolor',[0.6 0.6 0.6], ...
        'edgecolor','none', ...
        'facealpha', 0.5);
    axis tight
    grid on
    ylabel('Azimuth [�]','FontSize',10)
    datetick('x',13,'keepticks')
    t2 = sprintf('Azimuth (range = %.2f �)', range(betas(:,4)*180/pi));
    title(t2)
    
    % Plot tilt
    h3 = geomplot(4,1,3,1,width,height,margHor,margVer,gaps);
    hold on
    box on
    axis tight
    plot(dn,betas(:,5)*180/pi, 'linestyle','-', 'linewidth', 1, 'color', [0 0 0])
    X_plot  = [dn(2:end), fliplr(dn(2:end))];
    Y_plot  = [ciTilt(1,2:end), fliplr(ciTilt(2,2:end))];
    fill(X_plot, Y_plot , 1,....
        'facecolor',[0.6 0.6 0.6], ...
        'edgecolor','none', ...
        'facealpha', 0.5);
    axis tight
    grid on
    ylabel('Tilt [�]')
    datetick('x',13,'keepticks')
    t3 = sprintf('Tilt (range = %.2f �)', range(betas(:,5)*180/pi));
    title(t3)
    
    % Plot roll
    h4 = geomplot(4,1,4,1,width,height,margHor,margVer,gaps);
    hold on
    box on
    axis tight
    plot(dn,betas(:,6)*180/pi, 'linestyle','-', 'linewidth', 1, 'color', [0 0 0])
    X_plot  = [dn(2:end), fliplr(dn(2:end))];
    Y_plot  = [ciRoll(1,2:end), fliplr(ciRoll(2,2:end))];
    fill(X_plot, Y_plot , 1,....
        'facecolor',[0.6 0.6 0.6], ...
        'edgecolor','none', ...
        'facealpha', 0.5);
    axis tight
    grid on
    ylabel('Roll [�]')
    datetick('x',13,'keepticks')
    t4 = sprintf('Roll (range = %.2f �)', range(betas(:,6)*180/pi));
    title(t4)
    xlabel('Time')
    
    % Save coordinates
    info.type = 'UAV_coordinates';
    info.format = 'jpg';
    fn = argusFilename(info);
    set(gcf, 'Position' ,[0 0 1 1])
    print(gcf, fullfile(folderGeoms, fn), '-djpeg', '-r300')
    set(gcf, 'Visible', 'off')
    
    % Plot RMSE
    figure('Name', 'MSE', 'Tag', 'mse'); clf
    
    width = 16;
    height = 4;
    margHor = [1.2 1];
    margVer = [0.5 1.1];
    gaps = [0 1.8];
    
    h10 = geomplot(2,1,1,1,width,height,margHor,margVer,gaps);
    hold on
    axis tight
    box on
    bar(dn,sqrt(MSE),1,'linewidth',0.1,'edgecolor','none','facecolor',[0.4 0.4 0.4])
    xlabel('Time')
    ylabel('RMSE [pixels]')
    datetick('x',13,'keepticks')
    set(gca,'Ygrid','on')
    title('RMSE of residuals for each frame')
    
    h11 = geomplot(2,1,2,1,width,height,margHor,margVer,gaps);
    hHist = histogram(sqrt(MSE));
    hHist.FaceColor = [.4 .4 .4];
    hHist.LineWidth = 0.8;
    hHist.BinWidth = 0.1;
    title('Frequency distribution')
    ylabel('Counts')
    xlabel('RMSE [pixels]')
    grid on
    
    % Save MSE
    info.type = 'RMSE';
    info.format = 'jpg';
    fn = argusFilename(info);
    set(gcf, 'Position', [0 0 1 1])
    print(gcf, fullfile(folderGeoms, fn), '-djpeg', '-r300')
    set(gcf, 'Visible', 'off')
    
    htextCommand1.String = ['Outputs saved in ' inputs.pncx ' .'];
    htextCommand2.String = 'Done.';
    
    % Disable bactch processing button
    hFig1 = findobj('Tag', 'showfigures1');
    hFig1.Enable = 'on';
    hFig2 = findobj('Tag', 'showfigures2');
    hFig2.Enable = 'on';
    
    handles.insts = r;
    handles.meta = meta;
    handles.finalImages = finalImages;
    
    guidata(hObject,handles)
end

function buttonShowFiguresArgus_CallBack(hObject, eventdata)
    handles = guidata(hObject);
      
    % Shows the figures containing Argus-like products
    if handles.plotOn1 == 0
        set(findobj('Tag', 'Snap'), 'Visible', 'on');
        set(findobj('Tag', 'Timex'), 'Visible', 'on');
        set(findobj('Tag', 'Max'), 'Visible', 'on');
        set(findobj('Tag', 'Min'), 'Visible', 'on');
        for i = 1:length(handles.insts)
            set(findobj('Tag', handles.insts(i).shortName), 'Visible', 'on')
        end
        handles.plotOn1 = 1;
    else
        set(findobj('Tag', 'Snap'), 'Visible', 'off');
        set(findobj('Tag', 'Timex'), 'Visible', 'off');
        set(findobj('Tag', 'Max'), 'Visible', 'off');
        set(findobj('Tag', 'Min'), 'Visible', 'off');
        for i = 1:length(handles.insts)
            set(findobj('Tag', handles.insts(i).shortName), 'Visible', 'off')
        end
        handles.plotOn1 = 0;
    end
    
    guidata(hObject,handles)
end

function buttonShowFiguresGeom_CallBack(hObject, eventdata)
    handles = guidata(hObject);
    
    % Shows the figures containing the geometries
    if handles.plotOn2 == 0
        set(findobj('Tag', 'Position'), 'Visible', 'on', 'Units','Normalized','Position',[0.1 0.1 0.7 0.7]);
        set(findobj('Tag', 'Coordinates'), 'Visible', 'on', 'Units','Normalized', 'Position',[0.1 0.1 0.7 0.7]);
        set(findobj('Tag', 'mse'), 'Visible', 'on', 'Units','Normalized','Position',[0.1 0.1 0.7 0.7]);
        handles.plotOn2 = 1;
    else
        set(findobj('Tag', 'Position'), 'Visible', 'off', 'Units','Normalized','Position',[0.1 0.1 0.7 0.7]);
        set(findobj('Tag', 'Coordinates'), 'Visible', 'off', 'Units','Normalized', 'Position',[0.1 0.1 0.7 0.7]);
        set(findobj('Tag', 'mse'), 'Visible', 'off', 'Units','Normalized','Position',[0.1 0.1 0.7 0.7]);
        handles.plotOn2 = 0;
    end
    
    guidata(hObject,handles)
end
