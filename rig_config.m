% Rig specific settings
config.ALLOWEDDEVICES = {'arduino', 'teensy'};

% Better to use hash table?
% index into "camera" is camera # for particular rig, index into IDS is rig number
% config.camera(1).IDS = {'acA1300-200um (21794588)', 'acA1300-200um (22486477)'};  % DeviceInfo.DeviceName returned from imaqhwinfo
% config.camera(2).IDS = {'puA1280-54um (22468628)', 'puA1280-54um (22468629)'}; % DeviceInfo.DeviceName returned from imaqhwinfo
config.camera(1).IDS = {'21794588', '22486477', '22798789', '22804685'};  % DeviceInfo.DeviceName returned from imaqhwinfo
config.camera(2).IDS = {'22468628', '22468629', '22804762', '22784550'}; % DeviceInfo.DeviceName returned from imaqhwinfo
config.camera(1).triggermode = 'Line1';     % camera1
config.camera(2).triggermode = 'Software'; % camera2
config.camera(1).binning = 1;   % Horizontal and vertical binning for sensor (reduces resolution)
config.camera(2).binning = 1;

% config.camera(1).roiposition = [480 210 640 512];   % [0 0 640 512] or [0 0 1280 1024]
% config.camera(2).roiposition = [500 240 640 480];   % [0 0 640 480] or [0 0 1280 960]
config.camera(1).roiposition = [528 89 640 512];   % [0 0 640 512] or [0 0 1280 1024]
config.camera(2).roiposition = [468 8 640 480];   % [0 0 640 480] or [0 0 1280 960]

config.camera(1).fullsize = [0 0 1280 1024];   % [0 0 640 512] or [0 0 1280 1024]
config.camera(2).fullsize = [0 0 1280 960];   % [0 0 640 480] or [0 0 1280 960]

% Consider making this a per mouse setting
config.camera(1).eyelid_roi = [401 63 67 58];

config.tube_delay(1) = 20;
config.tube_delay(2) = 20;
config.tube_delay(3) = 20;
config.tube_delay(4) = 20;

% Index is rig number
% Arduino Zero
% config.MICROCONTROLLER_IDS = {'2F2E6A78', '3B3B06F1'};
% Teensy
config.MICROCONTROLLER_IDS = {'4788080', '3580040', '4362910', '0000000'};
% config.MICROCONTROLLER_IDS = {'4788080', '4744650'};