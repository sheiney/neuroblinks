function startTrial(handles)

refreshParams(handles)
updateParams()
metadata = getappdata(0, 'metadata');
camera = getappdata(0, 'camera');
src = getappdata(0, 'src');
camera.TriggerRepeat = 0;

camera.StopFcn = @endOfTrial;

flushdata(camera); % Remove any data from buffer before triggering

% Set camera to hardware trigger mode
src.FrameStartTriggerSource = 'Line1';
camera.FramesPerTrigger = metadata.cam.fps * (sum(metadata.cam.time) / 1e3);

% Now get camera ready for acquisition -- shouldn't start yet
start(camera)

% For triggering camera 2
if isappdata(0, 'cam2')
    cam2 = getappdata(0, 'cam2');
    camera2 = getappdata(0, 'camera2');
    if strcmp(cam2.triggermode, 'Sync trials')
        camera2.FramesPerTrigger = frames_per_trial;
%         camera2.TriggerRepeat = 0;
        startCamera2()  % will wait for primary camera to be triggered before actually triggering the camera
    end
end

metadata.ts(2) = etime(clock, datevec(metadata.ts(1)));


% --- trigger via arduino --
arduino = getappdata(0, 'arduino');
fwrite(arduino, 1, 'int8');

% ---- write status bar ----
trials = getappdata(0, 'trials');
set(handles.text_status, 'String', sprintf('Total trials: %d\n', metadata.cam.trialnum));
if strcmpi(metadata.stim.type, 'conditioning')
    trialvars = readTrialTable(metadata.cam.trialnum + 1);
    csdur = trialvars(1);
    csnum = trialvars(2);
    isi = trialvars(3);
    usdur = trialvars(4);
    usnum = trialvars(5);
    cstone = str2num(get(handles.edit_tone, 'String'));
    if length(cstone) < 2, cstone(2) = 0; end
    
    str2 = [];
    if ismember(csnum, [5 6])
        str2 = [' (' num2str(cstone(csnum - 4)) ' KHz)'];
    end
        
    str1 = sprintf('Next:  No %d,  CS ch %d%s,  ISI %d,  US %d, US ch %d', metadata.cam.trialnum + 1, csnum, str2, isi, usdur, usnum);
    set(handles.text_disp_cond, 'String', str1)
end
setappdata(0, 'metadata', metadata);