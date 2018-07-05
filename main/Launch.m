function launch(config)

% Load local configuration for these rigs
rig_config;
user_config;

%% Initialize Camera
% initCam(cam, metadata.cam.recdur); % src and vidobj are now saved as root app data so no global vars




%% Open GUI
clear MainWindow;    % Need to do this to clear persisent variables defined within MainWindow and subfunctions
ghandles.maingui=MainWindow;
set(ghandles.maingui,'units','pixels')
set(ghandles.maingui,'position',[ghandles.pos_mainwin ghandles.size_mainwin])

% Save handles to root app data
setappdata(0,'ghandles',ghandles)



