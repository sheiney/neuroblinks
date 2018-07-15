% Rig specific settings
config.ALLOWEDDEVICES = {'arduino'};

% Better to use hash table?
config.CAMERA1_IDS = {'acA1300-200um (21794588)', 'acA1300-200um (22486477)'};  % DeviceInfo.DeviceName returned from imaqhwinfo
config.CAMERA2_IDS = {'puA1280-54um (22468628)', 'puA1280-54um (22468629)'}; % DeviceInfo.DeviceName returned from imaqhwinfo
config.MICROCONTROLLER_IDS = {'2F2E6A78', '3B3B06F1'};