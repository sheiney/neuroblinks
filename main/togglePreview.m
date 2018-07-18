function togglePreview(handles)

cameras = getappdata(0, 'cameras');
metadata = getappdata(0, 'metadata');

% if ~isfield(metadata.cam(1),'fullsize')
%     metadata.cam(1).fullsize = [0 0 640 480];
% end
% metadata.cam(1).camera_ROIposition=camera.ROIposition;

% Start/Stop Camera
if strcmp(get(handles.pushbutton_StartStopPreview, 'String'), 'Start Preview')
    % Camera is off. Change button string and start camera.
    set(handles.pushbutton_StartStopPreview, 'String', 'Stop Preview')
    % Send camera preview to GUI
    for i = 1:length(cameras)

        imx = metadata.cam(i).camera_ROIposition(1) + [1:metadata.cam(i).camera_ROIposition(3)];
        imy = metadata.cam(i).camera_ROIposition(2) + [1:metadata.cam(i).camera_ROIposition(4)];
        handles.pwin{i} = image(imx, imy, zeros(metadata.cam(i).camera_ROIposition([4 3])), 'Parent', handles.cameraAx{i});
        
        preview(cameras{i}, handles.pwin{i});
        set(handles.cameraAx{i}, 'XLim', 0.5 + metadata.cam(i).fullsize([1 3]))
        set(handles.cameraAx{i}, 'YLim', 0.5 + metadata.cam(i).fullsize([2 4]))
        hp = findobj(handles.cameraAx{i},'Tag','roipatch');  delete(hp)

        if isfield(handles,'XY')
            handles.roipatch{i} = patch(handles.XY(:, 1), handles.XY(:, 2), 'g', 'FaceColor', 'none', 'EdgeColor', 'g', 'Tag', 'roipatch');
        end
        
    end

    ht = findobj(handles.cameraAx{1}, 'Tag', 'trialtimecounter');
    delete(ht)
    
    % Put countdown on first preview window
    axes(handles.cameraAx{1})
    handles.trialtimecounter = text(630,470, ' ', 'Color', 'w', 'HorizontalAlignment', 'Right',...
        'VerticalAlignment', 'Bottom', 'Visible', 'Off', 'Tag', 'trialtimecounter',...
        'FontSize', 18);

else
    % Camera is on. Stop camera and change button string.
    stopPreview(handles);
end

setappdata(0,'metadata', metadata);
guidata(hObject, handles))