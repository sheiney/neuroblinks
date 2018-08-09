% Configuration settings that might be different for different users/computers
% Should be somewhere in path
DEFAULTDEVICE='arduino';
DEFAULTRIG=1;

config.CAMADAPTOR = 'gentl';

% --- camera settings ----
% Need to rework these configuration settings for consistency in naming/numbering different cameras
config.camera(1).initExposureTime=4950;  % Exposure times for the two cameras (e.g., eyelid, pupil)
config.camera(2).initExposureTime=49950;  % Exposure times for the two cameras (e.g., eyelid, pupil)
config.camera(1).FrameRate = 200;   % Frame rates for the two cameras (e.g., eyelid, pupil)
config.camera(2).FrameRate = 20;   % Frame rates for the two cameras (e.g., eyelid, pupil)

