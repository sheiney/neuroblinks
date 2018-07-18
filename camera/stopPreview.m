function stopPreview(handles)
% Pulled this out as a function so it can be called from elsewhere
camera=getappdata(0,'camera');

set(handles.pushbutton_StartStopPreview,'String','Start Preview')
closepreview(camera);