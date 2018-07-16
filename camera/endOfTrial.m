function endOfTrial(obj, event)
% This function is run when the camera is done collecting frames, then it calls the appropriate 
% function depending on whether or not data should be saved

gui = getappdata(0, 'gui'); 
src = getappdata(0, 'src');

handles = guidata(gui.maingui);

if get(handles.checkbox_record, 'Value') == 1  
    savetrial();
else
    nosavetrial();  
end

% Set camera to freerun mode so we can preview
if isprop(src, 'FrameStartTriggerSource')
    src.FrameStartTriggerSource = 'Freerun';
else
    src.TriggerSource = 'Freerun';
end