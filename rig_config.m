% Rig specific settings
config.ALLOWEDDEVICES = {'arduino', 'teensy'};

% Better to use hash table?
% index into "camera" is camera # for particular rig, index into IDS is rig number
config.camera(1).IDS = {'22798789', '22804685', '22804686', '22486477'};  % DeviceInfo.DeviceName returned from imaqhwinfo
config.camera(2).IDS = {'22468629', '22468628', '22804762', '22784550'}; % DeviceInfo.DeviceName returned from imaqhwinfo

config.camera(1).triggermode = 'Line1';     % camera1
config.camera(2).triggermode = 'Software'; % camera2
config.camera(1).binning = 2;   % Horizontal and vertical binning for sensor (reduces resolution)
config.camera(2).binning = 2;

config.camera(1).thresh = 50/255;
config.camera(2).thresh = 50/255;

% config.camera(1).roiposition = [528 89 640 512];   % [0 0 640 512] or [0 0 1280 1024]
config.camera(1).roiposition = [0 0 640 512];   % [0 0 640 512] or [0 0 1280 1024]
% config.camera(2).roiposition = [468 8 640 480];   % [0 0 640 480] or [0 0 1280 960]
config.camera(2).roiposition = [0 0 640 480];   % [0 0 640 480] or [0 0 1280 960]

config.camera(1).fullsize = [0 0 1280 1024];   % [0 0 640 512] or [0 0 1280 1024]
config.camera(2).fullsize = [0 0 1280 960];   % [0 0 640 480] or [0 0 1280 960]

% Consider making this a per mouse setting
% config.camera(1).eyelid_roi = [401 63 67 58];
config.camera(1).eyelid_roi = [426 149 44 48];

config.tube_delay(1) = 20;
config.tube_delay(2) = 20;
config.tube_delay(3) = 20;
config.tube_delay(4) = 20;

% Index is rig number
% Arduino Zero
% config.MICROCONTROLLER_IDS = {'2F2E6A78', '3B3B06F1'};
% Teensy
config.MICROCONTROLLER_IDS = {'4788080', '3580040', '4362910', '5332140'};

% For whitenoise devices, typically Teensy 3.2 with audioshield (zero disables)
config.WHITENOISE_DEVICE_IDS = {'6615600', '5404780', '5140440', '5139470'};
% config.WHITENOISE_DEVICE_IDS = {'', '', '', ''};