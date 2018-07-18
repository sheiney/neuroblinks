function CalibrateEye(obj,event)
%  callback function by video(timer) obj
disp('Delivering puff and saving calibration data.')

camera=getappdata(0,'camera');
metadata=getappdata(0,'metadata');
src=getappdata(0,'src');

[vid, vid_ts]=getdata(camera,camera.FramesPerTrigger*(camera.TriggerRepeat + 1));

% Set camera to freerun mode so we can preview
if isprop(src,'FrameStartTriggerSource')
    src.FrameStartTriggerSource = 'Freerun';
else
    src.TriggerSource = 'Freerun';
end

% --- save data to root app ---
% Keep data from last trial in memory even if we don't save it to disk
setappdata(0,'lastvid',vid);
setappdata(0,'lastmetadata',metadata);
setappdata(0,'calibration_vid',vid);
setappdata(0,'calibration_metadata',metadata);
fprintf('Video from last trial saved to memory for review.\n')

% metadata.stim.type='None';

% --- setting threshold ---H
gui=getappdata(0,'gui');
gui.eyelidThreshold=ThreshWindowWithPuff;
setappdata(0,'gui',gui);
% 
% % Need to allow some time for GUI to draw before we call the lines below
% pause(2)

% Have to do the following 2 lines because we can't call drawhist and
% drawbinary directly from the ThreshWindow opening function since the
% gui struct doesn't exist yet. 
% threshguihandles=guidata(gui.eyelidThreshold);
% ThreshWindowWithPuff('drawbinary',threshguihandles);


