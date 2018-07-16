function startStreaming(handles)

set(handles.togglebutton_stream,'String','Stop Streaming')
setappdata(handles.pwin,'UpdatePreviewWindowFcn',@newFrameCallback);
