function startCamera(n)

cameras = getappdata(0,'cameras');
metadata = getappdata(0,'metadata');
config = getappdata(0, 'config')

src = getselectedsource(cameras(n));

% % Need to set different property here depending on camera capabilities
% if isprop(src, 'FrameStartTriggerSource')
%     src.FrameStartTriggerSource = config.camera(n).triggermode;
% elseif isprop(src, 'TriggerSource')
%     src.TriggerSource = config.camera(n).triggermode;
% else
%     % Do nothing. Camera doesn't have this property?
%     warning('Camera %d does not have Trigger Source property', n)
% end

src.TriggerMode = 'On';

cameras(n).TriggerRepeat = 0;
cameras(n).FramesPerTrigger = metadata.cam(n).frame_rate * (sum(metadata.cam(n).time) / 1e3);

% if strcmp(cameras(n).triggermode,'Manual to disk')
%     % We have to set up the video writer object here 
%     basename = sprintf('%s\\%s_camera%02d', metadata.folder, metadata.basename, n);
%     videoname=sprintf('%s_%03d.mp4', basename, metadata.cam(n).trialnum);
%     diskLogger = VideoWriter(videoname,'MPEG-4');
%     set(diskLogger,'FrameRate',20);
%     cameras(n).DiskLogger = diskLogger;
% else
%     cameras(n).DiskLogger = [];
% end

% cameras(n).StopFcn = {@stopCameraCallback, n};
if n == 1   % Use Camera 1 as master timer of acquisition
    cameras(n).StopFcn = @endOfTrial;
end

flushdata(cameras(n))
start(cameras(n))

% Trigger Trial
%---------------- NEED TO TRIGGER TRIAL HERE --------------------%

