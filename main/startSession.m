function startSession()

config = getappdata(0, 'config');

% Initialize session variables
initializeSession(config);

% Add cameras and connect
cameras{1} = addCam(config.CAMERA1_IDS{config.rig}, config);
configureBaslerAce(cameras{1}, config);
 % Start preview in new window

cameras{2} = addCam(config.CAMERA2_IDS{config.rig}, config);
configureBaslerPulse(cameras{2}, config);
 % Start preview in new window

% Connect to microcontroller
microController = connectMicrocontroller(config);

setappdata(0, 'cameras', cameras)
setappdata(0, 'microController', microController)