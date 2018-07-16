function CalbEye(obj,event)
%  callback function by video(timer) obj
disp('Delivering puff and saving calibration data.')

camera=getappdata(0,'camera');
metadata=getappdata(0,'metadata');
src=getappdata(0,'src');

data=getdata(camera,camera.FramesPerTrigger*(camera.TriggerRepeat + 1));

% Set camera to freerun mode so we can preview
if isprop(src,'FrameStartTriggerSource')
    src.FrameStartTriggerSource = 'Freerun';
else
    src.TriggerSource = 'Freerun';
end

% --- save data to root app ---
% Keep data from last trial in memory even if we don't save it to disk
setappdata(0,'lastdata',data);
setappdata(0,'lastmetadata',metadata);
setappdata(0,'calb_data',data);
setappdata(0,'calb_metadata',metadata);
fprintf('Data from last trial saved to memory for review.\n')

% metadata.stim.type='None';

% --- setting threshold ---
gui=getappdata(0,'gui');
gui.threshgui2=ThreshWindowWithPuff;
setappdata(0,'gui',gui);
% 
% % Need to allow some time for GUI to draw before we call the lines below
% pause(2)

% Have to do the following 2 lines because we can't call drawhist and
% drawbinary directly from the ThreshWindow opening function since the
% gui struct doesn't exist yet. 
% threshguihandles=guidata(gui.threshgui2);
% ThreshWindowWithPuff('drawbinary',threshguihandles);


