function ok = startSession(handles)

% Initialize session variables
ok = initializeSession;

if ~ok
    return
end

metadata = getappdata(0, 'metadata');
config = getappdata(0, 'config');

% Add cameras and connect
camera = addCam(config.camera(1).IDS{config.rig}, config);
cameras(1) = configureBaslerAce(camera, config);
disp('Camera 1 connected')

metadata.cam(1).ROIposition = cameras(1).ROIposition;
metadata.cam(1).fullsize = config.camera(1).fullsize;


% Connect to microcontroller
[microController, config] = connectMicrocontroller(config);

% % Need to replace togglePreview with a "startPreview" function
% togglePreview(handles)

setappdata(0, 'cameras', cameras)
setappdata(0, 'microController', microController)
setappdata(0, 'metadata', metadata)
setappdata(0, 'config', config)

changeAmbientLEDIntensity(config.AmbientLEDLevel);

drawnow         % Seems necessary to update appdata before returning to calling function

disp('Ready')