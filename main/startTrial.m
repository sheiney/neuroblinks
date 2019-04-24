function startTrial(handles)

metadata = getappdata(0, 'metadata');
config = getappdata(0, 'config');

microControllerVariablesEnum;

metadata = refreshParams(handles, metadata);
ok = uploadParams(metadata);

if ~ok
    msgbox('Problem communicating with Microcontroller, aborting trial')
    return
end

metadata.ts(2) = etime(clock, datevec(metadata.ts(1)));

% Tell OpenEphys what trial it is
if config.use_open_ephys

    openephys_message = sprintf('Neuroblinks: Trial %03d', metadata.cam(1).trialnum);
    zeroMQrr('Send', config.openephys_url, openephys_message);

end

startCamera(1);
startCamera(2);

% --- trigger via microController --
microController = getappdata(0, 'microController');
fwrite(microController, uController.RUN, 'uint8');

% ---- write status bar ----
% TODO: will need to rewrite this when trial vars start using enum
set(handles.text_status, 'String', sprintf('Total trials: %d\n', metadata.cam(1).trialnum));
if strcmpi(metadata.stim.type, 'conditioning')
    trialvars = readTrialTable(metadata.cam(1).trialnum + 1);
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
        
    str1 = sprintf('Next:  No %d,  CS ch %d%s,  ISI %d,  US %d, US ch %d', metadata.cam(1).trialnum + 1, csnum, str2, isi, usdur, usnum);
    set(handles.text_disp_cond, 'String', str1)
end

setappdata(0, 'metadata', metadata);

drawnow         % Seems necessary to update appdata before returning to calling function