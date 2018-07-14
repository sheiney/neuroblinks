function initializeSession(config)
% This is executed when user presses the button to start a new session in in the main GUI
% Initializes per session variables, some of which can be loaded from mouse config files

metadata=getappdata(0,'metadata');
 
metadata.ts=[datenum(clock) 0]; % two element vector containing datenum at beginning of session and offset of current trial (in seconds) from beginning

metadata.cam.thresh=0.125;
metadata.cam.trialnum=1;
metadata.eye.trialnum1=1;  %  for conditioning
metadata.eye.trialnum2=1;

metadata.cam(1).cal=0;
metadata.cam(1).calib_offset=0;
metadata.cam(1).calib_scale=1;

metadata.cam(2).cal=0;
metadata.cam(2).calib_offset=0;
metadata.cam(2).calib_scale=1;

trials.stimnum=0;
trials.savematadata=0;

setappdata(0, 'metadata', metadata);
setappdata(0,'trials',trials);