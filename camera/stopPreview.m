function stopPreview(handles)
% Pulled this out as a function so it can be called from elsewhere
cameras=getappdata(0, 'cameras');

set(handles.pushbutton_StartStopPreview,'String','Start Preview')

for i=1:length(cameras)
    closepreview(cameras{i});
end