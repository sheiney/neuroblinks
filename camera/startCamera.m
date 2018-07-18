function startCamera(n)

cameras = getappdata(0,'cameras');
metadata = getappdata(0,'metadata');

src = getselectedsource(cameras{n});

% Need to set different property here depending on camera capabilities
if isprop(src,'FrameStartTriggerSource')
    src.FrameStartTriggerSource = 'Line1';  % Switch from free run to TTL mode
else
    src.TriggerSource = 'Line1';
end

% if strcmp(cameras{n}.triggermode,'Manual to disk')
%     % We have to set up the video writer object here 
%     basename = sprintf('%s\\%s_camera%02d', metadata.folder, metadata.basename, n);
%     videoname=sprintf('%s_%03d.mp4', basename, metadata.cam(n).trialnum);
%     diskLogger = VideoWriter(videoname,'MPEG-4');
%     set(diskLogger,'FrameRate',20);
%     cameras{n}.DiskLogger = diskLogger;
% else
%     cameras{n}.DiskLogger = [];
% end

cameras{n}.StopFcn = {@stopCameraCallback, n};

flushdata(cameras{n})
start(cameras{n})

% Trigger Trial
%---------------- NEED TO TRIGGER TRIAL HERE --------------------%

