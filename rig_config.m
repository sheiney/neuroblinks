% Rig specific settings
config.ALLOWEDDEVICES = {'arduino'};

% Better to use hash table?
% index into "camera" is camera # for particular rig, index into IDS is rig number
config.camera{1}.IDS = {'acA1300-200um (21794588)', 'acA1300-200um (22486477)'};  % DeviceInfo.DeviceName returned from imaqhwinfo
config.camera{2}.IDS = {'puA1280-54um (22468628)', 'puA1280-54um (22468629)'}; % DeviceInfo.DeviceName returned from imaqhwinfo
config.camera.triggermode = {'Line1', 'Software'}; % camera1, camera2

% Index is rig number
config.MICROCONTROLLER_IDS = {'2F2E6A78', '3B3B06F1'};