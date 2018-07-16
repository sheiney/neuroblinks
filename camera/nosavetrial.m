function nosavetrial()
% We set a callback function and trigger camera anyway so we can get instant replay

camera = getappdata(0, 'camera');
% pause(1e-3)
vid = getdata(camera, camera.FramesPerTrigger * (camera.TriggerRepeat + 1));

metadata = getappdata(0, 'metadata');

% Keep data from last trial in memory even if we don't save it to disk
setappdata(0, 'lastvid', vid);
setappdata(0, 'lastmetadata', metadata);

fprintf('Data from last trial saved to memory for review.\n')