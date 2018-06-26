function startCamera(n)

    % NEED TO GENERALIZE TO "N" CAMERAS

cam2 = getappdata(0,'cam2');
metadata = getappdata(0,'metadata');

vidobj2 = getappdata(0,'vidobj2');
src = getselectedsource(vidobj2);

% Changed from 'Line1' to 'FixedRate' on Oct 6, 2017 by Shane
if isprop(src,'FrameStartTriggerSource')
    src.FrameStartTriggerSource = 'Line1';  % Switch from free run to TTL mode
else
    src.TriggerSource = 'Line1';
end

if strcmp(cam2.triggermode,'Manual to disk')
    % We have to set up the video writer object here 
    basename = sprintf('%s\\%s_cam2',metadata.folder,metadata.TDTblockname);
    videoname=sprintf('%s_%03d.mp4', basename, cam2.trialnum);
    diskLogger = VideoWriter(videoname,'MPEG-4');
    set(diskLogger,'FrameRate',20);
    vidobj2.DiskLogger = diskLogger;
else
    vidobj2.DiskLogger = [];
end

vidobj2.StopFcn = @stopCamera2Callback;

flushdata(vidobj2)
start(vidobj2)

% Trigger Trial
%---------------- NEED TO TRIGGER TRIAL HERE --------------------%

cam2.time = etime(clock,datevec(metadata.ts(1)));
setappdata(0,'cam2',cam2);