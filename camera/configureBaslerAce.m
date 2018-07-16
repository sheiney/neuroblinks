function configureBaslerAce(camera, config)

src = getselectedsource(camera);

src.AcquisitionFrameRate = config.cam(1).FrameRate;   % index 1 is for high speed (eyelid) cam [this is hacky and should change in later version]

src.ExposureAuto = 'off';
src.ExposureTime = config.cam(1).ExposureTime;

src.GainAuto = 'off'
src.Gain=0;				% Tweak this based on IR light illumination (lower values preferred due to less noise)

camera.LoggingMode = 'memory'; 
camera.FramesPerTrigger = ceil(config.trial_length_ms / (1000 / config.cam(1).FrameRate));

% triggerconfig(camera, 'hardware', 'DeviceSpecific', 'DeviceSpecific');
% set(src,'AcquisitionStartTriggerMode','on')
% set(src,'FrameStartTriggerSource','Freerun')
% set(src,'AcquisitionStartTriggerActivation','RisingEdge')
% set(src,'AcquisitionStartTriggerSource','Line1')

triggerconfig(camera, 'hardware', 'DeviceSpecific', 'DeviceSpecific');
src.TriggerMode = 'On';
src.TriggerActivation = 'LevelHigh';

% This needs to be toggled to switch between preview and acquisition mode
% It is changed to 'Line1' in MainWindow just before triggering Arduino and then
% back to 'Freerun' in 'endOfTrial' function
% src.FrameStartTriggerSource = 'Line1';
src.TriggerSource = 'Freerun';