function togglePreview(handles)

camera=getappdata(0,'camera');
metadata=getappdata(0,'metadata');

if ~isfield(metadata.cam(1),'fullsize')
    metadata.cam(1).fullsize = [0 0 640 480];
end
metadata.cam(1).camera_ROIposition=camera.ROIposition;

% Start/Stop Camera
if strcmp(get(handles.pushbutton_StartStopPreview,'String'),'Start Preview')
    % Camera is off. Change button string and start camera.
    set(handles.pushbutton_StartStopPreview,'String','Stop Preview')
    % Send camera preview to GUI
    imx=metadata.cam(1).camera_ROIposition(1)+[1:metadata.cam(1).camera_ROIposition(3)];
    imy=metadata.cam(1).camera_ROIposition(2)+[1:metadata.cam(1).camera_ROIposition(4)];
    handles.pwin=image(imx,imy,zeros(metadata.cam(1).camera_ROIposition([4 3])), 'Parent',handles.cameraAx);
    
    preview(camera,handles.pwin);
    set(handles.cameraAx,'XLim', 0.5+metadata.cam(1).fullsize([1 3])),
    set(handles.cameraAx,'YLim', 0.5+metadata.cam(1).fullsize([2 4])),
    hp=findobj(handles.cameraAx,'Tag','roipatch');  delete(hp)
    if isfield(handles,'XY')
        handles.roipatch=patch(handles.XY(:,1),handles.XY(:,2),'g','FaceColor','none','EdgeColor','g','Tag','roipatch');
    end
    
    ht=findobj(handles.cameraAx,'Tag','trialtimecounter');
    delete(ht)
    
    axes(handles.cameraAx)
    handles.trialtimecounter = text(630,470,' ','Color','w','HorizontalAlignment','Right',...
        'VerticalAlignment', 'Bottom', 'Visible', 'Off', 'Tag', 'trialtimecounter',...
        'FontSize',18);
else
    % Camera is on. Stop camera and change button string.
    stopPreview(handles);
end

setappdata(0,'metadata',metadata);
guidata(hObject,handles))