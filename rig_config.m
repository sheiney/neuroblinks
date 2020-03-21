% Rig specific settings
config.ALLOWEDDEVICES = {'arduino', 'teensy'};

% Better to use hash table?
% index into "camera" is camera # for particular rig, index into IDS is rig number
config.camera(1).IDS = {'22820678', '', '', ''};  % DeviceInfo.DeviceName returned from imaqhwinfo
config.camera(2).IDS = {'22486477', '', '', ''}; % DeviceInfo.DeviceName returned from imaqhwinfo

config.camera(1).triggermode = 'Line1';     % camera1
config.camera(2).triggermode = 'Line1'; % camera2
config.camera(1).binning = 2;   % Horizontal and vertical binning for sensor (reduces resolution)
config.camera(2).binning = 2;
config.camera(1).gamma = 1.5;   % Gamma for sensor (1 is linear--no correction)
config.camera(2).gamma = 1.5;

% config.camera(1).roiposition = [480 210 640 512];   % [0 0 640 512] or [0 0 1280 1024]
% config.camera(2).roiposition = [500 240 640 480];   % [0 0 640 480] or [0 0 1280 960]
config.camera(1).roiposition = [0 0 640 512];   % [0 0 640 512] or [0 0 1280 1024]
% config.camera(1).roiposition = [0 0 640 512];   % [0 0 640 512] or [0 0 1280 1024]
% config.camera(2).roiposition = [468 8 640 480];   % [0 0 640 480] or [0 0 1280 960]
config.camera(2).roiposition = [0 0 640 512];   % [0 0 640 480] or [0 0 1280 960]

config.camera(1).fullsize = [0 0 1280 1024];   % [0 0 640 512] or [0 0 1280 1024]
config.camera(2).fullsize = [0 0 1280 1024];   % [0 0 640 480] or [0 0 1280 960]

% Consider making this a per mouse setting
config.camera(1).eyelid_roi = [158 220 178 171];

config.tube_delay(1) = 20;
config.tube_delay(2) = 0;
config.tube_delay(3) = 0;
config.tube_delay(4) = 0;

% Index is rig number
% Arduino Zero
% config.MICROCONTROLLER_IDS = {'2F2E6A78', '3B3B06F1'};
% Teensy
config.MICROCONTROLLER_IDS = {'4362200', '', '', ''};

% For whitenoise devices, typically Teensy 3.2 with audioshield (zero disables)
config.WHITENOISE_DEVICE_IDS = {'', '', '', ''};
% config.WHITENOISE_DEVICE_IDS = {'', '', '', ''};

config.PULSEPAL_IDS = {'2341:003E SER=7', '', '', ''};