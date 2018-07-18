function configureBaslerPulse(camera, config)

src = getselectedsource(camera);

src.AcquisitionFrameRate = config.cam(2).FrameRate;   % index 1 is for high speed (eyelid) cam [this is hacky and should change in later version]

src.ExposureAuto = 'off';
src.ExposureTime = config.cam(2).ExposureTime;

src.GainAuto = 'off';
src.Gain=0;				% Tweak this based on IR light illumination (lower values preferred due to less noise)

camera.LoggingMode = 'memory'; 
camera.FramesPerTrigger = ceil(config.trial_length_ms / (1000 / config.cam(2).FrameRate));

triggerconfig(camera, 'Immediate', 'none', 'none');
src.TriggerMode = 'On';
src.TriggerActivation = 'RisingEdge';

src.TriggerSource = 'Software';