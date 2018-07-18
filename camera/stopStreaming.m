function stopStreaming(handles)

% Get rid of start/stop streaming and just run newFrameCallback all the time?

set(handles.togglebutton_stream,'String','Start Streaming')
setappdata(handles.pwin,'UpdatePreviewWindowFcn',[]);