function startStreaming(handles)

% Get rid of start/stop streaming and just run newFrameCallback all the time?

set(handles.togglebutton_stream,'String','Stop Streaming')
setappdata(handles.pwin,'UpdatePreviewWindowFcn',@newFrameCallback);
