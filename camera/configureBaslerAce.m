function camera = configureBaslerAce(camera, config, camera_num)

src = getselectedsource(camera);

src.AcquisitionFrameRate = config.camera(camera_num).FrameRate;   % index 1 is for high speed (eyelid) cam [this is hacky and should change in later version]
src.AcquisitionFrameRateEnable = 'True';

src.ExposureAuto = 'off';
src.ExposureTime = config.camera(camera_num).initExposureTime;

src.SensorReadoutMode = 'Fast';

src.GainAuto = 'off';
src.Gain=0;				% Tweak this based on IR light illumination (lower values preferred due to less noise)

src.BinningHorizontal=config.camera(camera_num).binning;
src.BinningVertical=config.camera(camera_num).binning;
src.BinningHorizontalMode='Sum';    % 'Sum' or 'Average'
src.BinningVerticalMode='Sum';

camera.ROIPosition = config.camera(camera_num).roiposition;

camera.LoggingMode = 'memory'; 
camera.FramesPerTrigger = ceil(config.trial_length_ms / (1000 / config.camera(camera_num).FrameRate));

% triggerconfig(camera, 'hardware', 'DeviceSpecific', 'DeviceSpecific');
% set(src,'AcquisitionStartTriggerMode','on')
% set(src,'FrameStartTriggerSource','Freerun')
% set(src,'AcquisitionStartTriggerActivation','RisingEdge')
% set(src,'AcquisitionStartTriggerSource','Line1')

triggerconfig(camera, 'hardware', 'DeviceSpecific', 'DeviceSpecific');
src.TriggerMode = 'Off';
src.TriggerActivation = 'RisingEdge';
src.TriggerSelector = 'FrameBurstStart';
src.AcquisitionBurstFrameCount = ceil(config.trial_length_ms / (1000 / config.camera(camera_num).FrameRate));    % Note this is limited to 255 frames (see documentation for FrameBurstStart)

% This needs to be toggled to switch between preview and acquisition mode
% It is changed to 'Line1' in MainWindow just before triggering Arduino and then
% back to 'Freerun' in 'endOfTrial' function
% src.FrameStartTriggerSource = 'Line1';
src.TriggerSource = 'Line1';