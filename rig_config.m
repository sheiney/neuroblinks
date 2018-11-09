% Rig specific settings
config.ALLOWEDDEVICES = {'arduino', 'teensy'};

% Better to use hash table?
% index into "camera" is camera # for particular rig, index into IDS is rig number
% config.camera(1).IDS = {'acA1300-200um (21794588)', 'acA1300-200um (22486477)'};  % DeviceInfo.DeviceName returned from imaqhwinfo
% config.camera(2).IDS = {'puA1280-54um (22468628)', 'puA1280-54um (22468629)'}; % DeviceInfo.DeviceName returned from imaqhwinfo
config.camera(1).IDS = {'21794588', '22486477'};  % DeviceInfo.DeviceName returned from imaqhwinfo
config.camera(2).IDS = {'22468628', '22468629'}; % DeviceInfo.DeviceName returned from imaqhwinfo
config.camera(1).triggermode = 'Line1';     % camera1
config.camera(2).triggermode = 'Software'; % camera2
config.camera(1).binning = 1;   % Horizontal and vertical binning for sensor (reduces resolution)
config.camera(2).binning = 1;

config.camera(1).roiposition = [480 210 640 512];   % [0 0 640 512] or [0 0 1280 1024]
config.camera(2).roiposition = [500 240 640 480];   % [0 0 640 480] or [0 0 1280 960]

config.camera(1).fullsize = [0 0 1280 1024];   % [0 0 640 512] or [0 0 1280 1024]
config.camera(2).fullsize = [0 0 1280 960];   % [0 0 640 480] or [0 0 1280 960]

% Consider making this a per mouse setting
config.camera(1).eyelid_roi = [419 97 78 68];

config.tube_delay(1) = 0;
config.tube_delay(2) = 0;

% Index is rig number
% Arduino Zero
% config.MICROCONTROLLER_IDS = {'2F2E6A78', '3B3B06F1'};
% Teensy
config.MICROCONTROLLER_IDS = {'4788080', '4744650'};
% config.MICROCONTROLLER_IDS = {'4135240', '4135250'};
% config.MICROCONTROLLER_IDS = {'4788080', '4135250'};