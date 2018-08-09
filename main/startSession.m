function ok = startSession()

config = getappdata(0, 'config');
metadata = getappdata(0, 'metadata');

% Initialize session variables
ok = initializeSession(config);

if ~ok
    return
end

% Add cameras and connect
cameras{1} = addCam(config.camera(1).IDS{config.rig}, config);
configureBaslerAce(cameras{1}, config);

metadata.cam(1).ROIposition = cameras{1}.ROIposition;
metadata.cam(1).fullsize = cameras{1}.ROIposition;

cameras{2} = addCam(config.camera(2).IDS{config.rig}, config);
configureBaslerPulse(cameras{2}, config);

metadata.cam(2).ROIposition = cameras{2}.ROIposition;
metadata.cam(2).fullsize = cameras{2}.ROIposition;


% Connect to microcontroller
microController = connectMicrocontroller(config);

setappdata(0, 'cameras', cameras)
setappdata(0, 'microController', microController)
setappdata(0, 'metadata', metadata)