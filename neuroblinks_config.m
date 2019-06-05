% Configuration settings that might be different for different users/computers
% Should be somewhere in path
DEFAULTDEVICE='teensy';
DEFAULTRIG=1;
config.PWM_RESOLUTION = 12;        % Bits of resolution of PWM signal in microcontroller (for LED intensity control)

config.CAMADAPTOR = 'gentl';

% --- camera settings ----
% Need to rework these configuration settings for consistency in naming/numbering different cameras
config.camera(1).initExposureTime=4900;  % Exposure times for the two cameras (e.g., eyelid, pupil)
config.camera(2).initExposureTime=4900;  % Exposure times for the two cameras (e.g., eyelid, pupil)
config.camera(1).FrameRate = 200;   % Frame rates for the two cameras (e.g., eyelid, pupil)
config.camera(2).FrameRate = 200;   % Frame rates for the two cameras (e.g., eyelid, pupil)

