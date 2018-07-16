function stopStreaming(handles)

set(handles.togglebutton_stream,'String','Start Streaming')
setappdata(handles.pwin,'UpdatePreviewWindowFcn',[]);