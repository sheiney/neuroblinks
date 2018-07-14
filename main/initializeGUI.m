function initializeGUI(gui, handles)

metadata=getappdata(0,'metadata');
config=getappdata(0,'config');

metadata.date=date;
metadata.basename='Temp';
metadata.folder=pwd; % For now use current folder as base; will want to change this later

typestring=get(handles.popupmenu_stimtype,'String');
metadata.stim.type=typestring{get(handles.popupmenu_stimtype,'Value')};

% Set ITI using base time plus optional random range
% We have to initialize here because "stream" function uses metadata.stim.c.ITI
base_ITI = str2double(get(handles.edit_ITI,'String'));
rand_ITI = str2double(get(handles.edit_ITI_rand,'String'));
metadata.stim.c.ITI = base_ITI + rand(1,1) * rand_ITI;

metadata.trial_time(1)=str2double(get(handles.edit_pretime,'String'));
metadata.trial_time(2)=str2double(get(handles.edit_posttime,'String'));

config.trial_length_ms = sum(metadata.trial_time);

metadata.cam(1).frame_rate = config.cam(1).FrameRate;
metadata.cam(2).frame_rate = config.cam(2).FrameRate;

% pushbutton_StartStopPreview_Callback(handles.pushbutton_StartStopPreview, [], handles)

% --- init table ----
if isfield(config, 'paramtable')
    set(handles.uitable_params,'Data',config.paramtable.data);
end

setappdata(0, 'metadata', metadata);