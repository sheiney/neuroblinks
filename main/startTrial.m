function startTrial(handles)

microControllerVariablesEnum;

refreshParams(handles)
uploadParams()
metadata = getappdata(0, 'metadata');

metadata.ts(2) = etime(clock, datevec(metadata.ts(1)));

% --- trigger via microController --
microController = getappdata(0, 'microController');
fwrite(microController, uController.RUN, 'int8');

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