function ok = startSession(handles)

% Initialize session variables
ok = initializeSession;

if ~ok
    return
end

metadata = getappdata(0, 'metadata');
config = getappdata(0, 'config');

% Add cameras and connect
cameras(1) = addCam(config.camera(1).IDS{config.rig}, config);
configureBaslerAce(cameras(1), config);

metadata.cam(1).ROIposition = cameras(1).ROIposition;
metadata.cam(1).fullsize = cameras(1).ROIposition;

cameras(2) = addCam(config.camera(2).IDS{config.rig}, config);
configureBaslerPulse(cameras(2), config);

metadata.cam(2).ROIposition = cameras(2).ROIposition;
metadata.cam(2).fullsize = cameras(2).ROIposition;


% Connect to microcontroller
microController = connectMicrocontroller(config);

% % Need to replace togglePreview with a "startPreview" function
% togglePreview(handles)

setappdata(0, 'cameras', cameras)
setappdata(0, 'microController', microController)
setappdata(0, 'metadata', metadata)

drawnow         % Seems necessary to update appdata before returning to calling function

disp('Ready')