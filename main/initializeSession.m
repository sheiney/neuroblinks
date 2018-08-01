function initializeSession(config)
% This is executed when user presses the button to start a new session in in the main GUI
% Initializes per session variables, some of which can be loaded from mouse config files

metadata=getappdata(0,'metadata');
cameras=getappdata(0,'cameras');

for i=1:length(cameras)

    metadata.cam(i).trialnum=1;
    metadata.cam(i).thresh=0.125;

    metadata.cam(i).cal=0;
    metadata.cam(i).calib_offset=0;
    metadata.cam(i).calib_scale=1;
    
end

metadata.ts=[datenum(clock) 0]; % two element vector containing datenum at beginning of session and offset of current trial (in seconds) from beginning

setappdata(0, 'metadata', metadata);